# Spotless — Arabic Translation Review Packet

Generated: 2026-05-22

## How to use this packet

Spotless is launching in Egypt with **Arabic as a first-class locale** (see `.claude/rules/egypt-first-defaults.md`). The AR copy in this packet has been drafted by Claude alongside the EN source. We need a native speaker to:

1. Verify each AR translation is **accurate** (matches the EN intent).
2. Verify the **tone register** is appropriate per surface:
   - **Marketing site** (`spotless-web`): friendly, marketing voice — Egyptian colloquial (عامية مصرية) where it fits, MSA (فصحى) for formality.
   - **Customer app** (`spotless`): friendly + clear — Egyptian colloquial preferred for in-app friendly copy.
   - **Staff app** (`spotless-staff`): action-oriented — short imperatives in colloquial.
   - **Legal copy** (privacy / terms / refund): formal MSA throughout.
3. Flag any **AR-specific issues** in the "Reviewer notes" column:
   - Bidi rendering risks (Latin numbers embedded in Arabic strings — note where bidi marks would help).
   - Text expansion (AR copy that's ≥30% longer than EN may overflow tight UI).
   - Pluralization (AR has 6 forms — flag any `{n}` strings that need the `_one` / `_two` / `_many` variants we haven't generated).
   - Cultural / regional context (Egypt-specific phrasing > generic MSA).
4. Note any **missing AR keys** flagged with ⚠️ at the top of each table — those block the review.

## Process

1. Walk every row of every table. Mark "OK" in the notes column if the translation is good, otherwise propose a revision in the same column.
2. Save the reviewed file back to the same path (or send a diff).
3. We'll batch the corrections into a single PR per repo with `Closes` to a tracking issue.

## Counts

| Surface | Total keys | Missing AR | Missing EN |
|---|---:|---:|---:|
| Staff app | 115 | 0 | 0 |
| Customer app | 596 | 0 | 0 |
| Marketing site | 124 | 0 | 0 |

---

## 1. Staff app (`spotless-staff`)

**Source**: `spotless-staff/lib/locales/{en,ar}.ts`

**Keys**: 115  •  **Missing AR**: 0  •  **Missing EN**: 0

| Key | English (source) | Arabic (draft) | Reviewer notes |
|---|---|---|---|
| `assignment_accepted` | Accepted | مقبول | |
| `assignment_arrived` | Arrived | وصلت | |
| `assignment_assigned` | Assigned | مُسند | |
| `assignment_cancelled` | Cancelled | ملغي | |
| `assignment_completed` | Completed | مكتمل | |
| `assignment_en_route` | En route | في الطريق | |
| `assignment_no_show` | No-show | لم يحضر | |
| `assignment_reassigned` | Reassigned | أُعيد إسناده | |
| `assignment_rejected` | Rejected | مرفوض | |
| `back` | ‹ Back | رجوع › | |
| `cancel` | Cancel | إلغاء | |
| `customer_placeholder` | Customer | العميل | |
| `driver_actionFailed` | Action failed | فشل تنفيذ الإجراء | |
| `driver_action_endRoute` | End route | إنهاء الجولة | |
| `driver_action_startRoute` | Start route | بدء الجولة | |
| `driver_crew_section` | Crew | الطاقم | |
| `driver_emptyTitle` | No route assigned | لا يوجد خط سير مسند | |
| `driver_loadFailed` | Couldn’t load your route | تعذّر تحميل خط سيرك | |
| `driver_noCrew` | No crew assigned yet. | لم يُسند طاقم بعد. | |
| `driver_relativity_past` | Past | سابق | |
| `driver_relativity_today` | Today | اليوم | |
| `driver_relativity_upcoming` | Upcoming | قادم | |
| `driver_routeStatus_cancelled` | Cancelled | ملغي | |
| `driver_routeStatus_completed` | Completed | مكتمل | |
| `driver_routeStatus_dispatched` | Dispatched | مُرسل | |
| `driver_routeStatus_in_progress` | In progress | قيد التنفيذ | |
| `driver_routeStatus_planned` | Planned | مخطط | |
| `driver_stopLabel` | Stop {n} | المحطة {n} | |
| `driver_stops_section` | Stops | المحطات | |
| `driver_terminal_cancelled` | Route cancelled. | الجولة ملغاة. | |
| `driver_terminal_completed` | Route complete. | الجولة مكتملة. | |
| `driver_terminal_planned` | Waiting for ops to dispatch this route. | في انتظار إرسال الإدارة لهذه الجولة. | |
| `driver_vehicle_seats_many` | {n} seats | {n} مقاعد | |
| `driver_vehicle_seats_one` | {n} seat | مقعد واحد | |
| `driver_vehicle_section` | Your vehicle | مركبتك | |
| `driver_vehicle_unknown` | Vehicle details not on file. Check with ops. | بيانات المركبة غير متوفرة. راجع الإدارة. | |
| `driver_window` | Window | النافذة | |
| `job_actionFailed` | Action failed | فشل تنفيذ الإجراء | |
| `job_actionNotOpened` | Can’t open | تعذّر الفتح | |
| `job_action_arrived` | I've arrived | لقد وصلت | |
| `job_action_call` | Call | اتصال | |
| `job_action_markAccepted` | Mark accepted | تأكيد القبول | |
| `job_action_markCompleted` | Mark completed | تأكيد الإنهاء | |
| `job_action_onTheWay` | I'm on the way | أنا في الطريق | |
| `job_action_whatsapp` | WhatsApp | واتساب | |
| `job_loadFailed` | Couldn’t load this job | تعذّر تحميل هذه المهمة | |
| `job_noAssignment` | No assignment | لا يوجد إسناد | |
| `job_notFound` | Booking not found. | الحجز غير موجود. | |
| `job_section_address` | Address | العنوان | |
| `job_section_customer` | Customer | العميل | |
| `job_section_notes` | Notes | ملاحظات | |
| `job_section_status` | Your status | حالتك | |
| `job_terminal_completed` | This job is complete. | هذه المهمة مكتملة. | |
| `job_terminal_other` | Status: {status} — no further action. | الحالة: {status} — لا توجد إجراءات إضافية. | |
| `leaveReason_family_emergency` | Family emergency | ظرف عائلي | |
| `leaveReason_other` | Other | أخرى | |
| `leaveReason_planned_vacation` | Planned vacation | إجازة مخطّطة | |
| `leaveReason_sick` | Sick | مرض | |
| `leaveReason_travel` | Travel | سفر | |
| `leaveStatus_approved` | Approved | مقبول | |
| `leaveStatus_cancelled` | Cancelled | ملغي | |
| `leaveStatus_denied` | Denied | مرفوض | |
| `leaveStatus_pending` | Pending | قيد المراجعة | |
| `leave_apply` | Apply for leave | طلب إجازة | |
| `leave_cancelConfirm` | Cancel request | إلغاء الطلب | |
| `leave_cancelFailed` | Couldn’t cancel | تعذّر الإلغاء | |
| `leave_cancelKeep` | Keep | احتفاظ | |
| `leave_cancelTitle` | Cancel this request? | إلغاء هذا الطلب؟ | |
| `leave_error_invalid` | Please enter dates in YYYY-MM-DD format. | الرجاء إدخال التواريخ بتنسيق YYYY-MM-DD. | |
| `leave_error_pastStart` | Start date must be today or later. | يجب أن يكون تاريخ البداية اليوم أو لاحقًا. | |
| `leave_form_endDate` | End date | تاريخ النهاية | |
| `leave_form_noteOptional` | Note (optional) | ملاحظة (اختياري) | |
| `leave_form_notePlaceholder` | Anything ops should know | أي شيء يحتاج الإدارة معرفته | |
| `leave_form_reason` | Reason | السبب | |
| `leave_form_startDate` | Start date | تاريخ البداية | |
| `leave_form_submit` | Submit request | تقديم الطلب | |
| `leave_form_submitFailed` | Couldn’t submit | تعذّر التقديم | |
| `leave_form_title` | Apply for leave | طلب إجازة | |
| `leave_loadFailed` | Couldn’t load your requests | تعذّر تحميل طلباتك | |
| `leave_opsPrefix` | Ops:  | من الإدارة:  | |
| `leave_title` | Leave | الإجازات | |
| `leave_yourRequests` | Your requests | طلباتك | |
| `loadingFailed` | Couldn’t load your jobs | تعذّر تحميل المهام | |
| `performance_jobsLabel_many` | {n} completed jobs | {n} مهمة مكتملة | |
| `performance_jobsLabel_one` | {n} completed job | {n} مهمة مكتملة | |
| `performance_loadFailed` | Couldn’t load your stats | تعذّر تحميل إحصاءاتك | |
| `performance_recentReviews` | Recent reviews | آخر التقييمات | |
| `performance_title` | Performance | الأداء | |
| `role_cleaner` | Cleaner | عاملة نظافة | |
| `role_driver` | Driver | سائق | |
| `settings_language` | Language | اللغة | |
| `settings_languageRestart_ok` | OK | حسنًا | |
| `settings_languageRestart_title` | Restart required | يجب إعادة التشغيل | |
| `settings_title` | Settings | الإعدادات | |
| `signIn_button` | Sign in | تسجيل الدخول | |
| `signIn_email` | Email | البريد الإلكتروني | |
| `signIn_failed` | Sign in failed | فشل تسجيل الدخول | |
| `signIn_password` | Password | كلمة المرور | |
| `signIn_subtitle` | Sign in to your driver or cleaner account. | سجّل دخولك بحساب السائق أو عاملة النظافة. | |
| `signIn_title` | Spotless Staff | Spotless للعاملين | |
| `signOut` | Sign out | تسجيل الخروج | |
| `status_cancelled` | Cancelled | ملغي | |
| `status_completed` | Completed | مكتمل | |
| `status_en_route` | En route | في الطريق | |
| `status_in_progress` | In progress | قيد التنفيذ | |
| `status_rescheduled` | Rescheduled | أُعيد جدولته | |
| `status_scheduled` | Scheduled | مجدول | |
| `today_crew_solo` | Solo | بمفردك | |
| `today_crew_with` | You + {n} | أنت + {n} | |
| `today_empty_today` | No jobs today — enjoy the break. | لا توجد مهام اليوم — استمتع بالراحة. | |
| `today_empty_tomorrow` | Nothing scheduled for tomorrow. | لا يوجد جدول للغد. | |
| `today_role_assistant` | Assistant | مساعد | |
| `today_role_lead` | Lead | القائد | |
| `today_section_today` | Today | اليوم | |
| `today_section_tomorrow` | Tomorrow | غدًا | |

## 2. Customer app (`spotless`)

**Source**: `spotless/lib/locales/{en,ar}.ts`

**Keys**: 596  •  **Missing AR**: 0  •  **Missing EN**: 0

| Key | English (source) | Arabic (draft) | Reviewer notes |
|---|---|---|---|
| `a11y_back` | Back | رجوع | |
| `a11y_clear_search` | Clear search | مسح البحث | |
| `a11y_close` | Close | إغلاق | |
| `a11y_copy` | Copy | نسخ | |
| `a11y_decrement` | Decrease | إنقاص | |
| `a11y_increment` | Increase | زيادة | |
| `a11y_search` | Search | بحث | |
| `a11y_share` | Share | مشاركة | |
| `a11y_tab_account` | Account tab | تبويب الحساب | |
| `a11y_tab_bookings` | Bookings tab | تبويب الحجوزات | |
| `a11y_tab_home` | Home tab | تبويب الرئيسية | |
| `a11y_tab_rewards` | Rewards tab | تبويب المكافآت | |
| `account_change_language` | Change Language | تغيير اللغة | |
| `account_contact_us` | Contact Us | تواصل معنا | |
| `account_danger_zone` | Danger zone | منطقة الخطر | |
| `account_delete` | Delete account | حذف الحساب | |
| `account_delete_button` | Delete my account | احذف حسابي | |
| `account_delete_cancel` | Cancel | إلغاء | |
| `account_delete_confirm_label` | Type DELETE to confirm | اكتب DELETE للتأكيد | |
| `account_delete_confirm_word` | DELETE | DELETE | |
| `account_delete_error` | Couldn't delete account | تعذّر حذف الحساب | |
| `account_delete_error_generic` | Something went wrong on our side. Please try again, and reach out via Contact us if it keeps failing. | حدث خطأ من جانبنا. يُرجى المحاولة مجدداً، وتواصل معنا عبر "تواصل معنا" إذا استمر الخطأ. | |
| `account_delete_error_network` | Please check your connection and try again. | يُرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى. | |
| `account_delete_in_progress` | Deleting account… | جارٍ حذف الحساب… | |
| `account_delete_intro` | Deleting your account is permanent and cannot be undone. | حذف حسابك إجراء نهائي ولا يمكن التراجع عنه. | |
| `account_delete_title` | Delete account | حذف الحساب | |
| `account_delete_what_deleted` | Your name, email, phone number, saved addresses, and push-notification devices are removed. Your account is closed and you are signed out. | تُحذف بياناتك: الاسم، البريد الإلكتروني، رقم الهاتف، العناوين المحفوظة، وأجهزة الإشعارات. يُغلق حسابك ويتم تسجيل خروجك. | |
| `account_delete_what_deleted_heading` | What gets deleted | ما الذي يُحذف | |
| `account_delete_what_kept` | Past bookings, payments, and credit transactions are retained — anonymised — for tax and legal reasons. They cannot be linked back to you after deletion. | تُحفظ الحجوزات السابقة والمدفوعات وحركات الرصيد — بشكل مجهول الهوية — لأسباب ضريبية وقانونية. لا يمكن ربطها بك بعد الحذف. | |
| `account_delete_what_kept_heading` | What we keep | ما الذي نحتفظ به | |
| `account_deleted_success` | Your account has been deleted. | تم حذف حسابك. | |
| `account_export_button` | Email me my data | أرسل لي بياناتي | |
| `account_export_cancel` | Cancel | إلغاء | |
| `account_export_delivery` | The file is sent as an attachment to the email address on your account. Check your spam folder if it doesn't arrive within a few minutes. | يُرسل الملف كمرفق إلى البريد الإلكتروني المسجّل في حسابك. تحقّق من مجلد البريد المهمل إذا لم يصل خلال دقائق. | |
| `account_export_delivery_heading` | Delivery | طريقة الإرسال | |
| `account_export_done` | Done | تم | |
| `account_export_error_generic` | Something went wrong on our side. Please try again, and reach out via Contact us if it keeps failing. | حدث خطأ من جانبنا. يُرجى المحاولة مجدداً، وتواصل معنا عبر "تواصل معنا" إذا استمر الخطأ. | |
| `account_export_error_network` | Please check your connection and try again. | يُرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى. | |
| `account_export_error_title` | Couldn't prepare your export | تعذّر تجهيز التصدير | |
| `account_export_in_progress` | Preparing your export… | جارٍ تجهيز التصدير… | |
| `account_export_intro` | We'll email you a JSON file with everything we hold about your account. | سنرسل إليك ملف JSON يحتوي على كل البيانات المخزنة عن حسابك. | |
| `account_export_menu` | Download my data | تنزيل بياناتي | |
| `account_export_no_email_body` | Add an email to your profile first — that's where we'll send the file. | أضف بريداً إلكترونياً إلى ملفك أولاً — هذا هو العنوان الذي سنرسل إليه الملف. | |
| `account_export_no_email_title` | No email on file | لا يوجد بريد إلكتروني | |
| `account_export_sent_body` | We've emailed your data to {email}. | أرسلنا بياناتك إلى {email}. | |
| `account_export_sent_title` | Export sent | تم إرسال التصدير | |
| `account_export_title` | Download my data | تنزيل بياناتي | |
| `account_export_what_included` | Your profile, saved addresses, every booking and payment, and your credit-transaction history. | ملفك الشخصي، عناوينك المحفوظة، كل حجوزاتك ومدفوعاتك، وسجل حركات رصيدك. | |
| `account_export_what_included_heading` | What's included | ما الذي يتضمنه الملف | |
| `account_help` | Help & FAQ | المساعدة والأسئلة الشائعة | |
| `account_language_value` | English | العربية | |
| `account_legal` | Legal | الشؤون القانونية | |
| `account_my_addresses` | My Addresses | عناويني | |
| `account_my_profile` | My Profile | ملفي الشخصي | |
| `account_my_subscriptions` | My Subscriptions | اشتراكاتي | |
| `account_payment_methods` | Payment Methods | طرق الدفع | |
| `account_personal` | Personal | الشخصية | |
| `account_privacy_policy` | Privacy Policy | سياسة الخصوصية | |
| `account_services` | Services | الخدمات | |
| `account_settings` | Settings | الإعدادات | |
| `account_sign_out` | Sign Out | تسجيل الخروج | |
| `account_signout_confirm` | Are you sure you want to sign out? | هل أنت متأكد أنك تريد تسجيل الخروج؟ | |
| `account_signout_title` | Sign out | تسجيل الخروج | |
| `account_support` | Support & Preferences | الدعم والتفضيلات | |
| `account_terms_of_service` | Terms of Service | شروط الخدمة | |
| `account_title` | Account | الحساب | |
| `add_card_cvv_label` | CVV | رمز الأمان | |
| `add_card_error_cvv` | Please enter a valid CVV. | يرجى إدخال رمز أمان صحيح. | |
| `add_card_error_expired` | This card has expired. | انتهت صلاحية هذه البطاقة. | |
| `add_card_error_expiry` | Please enter a valid expiry date. | يرجى إدخال تاريخ انتهاء صحيح. | |
| `add_card_error_name` | Please enter the cardholder name. | يرجى إدخال اسم حامل البطاقة. | |
| `add_card_error_number` | Please enter a valid card number. | يرجى إدخال رقم بطاقة صحيح. | |
| `add_card_error_title` | Invalid Details | تفاصيل غير صحيحة | |
| `add_card_expiry_label` | Expiry Date | تاريخ الانتهاء | |
| `add_card_name_label` | Cardholder Name | اسم حامل البطاقة | |
| `add_card_name_placeholder` | Name on card | الاسم على البطاقة | |
| `add_card_number_label` | Card Number | رقم البطاقة | |
| `add_card_save` | Save Card | حفظ البطاقة | |
| `add_card_save_note` | Card details are saved securely for future checkouts. | يتم حفظ تفاصيل البطاقة بشكل آمن لعمليات الدفع المستقبلية. | |
| `add_card_title` | Add New Card | إضافة بطاقة جديدة | |
| `address_add_first` | Add your first address | أضف عنوانك الأول | |
| `address_add_new` | Add New Address | إضافة عنوان جديد | |
| `address_add_photo` | Add Photo | إضافة صورة | |
| `address_add_title` | Add New Address | إضافة عنوان جديد | |
| `address_area` | Area * | الحي * | |
| `address_area_placeholder` | Neighbourhood or area name | اسم الحي أو المنطقة | |
| `address_building_number` | Building Number * | رقم المبنى * | |
| `address_building_placeholder` | e.g. 12 | مثال: 12 | |
| `address_cancel` | Cancel | إلغاء | |
| `address_change_photo` | Change Photo | تغيير الصورة | |
| `address_city` | City * | المدينة * | |
| `address_city_placeholder` | City | المدينة | |
| `address_compound_hint` | Let your cleaner know they need compound access | أخبر المنظّف أنه يحتاج للدخول عبر بوابة الكومباوند | |
| `address_compound_label` | Inside a Compound? | داخل كومباوند؟ | |
| `address_default` | Default | افتراضي | |
| `address_delete` | Delete | حذف | |
| `address_delete_confirm` | Are you sure? | هل أنت متأكد؟ | |
| `address_delete_title` | Delete address | حذف العنوان | |
| `address_from_gallery` | Choose from Gallery | اختر من المعرض | |
| `address_instructions_label` | Delivery Instructions | تعليمات التوصيل | |
| `address_instructions_placeholder` | e.g. Ring the bell, use the side gate... | مثال: اضغط الجرس، استخدم البوابة الجانبية... | |
| `address_location_not_set` | Tap map to pin location | اضغط على الخريطة لتحديد الموقع | |
| `address_location_set` | Location pinned | تم تحديد الموقع | |
| `address_map_hint` | Tap on the map to set your exact location | اضغط على الخريطة لتحديد موقعك بدقة | |
| `address_map_label` | Pin Your Location | تحديد الموقع على الخريطة | |
| `address_nickname` | Nickname * | التسمية * | |
| `address_nickname_placeholder` | e.g. Home, Work | مثال: المنزل، العمل | |
| `address_no_addresses` | No addresses yet | لا توجد عناوين بعد | |
| `address_out_of_area` | This area isn't in our coverage zone yet — we're expanding soon! | هذه المنطقة غير مغطاة حالياً — نعمل على توسيع نطاق خدمتنا قريباً! | |
| `address_photo_hint` | Helps your cleaner find the building | تساعد المنظّف في إيجاد المبنى | |
| `address_photo_label` | Building Photo | صورة المبنى | |
| `address_required` | Required | مطلوب | |
| `address_required_message` | Please fill in all required fields. | يرجى ملء جميع الحقول المطلوبة. | |
| `address_save` | Save Address | حفظ العنوان | |
| `address_street` | Street Address * | اسم الشارع * | |
| `address_street_placeholder` | Street name | اسم الشارع | |
| `address_take_photo` | Take Photo | التقاط صورة | |
| `address_title` | My Addresses | عناويني | |
| `booking_4hrs` | 4 hrs | 4 ساعات | |
| `booking_added_to_cart` | Added to cart 🎉 | تمت الإضافة إلى السلة 🎉 | |
| `booking_best_available` | Best Available | أفضل المتاحين | |
| `booking_choose_datetime` | Choose Date & Time | اختر التاريخ والوقت | |
| `booking_detail_address` | Address | العنوان | |
| `booking_detail_base` | Base | السعر الأساسي | |
| `booking_detail_cancel` | Cancel booking | إلغاء الحجز | |
| `booking_detail_cancel_confirm_message` | You can rebook anytime. | يمكنك إعادة الحجز في أي وقت. | |
| `booking_detail_cancel_confirm_title` | Cancel this booking? | إلغاء هذا الحجز؟ | |
| `booking_detail_cancel_failed` | Couldn’t cancel booking | تعذر إلغاء الحجز | |
| `booking_detail_cancel_keep` | Keep booking | الإبقاء على الحجز | |
| `booking_detail_cancel_yes` | Yes, cancel | نعم، إلغاء | |
| `booking_detail_cleaner` | Your cleaner | منظّفك | |
| `booking_detail_credits` | Credits | الرصيد | |
| `booking_detail_discount` | Discount | الخصم | |
| `booking_detail_error` | Couldn’t load booking | تعذر تحميل الحجز | |
| `booking_detail_extra_cleaners` | Extra cleaners | منظفون إضافيون | |
| `booking_detail_loading` | Loading booking… | جاري تحميل الحجز… | |
| `booking_detail_not_found` | Booking not found. | الحجز غير موجود. | |
| `booking_detail_pricing` | Pricing | التسعير | |
| `booking_detail_progress` | Progress | المراحل | |
| `booking_detail_service` | Service | الخدمة | |
| `booking_detail_title` | Booking | الحجز | |
| `booking_detail_total` | Total | الإجمالي | |
| `booking_detail_when` | When | الموعد | |
| `booking_keep_browsing` | Keep browsing | متابعة التصفح | |
| `booking_pick_datetime` | Pick a date and time | اختر تاريخاً ووقتاً | |
| `booking_preferred_hint` | Select up to {n} preferred cleaner{s}, or let us find you the best match. | اختر حتى {n} منظّف{s} مفضّل، أو دعنا نجد الأفضل. | |
| `booking_select_date` | Select Date | اختر التاريخ | |
| `booking_select_time` | Select Arrival Time | اختر وقت الوصول | |
| `booking_specific_cleaners` | {n} specific cleaners | {n} منظّفون محدّدون | |
| `booking_status_cancelled` | Cancelled | ملغى | |
| `booking_status_completed` | Completed | مكتمل | |
| `booking_status_en_route` | On the way | في الطريق | |
| `booking_status_in_progress` | In progress | قيد التنفيذ | |
| `booking_status_rescheduled` | Rescheduled | أعيدت جدولته | |
| `booking_status_scheduled` | Scheduled | مجدول | |
| `booking_summary_arrival` | Arrival | وقت الوصول | |
| `booking_summary_cleaner` | Cleaner | المنظّف | |
| `booking_summary_cleaners` | Cleaners | المنظّفون | |
| `booking_summary_date` | Date | التاريخ | |
| `booking_summary_title` | Booking Summary | ملخص الحجز | |
| `booking_summary_total` | Total | الإجمالي | |
| `booking_time_hint` | Choose when you'd like the cleaner(s) to arrive. | اختر متى تريد أن يصل المنظّف(ون). | |
| `booking_today` | Today | اليوم | |
| `booking_view_cart` | View cart | عرض السلة | |
| `booking_voided` | Voided | ملغى | |
| `bookings_cancel` | Cancel booking | إلغاء الحجز | |
| `bookings_cancel_confirm` | Cancel this booking? | هل تريد إلغاء هذا الحجز؟ | |
| `bookings_cancel_confirm_no` | Keep it | الاحتفاظ به | |
| `bookings_cancel_confirm_yes` | Yes, cancel | نعم، إلغاء | |
| `bookings_cancel_done` | Cancelled. | تم الإلغاء. | |
| `bookings_cancel_failed` | Couldn’t cancel. Try again. | تعذر الإلغاء. حاول مجدداً. | |
| `bookings_change_cleaners` | Change cleaner count | تغيير عدد المنظّفين | |
| `bookings_change_cleaners_done` | Change requested. We will follow up shortly. | تم استلام طلبك. سنتواصل معك قريباً. | |
| `bookings_change_cleaners_hint` | Your request will be reviewed by the team — pricing adjustments apply. | سيراجع الفريق طلبك — قد تنطبق تعديلات على السعر. | |
| `bookings_change_cleaners_save` | Request change | إرسال الطلب | |
| `bookings_edit` | Edit | تعديل | |
| `bookings_edit_title` | Edit booking | تعديل الحجز | |
| `bookings_empty` | Your bookings will appear here. | ستظهر حجوزاتك هنا. | |
| `bookings_empty_history` | No past bookings yet. | لا توجد حجوزات سابقة بعد. | |
| `bookings_empty_subscriptions` | No active subscriptions. Pick a monthly plan from the home tab. | لا توجد اشتراكات نشطة. اختر باقة شهرية من الشاشة الرئيسية. | |
| `bookings_empty_upcoming` | No upcoming bookings. Tap a service from the home tab to book one. | لا توجد حجوزات قادمة. اختر خدمة من الشاشة الرئيسية لحجزها. | |
| `bookings_lead_cleaner` | Lead cleaner | المنظّف الرئيسي | |
| `bookings_pending_request` | Cleaner-count change pending review | طلب تغيير عدد المنظّفين قيد المراجعة | |
| `bookings_reschedule` | Reschedule | إعادة جدولة | |
| `bookings_reschedule_done` | Rescheduled. | تمت إعادة الجدولة. | |
| `bookings_reschedule_failed` | Couldn’t reschedule. Try again. | تعذرت إعادة الجدولة. حاول مجدداً. | |
| `bookings_reschedule_pick_date` | Pick a new date | اختر تاريخاً جديداً | |
| `bookings_reschedule_pick_time` | Pick a time | اختر وقتاً | |
| `bookings_reschedule_save` | Save new time | حفظ الموعد الجديد | |
| `bookings_tab_history` | History | السجل | |
| `bookings_tab_subscriptions` | Subscriptions | الاشتراكات | |
| `bookings_tab_upcoming` | Upcoming | القادمة | |
| `bookings_title` | Bookings | الحجوزات | |
| `bookings_unassigned` | Unassigned | لم يُعيَّن بعد | |
| `cancel_error_subscription_session` | Subscription sessions can't be cancelled individually yet. Please contact support. | لا يمكن إلغاء جلسات الاشتراك بشكل فردي حالياً. يُرجى التواصل مع الدعم. | |
| `cancel_error_voided` | This booking has been voided and cannot be modified. | هذا الحجز ملغى بالفعل ولا يمكن تعديله. | |
| `cancel_error_wrong_status` | This booking can no longer be cancelled from the app. Please contact support. | لم يعد بالإمكان إلغاء هذا الحجز من التطبيق. يُرجى التواصل مع الدعم. | |
| `cancel_modal_as_of_note` | Fee shown as of now; the final amount is calculated when you confirm. | الرسوم المعروضة محسوبة الآن؛ المبلغ النهائي يُحدَّد عند التأكيد. | |
| `cancel_modal_confirm_free` | Yes, cancel | نعم، إلغاء | |
| `cancel_modal_confirm_with_fee` | Yes, cancel and pay fee | نعم، إلغاء ودفع الرسوم | |
| `cancel_modal_fee_label` | {amount} EGP | {amount} جنيه | |
| `cancel_modal_keep` | Keep booking | الاحتفاظ بالحجز | |
| `cancel_modal_refund_note` | You'll be refunded {amount} EGP. | سيُعاد إليك {amount} جنيه. | |
| `cancel_modal_tier_free_title` | Free cancellation | إلغاء مجاني | |
| `cancel_modal_tier_full_title` | Full charge | خصم كامل | |
| `cancel_modal_tier_partial_title` | Partial fee | رسوم جزئية | |
| `cancel_modal_title` | Cancel this booking? | هل تريد إلغاء هذا الحجز؟ | |
| `cancel_success_free` | Your booking has been cancelled at no charge. | تم إلغاء حجزك دون أي رسوم. | |
| `cancel_success_title` | Booking cancelled | تم إلغاء الحجز | |
| `cancel_success_with_fee` | Your booking has been cancelled. A cancellation fee of {amount} EGP was retained. | تم إلغاء حجزك. تم خصم رسوم إلغاء بقيمة {amount} جنيه. | |
| `cart_4hrs` | 4 hrs | 4 ساعات | |
| `cart_best_available` | Best Available | أفضل المتاحين | |
| `cart_browse_services` | Browse Services | تصفح الخدمات | |
| `cart_checkout` | Checkout | الدفع | |
| `cart_cleaner` | {n} cleaner | {n} منظّف | |
| `cart_cleaners` | {n} cleaners | {n} منظّفون | |
| `cart_empty_subtitle` | Add a service to get started | أضف خدمة للبدء | |
| `cart_empty_title` | Your cart is empty | سلتك فارغة | |
| `cart_item` | {n} item | {n} عنصر | |
| `cart_items` | {n} items | {n} عناصر | |
| `cart_order_summary` | Order Summary | ملخص الطلب | |
| `cart_specific_cleaners` | {n} specific cleaners | {n} منظّفون محدّدون | |
| `cart_title` | My Cart | سلتي | |
| `cart_total` | Total | الإجمالي | |
| `checkout_add_card` | Add new card | إضافة بطاقة جديدة | |
| `checkout_address` | Address | العنوان | |
| `checkout_apple_pay` | Pay with Apple Pay | الدفع بـ Apple Pay | |
| `checkout_available` | available | متاح | |
| `checkout_cancel` | Cancel | إلغاء | |
| `checkout_confirm` | Confirm | تأكيد | |
| `checkout_confirm_message` | Pay EGP {amount} with {method}? | هل تريد دفع {amount} جنيه بـ {method}؟ | |
| `checkout_confirm_title` | Confirm Payment | تأكيد الدفع | |
| `checkout_consent_middle` |  and acknowledge our  |  وتُقِرّ بـ | |
| `checkout_consent_prefix` | By continuing, you agree to our  | بمواصلتك، فإنك توافق على  | |
| `checkout_consent_privacy` | Privacy Policy | سياسة الخصوصية | |
| `checkout_consent_suffix` | . |  الخاصة بنا. | |
| `checkout_consent_terms` | Terms of Service | شروط الخدمة | |
| `checkout_credits_applied` | discount applied · you pay | خصم مُطبَّق · يتم الدفع | |
| `checkout_edit_datetime` | Edit date & time | تعديل التاريخ والوقت | |
| `checkout_edit_service` | Edit service | تعديل الخدمة | |
| `checkout_error_title` | Couldn't place order | تعذّر إتمام الطلب | |
| `checkout_item` | {n} item | {n} عنصر | |
| `checkout_items` | {n} items | {n} عناصر | |
| `checkout_no_cards` | No saved cards yet | لا توجد بطاقات محفوظة بعد | |
| `checkout_or_pay_with_card` | or pay with card | أو الدفع بالبطاقة | |
| `checkout_order_summary` | Order Summary | ملخص الطلب | |
| `checkout_pay` | Pay EGP {amount} | ادفع {amount} جنيه | |
| `checkout_payment_method` | Payment Method | طريقة الدفع | |
| `checkout_select_method` | Select a method | اختر طريقة دفع | |
| `checkout_title` | Checkout | الدفع | |
| `checkout_total` | Total | الإجمالي | |
| `checkout_use_credits` | Use credits | استخدام الرصيد | |
| `cleaner_assigned_generic` | Cleaner assigned | تم تعيين منظّف | |
| `cleaner_jobs` | {count} jobs | {count} مهمة | |
| `cleaner_unassigned` | Awaiting assignment | في انتظار التعيين | |
| `contact_call` | Call Us | اتصل بنا | |
| `contact_email_btn` | Email | البريد الإلكتروني | |
| `contact_email_label` | Email | البريد الإلكتروني | |
| `contact_hours` | Hours | ساعات العمل | |
| `contact_hours_value` | Sun–Thu, 8am–10pm | الأحد–الخميس، 8 ص–10 م | |
| `contact_message` | Message | الرسالة | |
| `contact_message_placeholder` | How can we help you? | كيف يمكننا مساعدتك؟ | |
| `contact_name_placeholder` | Enter your name | أدخل اسمك | |
| `contact_phone_label` | Phone | الهاتف | |
| `contact_reach_directly` | Reach Us Directly | تواصل معنا مباشرة | |
| `contact_required` | Required | مطلوب | |
| `contact_required_message` | Please fill in your name and message. | يرجى ملء اسمك ورسالتك. | |
| `contact_send` | Send Message | إرسال | |
| `contact_send_section` | Send a Message | أرسل رسالة | |
| `contact_sent` | Sent! | تم الإرسال! | |
| `contact_sent_message` | We've received your message and will get back to you within 24 hours. | استلمنا رسالتك وسنردّ خلال 24 ساعة. | |
| `contact_title` | Contact Us | تواصل معنا | |
| `contact_whatsapp` | WhatsApp | واتساب | |
| `contact_whatsapp_label` | WhatsApp | واتساب | |
| `contact_your_name` | Your Name | اسمك | |
| `coupon_apply` | Apply | تطبيق | |
| `coupon_error_already_redeemed` | This coupon has already been applied to this booking. | تم تطبيق هذا الكوبون على هذا الحجز بالفعل. | |
| `coupon_error_disabled` | This coupon is no longer active. | هذا الكوبون لم يعد نشطاً. | |
| `coupon_error_exhausted` | This coupon has been fully redeemed. | تم استخدام هذا الكوبون بالكامل. | |
| `coupon_error_expired` | This coupon has expired. | انتهت صلاحية هذا الكوبون. | |
| `coupon_error_first_booking_only` | This coupon is for first-time customers only. | هذا الكوبون لعملاء المرة الأولى فقط. | |
| `coupon_error_network` | Please check your connection and try again. | يُرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى. | |
| `coupon_error_not_found` | That code isn't valid. | هذا الرمز غير صالح. | |
| `coupon_error_wrong_city` | This coupon isn't available in your city. | هذا الكوبون غير متاح في مدينتك. | |
| `coupon_have_one` | Have a coupon? | لديك كوبون؟ | |
| `coupon_off` | off | خصم | |
| `coupon_placeholder` | Coupon code | رمز الكوبون | |
| `coupon_remove` | Remove | إزالة | |
| `day_fri` | Fri | جمعة | |
| `day_mon` | Mon | إثنين | |
| `day_sat` | Sat | سبت | |
| `day_sun` | Sun | أحد | |
| `day_thu` | Thu | خميس | |
| `day_tue` | Tue | ثلاثاء | |
| `day_wed` | Wed | أربعاء | |
| `error_auth` | Your session has expired. Please sign in again. | انتهت صلاحية الجلسة. يُرجى تسجيل الدخول مرة أخرى. | |
| `error_dismiss` | Dismiss | إغلاق | |
| `error_network` | Please check your connection and try again. | يُرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى. | |
| `error_not_found` | We couldn't find what you were looking for. | تعذّر العثور على ما تبحث عنه. | |
| `error_permission` | You don't have permission to do that. | ليست لديك الصلاحية لإجراء ذلك. | |
| `error_retry` | Retry | إعادة المحاولة | |
| `error_title` | Something went wrong | حدث خطأ | |
| `error_unknown` | Please try again. If it keeps failing, contact support. | يُرجى المحاولة مجدداً. إذا استمر الخطأ، تواصل مع الدعم. | |
| `help_a_cancel_fees_title` | What are the cancellation fees? | ما هي رسوم الإلغاء؟ | |
| `help_a_choose_cleaner_title` | Can I pick a specific cleaner? | هل يمكنني اختيار عامل تنظيف معيّن؟ | |
| `help_a_credits_how_title` | How do Spotless credits work? | كيف يعمل رصيد Spotless؟ | |
| `help_a_delete_account_title` | How do I delete my account? | كيف أحذف حسابي؟ | |
| `help_a_how_booking_works_title` | How does booking a cleaning work? | كيف يتم حجز خدمة التنظيف؟ | |
| `help_a_payment_methods_title` | What payment methods do you accept? | ما طرق الدفع المقبولة؟ | |
| `help_a_referrals_title` | How does the referral program work? | كيف يعمل برنامج الإحالة؟ | |
| `help_a_refund_timing_title` | How long do refunds take? | كم يستغرق استرداد المبلغ؟ | |
| `help_a_reschedule_title` | How do I reschedule a booking? | كيف أُعيد جدولة حجز؟ | |
| `help_article_not_found` | Article not found. | المقالة غير موجودة. | |
| `help_cat_account` | Account | الحساب | |
| `help_cat_booking` | Bookings | الحجوزات | |
| `help_cat_cancellation` | Cancellations | الإلغاء | |
| `help_cat_getting_started` | Getting started | البداية | |
| `help_cat_payments` | Payments & credits | المدفوعات والرصيد | |
| `help_contact_cta` | Contact us | تواصل معنا | |
| `help_contact_hint` | Can't find an answer? Reach out and we'll get back within one business day. | لم تجد إجابة؟ تواصل معنا وسنردّ خلال يوم عمل واحد. | |
| `help_no` | No | لا | |
| `help_no_results` | No articles match your search. Try a different keyword, or contact us. | لا توجد نتائج لبحثك. جرّب كلمات أخرى أو تواصل معنا. | |
| `help_search_placeholder` | Search articles | ابحث في المقالات | |
| `help_still_have_questions` | Still have questions? Contact us | لديك أسئلة أخرى؟ تواصل معنا | |
| `help_still_need_help` | Still need help? | هل لا تزال بحاجة إلى مساعدة؟ | |
| `help_thanks_for_feedback` | Thanks for the feedback! | شكراً على تعليقك! | |
| `help_title` | Help & FAQ | المساعدة والأسئلة الشائعة | |
| `help_view_past_bookings` | See your past bookings | اطّلع على حجوزاتك السابقة | |
| `help_was_this_helpful` | Was this helpful? | هل كان هذا مفيداً؟ | |
| `help_yes` | Yes | نعم | |
| `history_rate_now` | Rate | قيّم | |
| `history_rated` | Rated {stars}/5 | تقييم {stars}/5 | |
| `home_activity_cleaner_pending` | Cleaner being assigned | يتم تعيين عاملة النظافة | |
| `home_activity_eta_pending` | Live tracking coming soon | التتبع المباشر قريبًا | |
| `home_activity_view_booking` | View booking | عرض الحجز | |
| `home_address_add` | Add Address | إضافة عنوان | |
| `home_address_required_message` | Please add a service address before booking. | يرجى إضافة عنوان الخدمة قبل الحجز. | |
| `home_address_required_title` | Address Required | العنوان مطلوب | |
| `home_address_unset` | Tap to set your address | اضغط لتحديد عنوانك | |
| `home_banner_text` | Dreaming of a\nSpotless Home? | هل تحلم بمنزل\nنظيف تماماً؟ | |
| `home_book_now` | Book now | احجز الآن | |
| `home_greeting_afternoon` | Good afternoon, {name} | مساء الخير، {name} | |
| `home_greeting_afternoon_anon` | Good afternoon | مساء الخير | |
| `home_greeting_evening` | Good evening, {name} | مساء الخير، {name} | |
| `home_greeting_evening_anon` | Good evening | مساء الخير | |
| `home_greeting_fallback` | Welcome | مرحبًا | |
| `home_greeting_morning` | Good morning, {name} | صباح الخير، {name} | |
| `home_greeting_morning_anon` | Good morning | صباح الخير | |
| `home_our_services` | Our Services | خدماتنا | |
| `home_promo_subscription_cta` | Learn more | اعرف المزيد | |
| `home_promo_subscription_text` | Cleaner home, every week. Try a monthly plan. | منزل أنظف، كل أسبوع. جرّب خطة شهرية. | |
| `home_rebook_button` | Book again | احجز مرة أخرى | |
| `home_rebook_summary_plural` | {count} cleaners · {area} | {count} عاملات نظافة · {area} | |
| `home_rebook_summary_singular` | 1 cleaner · {area} | عاملة نظافة واحدة · {area} | |
| `home_rebook_title` | Book the same clean again | احجز نفس التنظيف مرة أخرى | |
| `home_search` | Search services... | ابحث عن الخدمات... | |
| `home_services_heading` | Book a service | احجز خدمة | |
| `home_set_address` | Set your address | حدّد عنوانك | |
| `home_subscription_frequency_biweekly` | Every 2 weeks | كل أسبوعين | |
| `home_subscription_frequency_monthly` | Monthly | شهري | |
| `home_subscription_frequency_weekly` | Weekly | أسبوعي | |
| `home_subscription_manage` | Manage | إدارة | |
| `home_subscription_next` | Next session {date} | الجلسة القادمة {date} | |
| `home_subscription_title` | Active subscription | اشتراك نشط | |
| `home_your_location` | Your location | موقعك | |
| `language_hint` | Select your preferred language | اختر لغتك المفضّلة | |
| `language_restart_message` | Please close and reopen the app to apply the new layout direction. | يرجى إغلاق التطبيق وإعادة فتحه لتطبيق اتجاه التخطيط الجديد. | |
| `language_restart_title` | Restart required | إعادة تشغيل مطلوبة | |
| `language_set_to` | The app language has been set to English. | تم تعيين لغة التطبيق إلى الإنجليزية. | |
| `language_set_to_ar` | The app language has been set to Arabic. | تم تعيين لغة التطبيق إلى العربية. | |
| `language_title` | Change Language | تغيير اللغة | |
| `legal_draft_notice` | Draft — pending counsel review before publication. | مسودة — قيد المراجعة من قِبل المستشار القانوني قبل النشر. | |
| `legal_last_updated` | Last updated | آخر تحديث | |
| `legal_version` | Version | الإصدار | |
| `modal_about` | About | عن المنظّف | |
| `modal_jobs` | Jobs | المهام | |
| `modal_languages` | Languages | اللغات | |
| `modal_rating` | Rating | التقييم | |
| `modal_recent_reviews` | Recent Reviews | التقييمات الأخيرة | |
| `modal_remove` | Remove {name} | أزل {name} | |
| `modal_select` | Select {name} | اختر {name} | |
| `modal_slots_filled` | All slots filled | جميع المقاعد ممتلئة | |
| `modal_specialties` | Specialties | التخصصات | |
| `modal_verified` | Verified | موثّق | |
| `modal_years` | Years | السنوات | |
| `month_apr` | Apr | أبريل | |
| `month_aug` | Aug | أغسطس | |
| `month_dec` | Dec | ديسمبر | |
| `month_feb` | Feb | فبراير | |
| `month_jan` | Jan | يناير | |
| `month_jul` | Jul | يوليو | |
| `month_jun` | Jun | يونيو | |
| `month_mar` | Mar | مارس | |
| `month_may` | May | مايو | |
| `month_nov` | Nov | نوفمبر | |
| `month_oct` | Oct | أكتوبر | |
| `month_sep` | Sep | سبتمبر | |
| `onboarding_1_body` | Pick a service, choose a date, and we’ll match you with a trusted, vetted cleaner. | اختر الخدمة وحدد الموعد، وسنرسل لك منظّفاً موثوقاً ومدرّباً. | |
| `onboarding_1_title` | Book a cleaner in seconds | احجز منظّفاً في ثوانٍ | |
| `onboarding_2_body` | Single deep clean, recurring weekly visits, or anything in between — you decide. | تنظيف عميق مرة واحدة، أو زيارات أسبوعية متكررة — أنت تختار. | |
| `onboarding_2_title` | One-time visits or monthly plans | زيارة لمرة واحدة أو اشتراك شهري | |
| `onboarding_3_body` | Sofas, mattresses, dining chairs — priced per piece so you only pay for what you need. | أرائك ومراتب وكراسي طعام — السعر حسب القطعة، فلا تدفع إلا مقابل ما تحتاجه. | |
| `onboarding_3_title` | Furniture deep cleaning | تنظيف عميق للأثاث | |
| `onboarding_4_body` | Refer friends, rate your cleaner, and get credits to apply against your next booking. | ادعُ أصدقاءك وقيّم منظّفك واحصل على رصيد لاستخدامه في حجزك التالي. | |
| `onboarding_4_title` | Earn credits on every visit | اكسب رصيداً مع كل زيارة | |
| `onboarding_get_started` | Get started | هيا نبدأ | |
| `onboarding_next` | Next | التالي | |
| `onboarding_skip` | Skip | تخطي | |
| `otp_error_invalid` | Incorrect code. Please try again. | الرمز غير صحيح. يرجى المحاولة مجدداً. | |
| `otp_error_no_confirm` | No confirmation — resend OTP. | لا يوجد تأكيد — يرجى إعادة إرسال الرمز. | |
| `otp_error_resend` | Could not resend. Please go back and try again. | تعذّر إعادة الإرسال. يرجى الرجوع والمحاولة مجدداً. | |
| `otp_error_short` | Enter the full 6-digit code. | أدخل الرمز المكوّن من 6 أرقام كاملاً. | |
| `otp_resend` | Didn't get a code? Resend | لم تستلم الرمز؟ أعد الإرسال | |
| `otp_subtitle` | Enter the 6-digit code sent to | أدخل الرمز المكوّن من 6 أرقام المُرسَل إلى | |
| `otp_title` | Check your messages | تحقق من رسائلك | |
| `otp_verify` | Verify | تحقق | |
| `payment_add_first_card` | Add Your First Card | أضف بطاقتك الأولى | |
| `payment_add_new` | Add New Card | إضافة بطاقة جديدة | |
| `payment_cancel` | Cancel | إلغاء | |
| `payment_default` | Default | افتراضية | |
| `payment_no_cards_subtitle` | Add a credit or debit card to pay faster at checkout. | أضف بطاقة ائتمانية أو بنكية لدفع أسرع عند الخروج. | |
| `payment_no_cards_title` | No saved cards | لا توجد بطاقات محفوظة | |
| `payment_remove` | Remove | إزالة | |
| `payment_remove_message` | Remove {brand} •••• {last4}? | إزالة {brand} •••• {last4}؟ | |
| `payment_remove_title` | Remove Card | إزالة البطاقة | |
| `payment_set_default` | Set default | تعيين كافتراضية | |
| `payment_title` | Payment Methods | طرق الدفع | |
| `phone_back` | ← Back | رجوع → | |
| `phone_error_empty` | Please enter your phone number. | يرجى إدخال رقم هاتفك. | |
| `phone_error_invalid_eg` | Enter your Egyptian mobile number (11 digits, starts with 01). | أدخل رقم هاتفك المصري (11 رقمًا تبدأ بـ 01). | |
| `phone_error_send` | Could not send OTP. Check the number and try again. | تعذّر إرسال الرمز. تحقق من الرقم وحاول مجدداً. | |
| `phone_hint` | We'll send a one-time code via SMS to verify your number. | سنرسل رمزاً مؤقتاً عبر الرسائل القصيرة للتحقق من رقمك. | |
| `phone_send_code` | Send Code | إرسال الرمز | |
| `phone_subtitle_signin` | Enter your phone number to sign in | أدخل رقم هاتفك لتسجيل الدخول | |
| `phone_subtitle_signup` | Enter your phone number to get started | أدخل رقم هاتفك للبدء | |
| `phone_title_signin` | Welcome back | أهلاً بعودتك | |
| `phone_title_signup` | Create your account | أنشئ حسابك | |
| `profile_change_photo` | Change photo | تغيير الصورة | |
| `profile_email_address` | Email Address | البريد الإلكتروني | |
| `profile_full_name` | Full Name | الاسم الكامل | |
| `profile_full_name_placeholder` | Enter your full name | أدخل اسمك الكامل | |
| `profile_phone_hint` | Phone number cannot be changed here | لا يمكن تغيير رقم الهاتف هنا | |
| `profile_phone_number` | Phone Number | رقم الهاتف | |
| `profile_required` | Required | مطلوب | |
| `profile_required_name` | Please enter your full name. | يرجى إدخال اسمك الكامل. | |
| `profile_save` | Save Changes | حفظ التغييرات | |
| `profile_saved` | Saved | تم الحفظ | |
| `profile_saved_message` | Your profile has been updated. | تم تحديث ملفك الشخصي. | |
| `profile_title` | My Profile | ملفي الشخصي | |
| `rating_failed` | Couldn’t save rating. Please try again. | تعذر حفظ التقييم. يرجى المحاولة مرة أخرى. | |
| `rating_open` | Rate | تقييم | |
| `rating_prompt` | Rate this clean to help us improve. | قيّم هذه الخدمة لمساعدتنا على التحسّن. | |
| `rating_review_placeholder` | Tell us more (optional) | أخبرنا المزيد (اختياري) | |
| `rating_skip` | Not now | ليس الآن | |
| `rating_submit` | Submit | إرسال | |
| `rating_subtitle` | Tap a star to rate. | اضغط على نجمة لتقييمنا. | |
| `rating_thanks` | Thanks for your feedback! | شكرًا لملاحظاتك! | |
| `rating_title` | How was your cleaning? | كيف كانت خدمة التنظيف؟ | |
| `register_continue` | Continue | متابعة | |
| `register_email_hint` | We’ll use this for booking receipts only. | سنستخدمه فقط لإرسال إيصالات الحجوزات. | |
| `register_email_label` | Email (optional) | البريد الإلكتروني (اختياري) | |
| `register_email_placeholder` | you@example.com | you@example.com | |
| `register_error_save` | Couldn’t save your details. Please try again. | تعذر حفظ بياناتك. حاول مجدداً. | |
| `register_name_label` | Full name | الاسم بالكامل | |
| `register_name_placeholder` | Your name | اسمك | |
| `register_subtitle` | Tell us a bit about you so we can personalise your experience. | أخبرنا قليلاً عنك لنخصص لك التجربة. | |
| `register_title` | Welcome to Spotless | أهلاً بك في Spotless | |
| `reschedule_button` | Reschedule | إعادة جدولة | |
| `reschedule_error_already_rescheduled` | You've already rescheduled this booking once. Contact support for additional changes. | لقد قمت بإعادة جدولة هذا الحجز من قبل. يُرجى التواصل مع الدعم لإجراء تغييرات إضافية. | |
| `reschedule_error_slot_unavailable` | That slot is fully booked. Please pick another time. | هذا الموعد محجوز بالكامل. يُرجى اختيار موعد آخر. | |
| `reschedule_error_subscription_session` | Subscription sessions can't be rescheduled individually yet. Please contact support. | لا يمكن إعادة جدولة جلسات الاشتراك بشكل فردي حالياً. يُرجى التواصل مع الدعم. | |
| `reschedule_error_title` | Couldn't reschedule | تعذّر تغيير الموعد | |
| `reschedule_error_too_close` | Too close to your booking time to reschedule. Please contact support. | الوقت قريب جداً من موعد الحجز لتغييره. يُرجى التواصل مع الدعم. | |
| `reschedule_error_too_far` | New time is too far in the future. Please pick within the next 30 days. | الموعد الجديد بعيد جداً. يُرجى اختيار موعد خلال الثلاثين يوماً القادمة. | |
| `reschedule_error_voided` | This booking has been voided and cannot be modified. | هذا الحجز ملغى ولا يمكن تعديله. | |
| `reschedule_error_wrong_status` | This booking can no longer be rescheduled from the app. Please contact support. | لم يعد بالإمكان تغيير موعد هذا الحجز من التطبيق. يُرجى التواصل مع الدعم. | |
| `reschedule_modal_capacity_note` | Fully-booked days are greyed out. The final slot is confirmed when you tap reschedule. | الأيام المحجوزة بالكامل تظهر باهتة. سيتم تأكيد الموعد عند الضغط على "إعادة جدولة". | |
| `reschedule_modal_confirm` | Reschedule | إعادة جدولة | |
| `reschedule_modal_current` | Currently: {time} | الموعد الحالي: {time} | |
| `reschedule_modal_keep` | Keep current time | الاحتفاظ بالموعد الحالي | |
| `reschedule_modal_pick_date` | Pick a new date | اختر تاريخاً جديداً | |
| `reschedule_modal_pick_time` | Pick a new time | اختر وقتاً جديداً | |
| `reschedule_modal_title` | Reschedule booking | إعادة جدولة الحجز | |
| `reschedule_success_body` | Your booking has been moved. | تم نقل حجزك إلى الموعد الجديد. | |
| `reschedule_success_title` | Booking rescheduled | تم تغيير موعد الحجز | |
| `rewards_code_minting` | Generating your code… | جارٍ توليد رمزك… | |
| `rewards_completed` | Completed | مكتمل | |
| `rewards_copied` | Copied! | تم النسخ! | |
| `rewards_copy_code` | Copy link | نسخ الرابط | |
| `rewards_earned` | Earned | المكتسب | |
| `rewards_hero_subtitle` | Your friend gets EGP {amount} too — earn up to {cap} times. | صديقك يحصل على {amount} جنيه أيضاً — اكسب حتى {cap} مرة. | |
| `rewards_hero_title` | Refer and earn\nEGP {amount} | أحل واكسب\n{amount} جنيه | |
| `rewards_history_empty` | No referrals yet. Share your code to get started. | لا توجد إحالات بعد. شارك رمزك للبدء. | |
| `rewards_history_title` | Your referrals | إحالاتك | |
| `rewards_how_title` | How it works | كيف تعمل المكافآت | |
| `rewards_invited` | Invited | تمت الدعوة | |
| `rewards_share_cta` | Share with a friend | شارك مع صديق | |
| `rewards_share_message` | Join Spotless and get EGP {amount} off your first cleaning! {link} | انضم إلى Spotless واحصل على {amount} جنيه على أول تنظيف! {link} | |
| `rewards_status_cancelled` | Cancelled | ملغى | |
| `rewards_status_completed` | Completed | مكتمل | |
| `rewards_status_pending` | Pending | قيد الانتظار | |
| `rewards_step_1` | Share your code. Earn EGP {amount} for each friend who completes their first booking. Cap at {cap} referrals (up to EGP {total}). | شارك رمزك. اكسب {amount} جنيه لكل صديق يكمل أول حجز. الحد الأقصى {cap} إحالة (حتى {total} جنيه). | |
| `rewards_step_2` | Your friend gets EGP {amount} credited instantly when they sign up with your code. | صديقك يحصل على {amount} جنيه فوراً عند التسجيل برمزك. | |
| `rewards_step_3` | After their first cleaning is completed, you get EGP {amount} added to your credits. | بعد إتمام أول تنظيف لصديقك، تُضاف {amount} جنيه إلى رصيدك. | |
| `rewards_title` | Refer and Earn | أحل واكسب | |
| `rewards_your_code` | Your code | رمزك | |
| `select_address_add` | Add New Address | إضافة عنوان جديد | |
| `select_address_no_addresses` | No saved addresses yet | لا توجد عناوين محفوظة بعد | |
| `select_address_no_addresses_hint` | Add an address to continue with your booking. | أضف عنواناً للمتابعة في حجزك. | |
| `select_address_subtitle` | Where should we send the team? | أين يجب أن نرسل الفريق؟ | |
| `select_address_title` | Choose Location | اختر الموقع | |
| `service_4hrs` | 4 hrs | 4 ساعات | |
| `service_add_to_cart` | Add to Cart | أضف إلى السلة | |
| `service_all_days_selected` | All days selected ✓ | تم اختيار جميع الأيام ✓ | |
| `service_best_available` | Best Available for All | أفضل المتاحين | |
| `service_best_available_hint` | We'll assign the highest-rated available cleaners | سنعيّن أعلى المنظّفين تقييماً المتاحين | |
| `service_breakdown_cleaners` | Cleaners | المنظّفون | |
| `service_breakdown_monthly_total` | Monthly total | الإجمالي الشهري | |
| `service_breakdown_price_session` | Price per session | سعر الجلسة | |
| `service_breakdown_sessions_month` | Sessions per month | الجلسات شهرياً | |
| `service_breakdown_sessions_week` | Sessions per week | الجلسات أسبوعياً | |
| `service_choose_schedule` | Choose your schedule | اختر جدولك الزمني | |
| `service_cleaner_hint` | Each cleaner covers their own area in 4 hrs. | كل منظّف يغطي منطقته في 4 ساعات. | |
| `service_cleaner_plural` | Cleaners | منظّفون | |
| `service_cleaner_singular` | Cleaner | منظّف | |
| `service_continue` | Continue | متابعة | |
| `service_days_hint` | Choose between 1 and 6 days. | اختر بين يوم واحد و6 أيام. | |
| `service_days_per_week` | How many days per week? | كم عدد الأيام أسبوعياً؟ | |
| `service_duration` | Duration | المدة | |
| `service_how_many_cleaners` | How many cleaners? | كم عدد المنظّفين؟ | |
| `service_jobs` | {n} jobs | {n} مهمة | |
| `service_my_cleaners` | My Cleaners | منظّفيّ | |
| `service_my_cleaners_selected` | My Cleaners · {sel}/{max} selected | منظّفيّ · {sel}/{max} محدّد | |
| `service_not_found` | Service not found. | الخدمة غير موجودة. | |
| `service_preferred_cleaner` | Preferred Cleaner | المنظّف المفضّل | |
| `service_preferred_cleaners` | Preferred Cleaners | المنظّفون المفضّلون | |
| `service_preferred_hint` | Select up to {n} preferred cleaner{s}, or let us find the best match. | اختر حتى {n} منظّف{s} مفضّل، أو دعنا نجد الأفضل. | |
| `service_rate` | EGP {price} / cleaner / session | {price} جنيه / منظّف / جلسة | |
| `service_select_more_day` | Select {n} more day | اختر {n} يوماً آخر | |
| `service_select_more_days` | Select {n} more days | اختر {n} أيام أخرى | |
| `service_selected_address` | Service Location | موقع الخدمة | |
| `service_session_duration` | 4 hours per session | 4 ساعات لكل جلسة | |
| `service_view_profile` | View Profile | عرض الملف | |
| `service_whats_included` | What's Included | ما المُتضَمَّن | |
| `service_which_days` | Which days? | أي الأيام؟ | |
| `settings_app` | App | التطبيق | |
| `settings_email_hint` | Invoice sent after each session | فاتورة تُرسل بعد كل جلسة | |
| `settings_email_receipts` | Email Receipts | إيصالات البريد الإلكتروني | |
| `settings_notifications` | Notifications | الإشعارات | |
| `settings_order_hint` | Cleaner on the way, session started | المنظّف في الطريق، بدأت الجلسة | |
| `settings_order_updates` | Order Updates | تحديثات الطلبات | |
| `settings_privacy` | Privacy Policy | سياسة الخصوصية | |
| `settings_promotions` | Promotions & Offers | العروض والخصومات | |
| `settings_promotions_hint` | Discounts and special deals | التخفيضات والعروض الخاصة | |
| `settings_push_hint` | Booking confirmations and reminders | تأكيدات الحجز والتذكيرات | |
| `settings_push_notifications` | Push Notifications | إشعارات الدفع | |
| `settings_terms` | Terms of Service | شروط الخدمة | |
| `settings_title` | Settings | الإعدادات | |
| `settings_version` | App Version | إصدار التطبيق | |
| `signup_consent_middle` |  and  |  و | |
| `signup_consent_prefix` | By continuing, you agree to our  | بمواصلتك، فإنك توافق على  | |
| `signup_consent_privacy` | Privacy Policy | سياسة الخصوصية | |
| `signup_consent_terms` | Terms | الشروط | |
| `subscription_active_label` | Active | نشط | |
| `subscription_cancel` | Cancel | إلغاء | |
| `subscription_cancel_confirm` | Cancel this subscription? Future sessions will not be charged. | هل تريد إلغاء هذا الاشتراك؟ لن تُحتسب الجلسات القادمة. | |
| `subscription_freq_biweekly` | Bi-weekly | كل أسبوعين | |
| `subscription_freq_monthly` | Monthly | شهري | |
| `subscription_freq_weekly` | Weekly | أسبوعي | |
| `subscription_pause` | Pause | إيقاف | |
| `subscription_paused_label` | Paused | متوقف | |
| `subscription_resume` | Resume | استئناف | |
| `subscription_started` | Started {date} | بدأ في {date} | |
| `subscriptions_4hrs` | 4 hours | 4 ساعات | |
| `subscriptions_active` | Active | نشط | |
| `subscriptions_browse` | Browse Subscription Plans | تصفح خطط الاشتراك | |
| `subscriptions_cleaner` | {n} cleaner | {n} منظّف | |
| `subscriptions_cleaner_plural` | {n} cleaners | {n} منظّفون | |
| `subscriptions_cleaners` | Cleaners | المنظّفون | |
| `subscriptions_count` | {n} active subscription | {n} اشتراك نشط | |
| `subscriptions_count_plural` | {n} active subscriptions | {n} اشتراكات نشطة | |
| `subscriptions_days_label` | Days | الأيام | |
| `subscriptions_days_week` | {n} days/week | {n} أيام/أسبوع | |
| `subscriptions_empty_subtitle` | Subscribe to a cleaning plan for regular, scheduled cleaning. | اشترك في خطة تنظيف للحصول على تنظيف منتظم ومجدوَل. | |
| `subscriptions_empty_title` | No active subscriptions | لا توجد اشتراكات نشطة | |
| `subscriptions_frequency` | Frequency | التكرار | |
| `subscriptions_manage` | Manage Subscription | إدارة الاشتراك | |
| `subscriptions_per_session` | Per session | لكل جلسة | |
| `subscriptions_title` | My Subscriptions | اشتراكاتي | |
| `timeline_completed` | Completed | اكتمل | |
| `timeline_confirmed` | Booking confirmed | تم تأكيد الحجز | |
| `timeline_en_route` | Cleaner on the way | المنظّف في الطريق | |
| `timeline_in_progress` | Cleaning in progress | جاري التنظيف | |
| `welcome_create_account` | Create an account | إنشاء حساب | |
| `welcome_sign_in` | Sign in | تسجيل الدخول | |
| `welcome_tagline` | Cleaning services, on demand. | خدمات التنظيف عند الطلب. | |

## 3. Marketing site (`spotless-web`)

**Source**: `spotless-web/src/i18n/ui.ts`

**Keys**: 124  •  **Missing AR**: 0  •  **Missing EN**: 0

| Key | English (source) | Arabic (draft) | Reviewer notes |
|---|---|---|---|
| `contact.emailLabel` | Email | البريد الإلكتروني | |
| `contact.formNote` | Prefer to write to us? Send an email to support@spotless.eg or message us on WhatsApp — we reply within one business day. | تفضّل الكتابة إلينا؟ راسلنا على support@spotless.eg أو عبر واتساب — نردّ خلال يوم عمل واحد. | |
| `contact.hoursLabel` | Hours | ساعات العمل | |
| `contact.hoursValue` | Sun–Thu, 8am–10pm | الأحد–الخميس، 8 ص–10 م | |
| `contact.methodsHeading` | Reach us directly | تواصل معنا مباشرة | |
| `contact.phoneLabel` | Phone | الهاتف | |
| `contact.subtitle` | Booking questions, complaints, partnership inquiries — we read every message. The fastest channels are WhatsApp and email. | أسئلة الحجز، الشكاوى، استفسارات الشراكة — نقرأ كل رسالة. أسرع القنوات هي واتساب والبريد الإلكتروني. | |
| `contact.title` | Contact us | تواصل معنا | |
| `contact.whatsappLabel` | WhatsApp | واتساب | |
| `download.subtitle` | Download the app, add your address, and book your first cleaning in under a minute. | حمّل التطبيق، أضف عنوانك، واحجز أول جلسة تنظيف في أقل من دقيقة. | |
| `download.title` | Ready for a spotless home? | مستعد لمنزل لامع النظافة؟ | |
| `footer.contact` | Contact | تواصل معنا | |
| `footer.copyright` | Spotless. All rights reserved. | سبوتلِس. جميع الحقوق محفوظة. | |
| `footer.legalHeading` | Legal | الشؤون القانونية | |
| `footer.privacy` | Privacy Policy | سياسة الخصوصية | |
| `footer.siteHeading` | Site | الموقع | |
| `footer.supportHeading` | Support | الدعم | |
| `footer.terms` | Terms of Service | شروط الخدمة | |
| `hero.appStoreBig` | App Store | App Store | |
| `hero.appStoreSmall` | Download on the | حمّل من | |
| `hero.badge` | Book in under 60 seconds | احجز في أقل من 60 ثانية | |
| `hero.footer` | Available in Egypt · Free to download | متوفر في مصر · تحميل مجاني | |
| `hero.playStoreBig` | Google Play | Google Play | |
| `hero.playStoreSmall` | Get it on | احصل عليه على | |
| `hero.stats[0].label` | Vetted cleaners | منظّفون موثوقون | |
| `hero.stats[0].value` | 500+ | +500 | |
| `hero.stats[1].label` | Homes cleaned | منازل نُظِّفت | |
| `hero.stats[1].value` | 10k+ | +10 آلاف | |
| `hero.stats[2].label` | Average rating | متوسط التقييم | |
| `hero.stats[2].value` | 4.9★ | ★4.9 | |
| `hero.subtitle` | Professional cleaning services available on demand across Egypt. Vetted cleaners, flexible scheduling, and transparent pricing — all in one app. | خدمات تنظيف احترافية عند الطلب في جميع أنحاء مصر. منظّفون موثوقون، جدولة مرنة، وتسعير شفاف — كل ذلك في تطبيق واحد. | |
| `hero.titleLine1` | A spotless home, | منزل لامع النظافة، | |
| `hero.titleLine2` | on your terms. | وفق شروطك. | |
| `howItWorks.steps[0].description` | Browse our cleaning services and pick the one that fits your home and schedule. | تصفّح خدماتنا للتنظيف واختر ما يناسب منزلك وجدولك. | |
| `howItWorks.steps[0].number` | 01 | 01 | |
| `howItWorks.steps[0].title` | Choose your service | اختر خدمتك | |
| `howItWorks.steps[1].description` | Select your preferred date, arrival time, and number of cleaners. It takes under a minute. | اختر التاريخ المناسب، ووقت الوصول، وعدد المنظّفين. كل ذلك في أقل من دقيقة. | |
| `howItWorks.steps[1].number` | 02 | 02 | |
| `howItWorks.steps[1].title` | Book a date & time | احجز التاريخ والوقت | |
| `howItWorks.steps[2].description` | A vetted, background-checked professional arrives at your door ready to work. | محترف موثوق ومُحقَّق من خلفيته يصل إلى بابك مستعداً للعمل. | |
| `howItWorks.steps[2].number` | 03 | 03 | |
| `howItWorks.steps[2].title` | Your cleaner arrives | وصول المنظّف | |
| `howItWorks.subtitle` | Up and running in three simple steps | ابدأ في ثلاث خطوات بسيطة | |
| `howItWorks.title` | How it works | كيف يعمل | |
| `languageSwitch.ariaLabel` | Switch to Arabic | التبديل إلى الإنجليزية | |
| `languageSwitch.href` | /ar/ | / | |
| `languageSwitch.label` | العربية | English | |
| `legal.backHome` | Back to home | العودة إلى الرئيسية | |
| `legal.counselNotice` | This page is a working draft and is subject to review by legal counsel before publication. | هذه الصفحة مسودة قيد العمل وتخضع للمراجعة من قِبل المستشار القانوني قبل النشر. | |
| `legal.lastUpdatedLabel` | Last updated | آخر تحديث | |
| `meta.description` | Book vetted professional cleaners on demand. Flexible scheduling, transparent pricing, and a spotless home every time. Download the app today. | احجز منظّفين محترفين موثوقين عند الطلب. جدولة مرنة، تسعير شفاف، ومنزل لامع النظافة في كل مرة. حمّل التطبيق اليوم. | |
| `meta.title` | Spotless — On-Demand Cleaning Services | سبوتلِس — خدمات التنظيف عند الطلب | |
| `nav.download` | Download App | حمّل التطبيق | |
| `nav.howItWorks` | How it works | كيف يعمل | |
| `nav.services` | Services | الخدمات | |
| `nav.whySpotless` | Why Spotless | لماذا سبوتلِس | |
| `privacy.intro` | Spotless (operated in Egypt) takes the privacy of its users seriously. This policy explains what personal data we collect, how we use it, and the rights you have under Egypt’s Data Protection Law (Law No. 151 of 2020). | تأخذ سبوتلِس (التي تعمل في مصر) خصوصية مستخدميها على محمل الجد. توضح هذه السياسة البيانات الشخصية التي نجمعها، وكيفية استخدامنا لها، وحقوقك بموجب قانون حماية البيانات المصري رقم 151 لسنة 2020. | |
| `privacy.sections[0].body` | When you create an account in the Spotless app we collect your phone number, full name, optional email address, home address(es), and the location coordinates of those addresses. When you book a service we collect the booking details (date, time, number of cleaners, service type, notes you provide) and any payments made. When you use the app we automatically collect device-level data needed to deliver service — app version, device model, OS version, language, and a Firebase Cloud Messaging device token if you opt in to notifications. | عند إنشاء حساب في تطبيق سبوتلِس نقوم بجمع رقم هاتفك، واسمك الكامل، وبريدك الإلكتروني (اختياري)، وعنوان (عناوين) منزلك، والإحداثيات الجغرافية لتلك العناوين. عند إجراء حجز نجمع تفاصيل الحجز (التاريخ، الوقت، عدد المنظّفين، نوع الخدمة، الملاحظات التي تقدّمها) وأي مدفوعات تتم. عند استخدام التطبيق نجمع تلقائياً بيانات الجهاز اللازمة لتقديم الخدمة — إصدار التطبيق، طراز الجهاز، إصدار نظام التشغيل، اللغة، ورمز جهاز Firebase Cloud Messaging إذا اخترت تلقي الإشعارات. | |
| `privacy.sections[0].title` | Information we collect | المعلومات التي نجمعها | |
| `privacy.sections[1].body` | We use your data to operate the service: to confirm bookings, dispatch cleaners, send transactional notifications (booking confirmed, cleaner en route, etc.), process payments, respond to support requests, prevent fraud, comply with our legal obligations, and improve the service. We do not sell personal data to third parties. | نستخدم بياناتك لتشغيل الخدمة: لتأكيد الحجوزات، وإرسال المنظّفين، وإرسال إشعارات المعاملات (تأكيد الحجز، المنظّف في الطريق، إلخ)، ومعالجة المدفوعات، والرد على طلبات الدعم، ومنع الاحتيال، والامتثال للالتزامات القانونية، وتحسين الخدمة. لا نبيع البيانات الشخصية لأطراف ثالثة. | |
| `privacy.sections[1].title` | How we use it | كيف نستخدمها | |
| `privacy.sections[2].body` | We share the minimum information necessary with our cleaners and partners — your first name, address, and booking details — so they can deliver the service. We use Firebase / Google Cloud as our backend infrastructure provider; your data is stored in Google Cloud regions inside the Middle East. We do not share your data with advertisers. | نشارك الحد الأدنى من المعلومات الضرورية مع منظّفينا وشركائنا — اسمك الأول، والعنوان، وتفاصيل الحجز — حتى يتمكنوا من تقديم الخدمة. نستخدم Firebase / Google Cloud كمزوّد للبنية التحتية الخلفية؛ تُخزَّن بياناتك في مناطق Google Cloud داخل الشرق الأوسط. لا نشارك بياناتك مع المعلنين. | |
| `privacy.sections[2].title` | Sharing | المشاركة | |
| `privacy.sections[3].body` | Account data is retained for as long as your account is active. After account deletion, identifying personal data is removed within 30 days, except for records we must retain for tax or legal reasons (e.g. payment invoices) which are kept in anonymised form for the period required by Egyptian law. | نحتفظ ببيانات الحساب طوال فترة نشاط حسابك. بعد حذف الحساب تُحذف البيانات الشخصية المعرِّفة خلال 30 يوماً، باستثناء السجلات التي يجب الاحتفاظ بها لأغراض ضريبية أو قانونية (مثل فواتير الدفع) والتي تُحفظ بشكل مجهول الهوية للفترة التي يقتضيها القانون المصري. | |
| `privacy.sections[3].title` | Retention | الاحتفاظ بالبيانات | |
| `privacy.sections[4].body` | Under Law No. 151 of 2020 you have the right to access the personal data we hold about you, to correct it, to ask us to delete it, and to withdraw consent for processing that relies on consent. In-app data export and account deletion are available from the account screen. You can also reach us using the contact details below. | بموجب القانون رقم 151 لسنة 2020 لك الحق في الوصول إلى البيانات الشخصية التي نحتفظ بها عنك، وتصحيحها، وطلب حذفها، وسحب الموافقة على المعالجة التي تعتمد على الموافقة. يتوفّر تصدير البيانات وحذف الحساب من داخل التطبيق من خلال شاشة الحساب. يمكنك أيضاً التواصل معنا عبر بيانات الاتصال أدناه. | |
| `privacy.sections[4].title` | Your rights | حقوقك | |
| `privacy.sections[5].body` | This marketing website uses Plausible Analytics for aggregate usage statistics (page views, button clicks, country-level traffic). Plausible is privacy-friendly: it does not use cookies, does not track individuals across sites, and stores no personal data. Its data-collection notice is at plausible.io/data-policy. We do not use advertising cookies; if we ever add advertising or non-essential cookies we will surface a clear consent prompt and update this page. | يستخدم هذا الموقع الإلكتروني التسويقي خدمة Plausible Analytics لإحصاءات الاستخدام التجميعية (مرّات عرض الصفحات، النقرات على الأزرار، حركة المرور حسب الدولة). Plausible صديق للخصوصية: لا يستخدم ملفات تعريف الارتباط، ولا يتتبّع الأفراد عبر المواقع، ولا يخزّن أي بيانات شخصية. إشعار جمع البيانات الخاص به على plausible.io/data-policy. لا نستخدم ملفات تعريف ارتباط إعلانية؛ إذا أضفنا لاحقاً أي ملفات تعريف ارتباط إعلانية أو غير ضرورية فسنعرض إشعار موافقة واضحاً ونحدّث هذه الصفحة. | |
| `privacy.sections[5].title` | Cookies and analytics | ملفات تعريف الارتباط والتحليلات | |
| `privacy.sections[6].body` | For any privacy-related request — access, correction, deletion, or a complaint — email support@spotless.eg with the subject line "Privacy request". We aim to respond within 14 days. | لأي طلب يتعلّق بالخصوصية — الوصول، التصحيح، الحذف، أو الشكوى — راسلنا على support@spotless.eg مع وضع "طلب خصوصية" في موضوع البريد. نسعى للرد خلال 14 يوماً. | |
| `privacy.sections[6].title` | Contact for data requests | جهة الاتصال لطلبات البيانات | |
| `privacy.title` | Privacy Policy | سياسة الخصوصية | |
| `services.items[0].description` | A one-time professional home cleaning by trained, vetted cleaners. Each cleaner works a full 4-hour session — add more for bigger spaces. | تنظيف منزلي احترافي لمرة واحدة يقوم به منظّفونا المدرّبون. كل منظّف يعمل جلسة كاملة مدتها 4 ساعات — أضف المزيد للمساحات الأكبر. | |
| `services.items[0].icon` | 🧹 | 🧹 | |
| `services.items[0].price` | From EGP 120 / session | يبدأ من 120 ج.م. / جلسة | |
| `services.items[0].title` | Single-Visit Cleaning | تنظيف فردي | |
| `services.items[1].description` | Recurring professional cleaning on your schedule. Pick how many cleaners, how many days a week, and exactly which days — we handle the rest. | تنظيف احترافي متكرر وفق جدولك الزمني. اختر عدد المنظّفين وعدد الأيام أسبوعياً والأيام بالتحديد — نحن نتولى الباقي. | |
| `services.items[1].icon` | 📅 | 📅 | |
| `services.items[1].price` | From EGP 100 / session | يبدأ من 100 ج.م. / جلسة | |
| `services.items[1].title` | Monthly Cleaning Subscription | اشتراك تنظيف شهري | |
| `services.items[2].description` | A comprehensive deep clean that reaches every corner, crack, and surface. Each cleaner covers their section thoroughly in 4 hours. | تنظيف عميق شامل يصل إلى كل زاوية وسطح. كل منظّف يغطي قسمه بعناية فائقة في 4 ساعات. | |
| `services.items[2].icon` | ✨ | ✨ | |
| `services.items[2].price` | From EGP 160 / session | يبدأ من 160 ج.م. / جلسة | |
| `services.items[2].title` | Home Deep Cleaning | تنظيف عميق للمنزل | |
| `services.items[3].description` | Professional upholstery cleaning that removes embedded dirt, stains, and odors from sofas, armchairs, dining chairs, and mattresses. Priced per item. | تنظيف احترافي للمفروشات يزيل الأوساخ المتراكمة والبقع والروائح من الأرائك والكراسي والمراتب. السعر حسب القطعة. | |
| `services.items[3].icon` | 🛋️ | 🛋️ | |
| `services.items[3].price` | From EGP 25 / item | يبدأ من 25 ج.م. / قطعة | |
| `services.items[3].title` | Furniture Deep Cleaning | تنظيف عميق للأثاث | |
| `services.subtitle` | From a quick tidy-up to a complete overhaul | من تنظيف سريع إلى تجديد شامل | |
| `services.title` | Our services | خدماتنا | |
| `terms.intro` | These terms govern your use of the Spotless service in Egypt. By creating an account or making a booking you agree to be bound by them. | تحكم هذه الشروط استخدامك لخدمة سبوتلِس في مصر. بإنشاء حساب أو إجراء حجز فإنك توافق على الالتزام بها. | |
| `terms.sections[0].body` | Spotless connects customers with vetted cleaning professionals. We coordinate bookings, dispatch cleaners, and process payments. The cleaning work itself is performed by cleaners working under our coordination. | تصل سبوتلِس بين العملاء ومنظّفين محترفين موثوقين. نتولّى تنسيق الحجوزات وإرسال المنظّفين ومعالجة المدفوعات. أعمال التنظيف نفسها يقوم بها المنظّفون بإشرافنا. | |
| `terms.sections[0].title` | The service | الخدمة | |
| `terms.sections[1].body` | You must be 18 or older to create an account. You are responsible for the accuracy of the information you provide and for activity that occurs under your account. Keep your phone number current — we use it for authentication and for cleaner contact during a booking. | يجب أن تكون عمرك 18 عاماً فأكثر لإنشاء حساب. أنت مسؤول عن دقة المعلومات التي تقدّمها وعن النشاط الذي يحدث تحت حسابك. حافظ على تحديث رقم هاتفك — نستخدمه للمصادقة ولتواصل المنظّف معك أثناء الحجز. | |
| `terms.sections[1].title` | Accounts | الحسابات | |
| `terms.sections[2].body` | Service prices are shown in Egyptian pounds (EGP) in the app at the time of booking. You agree to the price displayed when you confirm a booking. Payment is processed via the method you select; you authorise Spotless to charge that method for the booking total and any agreed extras. Tax-inclusive invoices are made available in the app where required. | تُعرض أسعار الخدمات بالجنيه المصري (EGP) في التطبيق عند الحجز. أنت توافق على السعر المعروض عند تأكيد الحجز. تتم معالجة الدفع عبر الطريقة التي تختارها؛ وتفوّض سبوتلِس بخصم إجمالي الحجز وأي إضافات متّفق عليها من هذه الطريقة. تتوفّر فواتير شاملة الضريبة في التطبيق حيث يكون ذلك مطلوباً. | |
| `terms.sections[2].title` | Bookings, pricing, and payment | الحجوزات والأسعار والدفع | |
| `terms.sections[3].body` | Bookings may be cancelled or rescheduled up to the cutoff stated in the app for that service. Cancellations after the cutoff may incur a late-cancellation fee as disclosed at booking time. | يمكن إلغاء الحجوزات أو إعادة جدولتها حتى الموعد النهائي المنصوص عليه في التطبيق لتلك الخدمة. قد يستتبع الإلغاء بعد الموعد النهائي رسوم إلغاء متأخر يُفصح عنها وقت الحجز. | |
| `terms.sections[3].title` | Cancellation and rescheduling | الإلغاء وإعادة الجدولة | |
| `terms.sections[4].body` | You agree to provide a safe working environment for the cleaner and to treat them with respect. Harassment, abuse, or unsafe conditions are grounds for immediate cancellation without refund and account suspension. You are also responsible for securing valuables before the cleaner arrives. | توافق على توفير بيئة عمل آمنة للمنظّف ومعاملته باحترام. التحرّش أو الإساءة أو الظروف غير الآمنة أسباب للإلغاء الفوري دون استرداد المبلغ وتعليق الحساب. أنت أيضاً مسؤول عن تأمين الأشياء الثمينة قبل وصول المنظّف. | |
| `terms.sections[4].title` | Customer conduct | سلوك العميل | |
| `terms.sections[5].body` | Spotless screens and vets its cleaners but is not liable for incidental damages caused during a cleaning beyond what is recoverable under the cleaner’s insurance and our incident-resolution process. To the maximum extent permitted by Egyptian law, our total liability to you for any claim arising from the service is capped at the amount you paid for the booking giving rise to the claim. | تقوم سبوتلِس بفحص منظّفيها والتحقّق منهم، لكنها ليست مسؤولة عن الأضرار العرضية الناتجة أثناء التنظيف بما يتجاوز ما يمكن استرداده بموجب تأمين المنظّف وعملية حل الحوادث لدينا. وفقاً لأقصى ما يسمح به القانون المصري، تقتصر مسؤوليتنا الإجمالية تجاهك عن أي مطالبة ناشئة عن الخدمة على المبلغ الذي دفعته للحجز الذي نشأت عنه المطالبة. | |
| `terms.sections[5].title` | Liability | المسؤولية | |
| `terms.sections[6].body` | We may update the service, prices, and these terms from time to time. Material changes will be notified in-app or by email. Continued use after such a change constitutes acceptance. | قد نقوم بتحديث الخدمة والأسعار وهذه الشروط من وقت لآخر. سنخطرك بالتغييرات الجوهرية داخل التطبيق أو عبر البريد الإلكتروني. الاستمرار في الاستخدام بعد هذا التغيير يُعدّ قبولاً به. | |
| `terms.sections[6].title` | Changes to the service or terms | تغييرات على الخدمة أو الشروط | |
| `terms.sections[7].body` | These terms are governed by the laws of the Arab Republic of Egypt. Any dispute that cannot be resolved informally will be submitted to the courts of Cairo. | تخضع هذه الشروط لقوانين جمهورية مصر العربية. أي نزاع لا يمكن حله ودياً يُحال إلى محاكم القاهرة. | |
| `terms.sections[7].title` | Governing law | القانون الحاكم | |
| `terms.sections[8].body` | Questions about these terms? Use the contact details on our contact page or email support@spotless.eg. | لديك سؤال حول هذه الشروط؟ استخدم بيانات الاتصال في صفحة التواصل، أو راسلنا على support@spotless.eg. | |
| `terms.sections[8].title` | Contact | تواصل معنا | |
| `terms.title` | Terms of Service | شروط الخدمة | |
| `whySpotless.items[0].description` | Every cleaner is background-checked, trained, and reviewed by real customers before joining Spotless. | كل منظّف يخضع لفحص خلفية، تدريب، ومراجعة من عملاء حقيقيين قبل الانضمام إلى سبوتلِس. | |
| `whySpotless.items[0].icon` | ✅ | ✅ | |
| `whySpotless.items[0].title` | Vetted Professionals | محترفون موثوقون | |
| `whySpotless.items[1].description` | Book same-day or up to a month in advance. Reschedule or cancel anytime with no fees. | احجز في نفس اليوم أو حتى شهر مقدماً. أعد الجدولة أو ألغِ في أي وقت بدون رسوم. | |
| `whySpotless.items[1].icon` | 📅 | 📅 | |
| `whySpotless.items[1].title` | Flexible Scheduling | جدولة مرنة | |
| `whySpotless.items[2].description` | No hidden fees. See the full price before you confirm — per session or monthly subscription. | بدون رسوم خفية. شاهد السعر الكامل قبل التأكيد — للجلسة أو الاشتراك الشهري. | |
| `whySpotless.items[2].icon` | 💰 | 💰 | |
| `whySpotless.items[2].title` | Transparent Pricing | تسعير شفاف | |
| `whySpotless.items[3].description` | Choose from top-rated cleaners or let us match you with the best available professional. | اختر من بين المنظّفين الأعلى تقييماً أو اترك لنا اختيار الأنسب لك. | |
| `whySpotless.items[3].icon` | ⭐ | ⭐ | |
| `whySpotless.items[3].title` | Rated & Reviewed | تقييمات ومراجعات | |
| `whySpotless.subtitle` | Built for busy people who expect more | مصمم لمن يحتاجون أكثر من وقتهم | |
| `whySpotless.title` | Why Spotless? | لماذا سبوتلِس؟ | |

