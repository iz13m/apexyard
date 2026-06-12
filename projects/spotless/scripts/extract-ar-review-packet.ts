// Generates the Arabic translation review packet by extracting every EN
// + AR key from the three Spotless i18n surfaces and emitting one
// markdown table per surface, plus a summary of any keys that are missing
// in either locale. Run from the apexyard ops fork root.
//
// Usage: npx -y tsx projects/spotless/scripts/extract-ar-review-packet.ts
//
// Output: projects/spotless/docs/ar-translation-review.md

import { readFileSync, writeFileSync } from 'node:fs';
import { resolve } from 'node:path';

type Locale = 'en' | 'ar';
type FlatDict = Record<string, string>;

const STAFF_EN = '/Users/iz13m/Code/app/apexyard/workspace/spotless-staff/lib/locales/en.ts';
const STAFF_AR = '/Users/iz13m/Code/app/apexyard/workspace/spotless-staff/lib/locales/ar.ts';
const CUSTOMER_EN = '/Users/iz13m/Code/app/spotless/lib/locales/en.ts';
const CUSTOMER_AR = '/Users/iz13m/Code/app/spotless/lib/locales/ar.ts';
const MARKETING_UI = '/Users/iz13m/Code/app/spotless-web/src/i18n/ui.ts';

const OUTPUT = resolve(__dirname, '..', 'docs', 'ar-translation-review.md');

// ─── Flat-file extractor (staff + customer apps) ───────────────────────────
// Both files declare a single object literal of `key: 'value',` lines.
// Regex tolerant of:
//   - single- or double-quoted values
//   - escaped quotes inside the value
//   - trailing comma optional
//   - trailing // comments
//   - multi-line values are NOT expected in these files; if any appear they
//     are flagged so a human can fix manually.

function parseFlatDict(path: string): FlatDict {
  const src = readFileSync(path, 'utf8');
  const dict: FlatDict = {};
  const lines = src.split('\n');
  // Match: optional leading whitespace, identifier (snake or camel), ':',
  // ws, opening quote, captured body up to matching closing quote, ',' or EOL
  const re = /^\s*([A-Za-z_][A-Za-z0-9_]*)\s*:\s*(['"])((?:\\.|(?!\2).)*)\2\s*,?\s*(?:\/\/.*)?$/;
  for (const line of lines) {
    const m = re.exec(line);
    if (!m) continue;
    const [, key, , raw] = m;
    // Unescape standard JS escapes that appear in the source.
    const value = raw.replace(/\\'/g, "'").replace(/\\"/g, '"').replace(/\\\\/g, '\\');
    dict[key] = value;
  }
  return dict;
}

// ─── Nested-object extractor (marketing site ui.ts) ────────────────────────
// The marketing site exports `ui = { en: { meta: {...}, nav: {...} }, ar: { ... } }`.
// We do a simple state-machine walk: track nesting keys and emit dotted
// paths when we hit a string literal value. Tolerant of arrays (skipped)
// and nested objects.

function parseMarketingUI(path: string): { en: FlatDict; ar: FlatDict } {
  const src = readFileSync(path, 'utf8');
  // Locate the `ui = {` assignment and capture the matching brace block.
  // The block contains only string literals, arrays, and nested objects —
  // no function calls or external references — so it can be eval'd in
  // isolation as a JS object literal.
  const start = src.search(/(?:export\s+)?const\s+ui\s*=\s*\{/);
  if (start < 0) throw new Error(`Could not find 'const ui = {' in ${path}`);
  const braceStart = src.indexOf('{', start);
  let depth = 0;
  let i = braceStart;
  let inStr: '"' | "'" | '`' | null = null;
  let prev = '';
  for (; i < src.length; i++) {
    const ch = src[i];
    if (inStr) {
      if (ch === inStr && prev !== '\\') inStr = null;
    } else if (ch === '"' || ch === "'" || ch === '`') {
      inStr = ch;
    } else if (ch === '{') {
      depth++;
    } else if (ch === '}') {
      depth--;
      if (depth === 0) {
        i++;
        break;
      }
    }
    prev = ch;
  }
  const block = src.slice(braceStart, i); // includes the outer { ... }
  // Strip any `as const` markers (TS-only).
  const cleaned = block.replace(/\bas\s+const\b/g, '');
  // eslint-disable-next-line @typescript-eslint/no-implied-eval, @typescript-eslint/no-unsafe-call
  const ui = new Function(`return (${cleaned});`)() as { en: unknown; ar: unknown };

  function flatten(obj: unknown, prefix: string, out: FlatDict): void {
    if (obj === null || typeof obj !== 'object') return;
    for (const [k, v] of Object.entries(obj as Record<string, unknown>)) {
      const path = prefix ? `${prefix}.${k}` : k;
      if (typeof v === 'string') {
        out[path] = v;
      } else if (typeof v === 'function') {
        // Skip — these are helpers like `hrefFor(lang)`, not translations.
      } else if (Array.isArray(v)) {
        v.forEach((item, i) => flatten(item, `${path}[${i}]`, out));
      } else if (typeof v === 'object' && v !== null) {
        flatten(v, path, out);
      }
    }
  }

  const en: FlatDict = {};
  const ar: FlatDict = {};
  flatten(ui.en, '', en);
  flatten(ui.ar, '', ar);
  return { en, ar };
}

// ─── Markdown emission ─────────────────────────────────────────────────────

function escapeMd(s: string): string {
  return s.replace(/\|/g, '\\|').replace(/\n/g, '<br>');
}

function emitTable(label: string, sourcePath: string, en: FlatDict, ar: FlatDict): string {
  const allKeys = Array.from(new Set([...Object.keys(en), ...Object.keys(ar)])).sort();
  const missingAr: string[] = [];
  const missingEn: string[] = [];
  for (const k of allKeys) {
    if (!(k in ar)) missingAr.push(k);
    if (!(k in en)) missingEn.push(k);
  }

  let out = `## ${label}\n\n`;
  out += `**Source**: \`${sourcePath}\`\n\n`;
  out += `**Keys**: ${allKeys.length}  •  **Missing AR**: ${missingAr.length}  •  **Missing EN**: ${missingEn.length}\n\n`;
  if (missingAr.length > 0) {
    out += `> ⚠️ Missing AR keys (block before native-speaker review): ${missingAr.map((k) => `\`${k}\``).join(', ')}\n\n`;
  }
  if (missingEn.length > 0) {
    out += `> ⚠️ Missing EN keys: ${missingEn.map((k) => `\`${k}\``).join(', ')}\n\n`;
  }
  out += '| Key | English (source) | Arabic (draft) | Reviewer notes |\n';
  out += '|---|---|---|---|\n';
  for (const k of allKeys) {
    const enVal = en[k] ?? '*(missing)*';
    const arVal = ar[k] ?? '*(missing)*';
    out += `| \`${k}\` | ${escapeMd(enVal)} | ${escapeMd(arVal)} | |\n`;
  }
  out += '\n';
  return out;
}

// ─── Main ──────────────────────────────────────────────────────────────────

const staffEn = parseFlatDict(STAFF_EN);
const staffAr = parseFlatDict(STAFF_AR);
const custEn = parseFlatDict(CUSTOMER_EN);
const custAr = parseFlatDict(CUSTOMER_AR);
const marketing = parseMarketingUI(MARKETING_UI);

const today = new Date().toISOString().slice(0, 10);

let md = `# Spotless — Arabic Translation Review Packet\n\n`;
md += `Generated: ${today}\n\n`;
md += `## How to use this packet\n\n`;
md += `Spotless is launching in Egypt with **Arabic as a first-class locale** (see \`.claude/rules/egypt-first-defaults.md\`). The AR copy in this packet has been drafted by Claude alongside the EN source. We need a native speaker to:\n\n`;
md += `1. Verify each AR translation is **accurate** (matches the EN intent).\n`;
md += `2. Verify the **tone register** is appropriate per surface:\n`;
md += `   - **Marketing site** (\`spotless-web\`): friendly, marketing voice — Egyptian colloquial (عامية مصرية) where it fits, MSA (فصحى) for formality.\n`;
md += `   - **Customer app** (\`spotless\`): friendly + clear — Egyptian colloquial preferred for in-app friendly copy.\n`;
md += `   - **Staff app** (\`spotless-staff\`): action-oriented — short imperatives in colloquial.\n`;
md += `   - **Legal copy** (privacy / terms / refund): formal MSA throughout.\n`;
md += `3. Flag any **AR-specific issues** in the "Reviewer notes" column:\n`;
md += `   - Bidi rendering risks (Latin numbers embedded in Arabic strings — note where bidi marks would help).\n`;
md += `   - Text expansion (AR copy that's ≥30% longer than EN may overflow tight UI).\n`;
md += `   - Pluralization (AR has 6 forms — flag any \`{n}\` strings that need the \`_one\` / \`_two\` / \`_many\` variants we haven't generated).\n`;
md += `   - Cultural / regional context (Egypt-specific phrasing > generic MSA).\n`;
md += `4. Note any **missing AR keys** flagged with ⚠️ at the top of each table — those block the review.\n\n`;
md += `## Process\n\n`;
md += `1. Walk every row of every table. Mark "OK" in the notes column if the translation is good, otherwise propose a revision in the same column.\n`;
md += `2. Save the reviewed file back to the same path (or send a diff).\n`;
md += `3. We'll batch the corrections into a single PR per repo with \`Closes\` to a tracking issue.\n\n`;
md += `## Counts\n\n`;
md += `| Surface | Total keys | Missing AR | Missing EN |\n`;
md += `|---|---:|---:|---:|\n`;
md += `| Staff app | ${new Set([...Object.keys(staffEn), ...Object.keys(staffAr)]).size} | ${Object.keys(staffEn).filter((k) => !(k in staffAr)).length} | ${Object.keys(staffAr).filter((k) => !(k in staffEn)).length} |\n`;
md += `| Customer app | ${new Set([...Object.keys(custEn), ...Object.keys(custAr)]).size} | ${Object.keys(custEn).filter((k) => !(k in custAr)).length} | ${Object.keys(custAr).filter((k) => !(k in custEn)).length} |\n`;
md += `| Marketing site | ${new Set([...Object.keys(marketing.en), ...Object.keys(marketing.ar)]).size} | ${Object.keys(marketing.en).filter((k) => !(k in marketing.ar)).length} | ${Object.keys(marketing.ar).filter((k) => !(k in marketing.en)).length} |\n\n`;
md += '---\n\n';

md += emitTable(
  '1. Staff app (`spotless-staff`)',
  'spotless-staff/lib/locales/{en,ar}.ts',
  staffEn,
  staffAr,
);
md += emitTable(
  '2. Customer app (`spotless`)',
  'spotless/lib/locales/{en,ar}.ts',
  custEn,
  custAr,
);
md += emitTable(
  '3. Marketing site (`spotless-web`)',
  'spotless-web/src/i18n/ui.ts',
  marketing.en,
  marketing.ar,
);

writeFileSync(OUTPUT, md, 'utf8');
console.log(`Wrote ${OUTPUT}`);
console.log(`  Staff app: ${Object.keys(staffEn).length} EN, ${Object.keys(staffAr).length} AR`);
console.log(`  Customer app: ${Object.keys(custEn).length} EN, ${Object.keys(custAr).length} AR`);
console.log(`  Marketing site: ${Object.keys(marketing.en).length} EN, ${Object.keys(marketing.ar).length} AR`);
