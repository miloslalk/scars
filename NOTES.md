# Product Rules Log

## Registration
- Email/password registration is required.
- Username must be unique and at least 6 characters.
- Password rules: min 8 chars, at least 1 uppercase, 1 number, 1 special.
- Confirm password must match.
- Password visibility toggle is available.
- Terms checkbox required; link opens Terms page (lorem ipsum for now).
- Real-time username availability check with inline feedback.
- Email verification required; expires after 5 days.
- If verification expired, account is deleted on next login attempt.
- Registration signs the new user out after sending the verification email, and auto-login re-checks `emailVerified` for password accounts, so an unverified session can never reach the home screen.
- Login warning: "Please verify your email {email} until {expiration date}".

## Authentication
- Firebase Auth is the source of truth for passwords.
- Login supports email or username (username resolves to email via RTDB index).
- Google sign-in is supported; new users get a generated unique username.
- Logout clears session and returns to landing page.
- Login password field has an eye toggle for visibility.
- ~~TODO (before production): finalize Google OAuth consent screen branding in Google Cloud so Google sign-in shows `When Scars (!) Become Art` instead of `project-537...`.~~ DONE
- Android Google Sign-In checklist:
- Firebase Android app package must be `eu.whenscarsbecomeart.app`.
- Required SHA-1 fingerprints in Firebase for this app:
- Debug: `4B:D3:10:70:0E:32:28:F3:FD:4E:09:60:77:2A:DC:AC:3D:61:8C:41`
- Release/upload: `28:DC:D8:63:D9:20:CB:A4:C4:32:4C:28:86:32:96:6F:08:FF:3F:DC`
- After adding fingerprints: redownload `android/app/google-services.json`, then run `flutter clean`, `flutter pub get`, uninstall app, and rerun.

## Drawings
- Canvas supports brush, eraser, undo, and text tool (draggable).
- Save uploads image to Firebase Storage at `users/{uid}/drawings/{username_timestamp}.png`.
- Save writes metadata to RTDB `users/{uid}/drawings/{timestamp}`.
- Storage and RTDB rules restrict access to the authenticated user.
- Calendar day view pulls all drawings for the selected date and allows deletion with confirmation.

## Avatars
- Users can set an avatar from camera or gallery.
- Avatar uploads to Storage at `users/{uid}/avatars/avatar.jpg`.
- Avatar URL stored in RTDB at `users/{uid}/avatarUrl`.
- Removing avatar deletes storage object and clears `avatarUrl`.

## Prompt & Music
- On Save/Skip, show body check dialog.
- If user chooses Yes, open music player and play the provided MP3.
- Music player has Play/Pause and Skip.

## Localization
- English-only strings for new work until translations are requested.

## Process
- Keep this file updated whenever new product rules/behaviors are added.

## My Space
- My Space is a lock-tab hub with Calendar, Journal, and Library tiles.
- Calendar uses a date picker and full-screen modal carousel (Mood, Body, Quote, Note).
- Mood page shows drawings for the day; Note page shows the latest journal entry for the day.
- Body page shows the saved body awareness point for the day.

## Journal
- Journal entries are stored per user at `users/{uid}/journal/{entryId}`.
- Entry metadata: text, createdAt, fontFamily, isBold, isItalic.

## Settings & Theme
- Settings are opened from the avatar menu; bottom nav settings tab removed.
- Theme selector added (System/Light/Dark).
- Users can update display name; stored in Auth displayName and RTDB `users/{uid}/fullName`.
- Push notifications moved to FCM + Cloud Functions scheduler.
- Daily push: "Good morning" at 09:00 local (device `utcOffsetMinutes` based).
- Inactivity push: "We miss you" when `lastLoginAt` is older than 7 days.
- Device push state stored at `users/{uid}/devices/{tokenKey}` (token/platform/offset/send guards).
- User notification preferences editable in Settings (daily on/off, time, inactivity on/off) and saved at `users/{uid}/notificationPrefs` + synced to `users/{uid}/devices/*`.
- iOS push: Xcode config done (entitlements, UIBackgroundModes, background handler). ~~TODO: Verify APNs Authentication Key (.p8) is uploaded to Firebase Console → Project Settings → Cloud Messaging → Apple app configuration.~~ DONE (Key ID: TGLTC4G32N, Team ID: 2JF89PT6DB).
- ~~TODO: Push QA on iOS — works on Android, need to verify foreground/background behavior on iOS.~~ DONE — added APNs token retry, foreground message listener, and notification tap handlers.
- Re-authenticate action added for password users before sensitive changes.
- Email change sends verification; unchanged email does not re-send.
- Email/password changes locked for non-password providers.
- Password change requires confirmation and enforces strength rules with visibility toggles.

## Body Awareness
- Body awareness captures a tap position and color on the body outline.
- Saved per day at `users/{uid}/body_awareness/{yyyyMMdd}` with x/y/color/createdAt.
- Body awareness screen styled differently in light/dark themes.
- Body regions are detected with basic hit zones; console logs region name.

## Navigation
- Bottom nav includes Home, My Space, Messages, Care Corner.
- Settings moved to avatar menu with a styled dropdown (Settings/Log out).

## Assets & Data
- Mock data assets/repositories removed; app uses Firebase only.
- Body outline asset: `assets/images/Human_body_outline.svg`.
- ~~TODO: Cookie Monster on Android shows gray/noisy artifact in transparent areas (iOS is fine).~~ DONE
- ~~TODO: Replace placeholder exercise dialog title ("Join the Exercise") with final branding name.~~ DONE

## Messages (Balloons)
- Once a user pops a balloon message, it must never be shown again to that user.
- The number of visible balloons equals the number of messages the user has not popped.
- Messages tab shows a continuous stream of animated balloons.
- Balloons are tinted variants of `assets/images/balloon-heart-fill_1.svg`.
- Balloons pop on tap with a brief burst animation.
- Balloon messages do not expire.
- ~~TODO: Limit popping to 1 balloon per day, reset at 00:00 CET (keep unlimited for testing).~~ DONE — gate stored at `users/{uid}/opened_messages/{yyyyMMdd}` using the device-local date (resets at the user's midnight).
- Popped messages are recorded permanently at `users/{uid}/popped_messages/{messageId}` and filtered out on load, so a popped message is never shown to that user again.
- Messages load from RTDB `messages`: the app supports both flat `messages/{id}` entries (`{text, textEn}` — bulk import tool) and per-locale buckets `messages/{locale}/{id}` (`{id, text}` — admin tool; English text resolved from the `en` bucket). There is no assets fallback.
- ~~TODO: Add 365 localized messages per language when provided by client (current list is for testing) using `{id,text}` entries with stable IDs across locales.~~ DONE.
- Admin tool at `tools/messages_import.html` — supports manual single-message add and bulk XLSX import (columns C=native, D=English from Google Form responses). Serve locally: `python3 -m http.server 8080 --directory tools`, then open `http://localhost:8080/messages_import.html`. Requires Google sign-in; only admin UID `Ck216x4lw8PCtFAMU6ybWEPKFee2` has write access to `messages/`.
- Admin tool at `tools/messages_admin.html` — single-message add with English (required) + national languages. Writes to `messages/{locale}/{messageId}` in RTDB. Serve locally: `cd tools && python3 -m http.server 8080`, then open `http://localhost:8080/messages_admin.html`. Requires Google sign-in (Firebase auth domain must allow localhost:8080).

## Care Corner
- Reached from a heart icon in the top app bar on the home scaffold.
- File: `lib/screens/care_corner_page.dart`.

### Flow (3 levels)
1. **Country Hub** — 7 flag bubbles (Romania, Serbia, Greece, North Macedonia, Germany, Turkey, EU) on a star-field background with floating animation. Tapping a flag centers it and reveals 3 orbiting category bubbles (Wellbeing, Support & Services, Education).
2. **Category Grid Page** — purple app bar with breadcrumb (`COUNTRY > CATEGORY HUB`), 2-column grid of topic cards (icon + uppercase title), "Further Reading & Deep Dive" section at the bottom with chevron list items.
3. **Topic Detail Page** — breadcrumb (`Country > Category > Topic`), resource cards with icon/title/description, optional FREE badge, action button row (Call Now, Secure Chat, Visit Website, Email, Schedule Call, Book Appointment).

### Topics per category
- **Wellbeing:** Breathing Exercises, Guided Meditation, Music Sessions, Journaling Prompts, Color Theory Videos, Self-Care Routines.
- **Support:** Violence & Protection, Emergency Services, Local NGOs, Support Groups, Legal Help, Healthcare Access.
- **Education:** Discrimination, Racism, Antigypsyism, Hate Speech Online, Xenophobia, My Rights.
- **Further Reading:** Identity & Belonging, Discrimination Support, When to Seek Help.

### Done
- Country hub with animated bubbles and star field.
- Inner category bubbles orbit the selected flag.
- Category grid page with 2-column topic cards and Material icons.
- Breadcrumb navigation in app bar with back button.
- Further Reading section with chevron list items.
- Topic detail page with placeholder resource cards and action buttons.
- Light/dark mode support throughout.
- All l10n strings in place (`careCornerHub*`, `careCornerAction*`, `careCornerFurtherReading*`, `careCornerTopic*`).

### TODO
- ~~Wire real per-country resources from Firebase (phone numbers, URLs, descriptions per organization).~~ DONE
- ~~Design Firebase data model for per-country resources.~~ DONE
- ~~Further Reading tile `onTap` — needs content or destination.~~ DONE
- ~~Action buttons `onTap` — wire to `url_launcher` (phone dialer, website open, email compose).~~ DONE
- ~~Per-country resource data differs (mockup shows Germany-specific orgs like SIBUZ, Violence Against Women Helpline 0800 116 016).~~ DONE
- ~~Wellbeing topics may need sub-content (e.g. breathing exercises detail page with 5-Finger, Box, 4-7-8 techniques — shown in mockup but not yet built).~~ DONE
- ~~Replace Material icon stand-ins with custom icons/illustrations per topic.~~ DONE
- ~~Resource cards currently show hardcoded placeholder data; replace with dynamic Firebase content.~~ DONE
- TODO: EU Care Corner — content and resources for the EU country bubble.

## Drawing
- Notification timezone handling updated to use device IANA timezone (`timezoneName`) for DST-safe push delivery; UTC offset remains as fallback.

## iOS Release Signing

- ~~TODO: Before iOS release build, the Amaro Drom e.V. organization team must appear in Xcode's Signing & Capabilities → Team dropdown.~~ DONE
- ~~The Account Holder of the Amaro Drom Developer Program needs to grant `kanekacugin@gmail.com` the Admin/Developer role with Certificates access.~~ DONE
- The Xcode project expects team ID `TY675593F3` (Amaro Drom). Personal teams cannot sign with Push Notifications capability.
- APS entitlement has been set to `production` (was `development`).
- `ITSAppUsesNonExemptEncryption = false` added to Info.plist (standard HTTPS only).
- ~~TODO: Upload APNs Authentication Key (.p8) to Firebase Console → Cloud Messaging → Apple app config.~~ DONE (Key ID: TGLTC4G32N, Team ID: 2JF89PT6DB).

## Known Issues
- Fixed: Firebase RTDB rules — `usernames` writes now restricted to owner-or-create, `messages` and `guided_audio` writes locked to admin/Cloud Functions only.
- Fixed: TextEditingControllers in dialog methods in `home_misc.dart` now use try/finally to dispose after dialog returns.
- Fixed: Silent `catch (_) {}` blocks across screens/services replaced with `debugPrint` logging.
- Fixed: RTDB rules — `usernames` is no longer listable (read moved to per-key, so the username→email index can't be enumerated) and new entries must carry the writer's own `uid`.
- Fixed: Auto-login now refreshes `lastLoginAt`/device token, so daily users with persisted sessions no longer receive "We miss you" pushes.
- Fixed: Cloud Functions migrated from retired `functions.config()` to env vars (`functions/.env`, see `functions/.env.example`); `reportMessage` now requires authentication. ~~Note: the in-app report UI does not exist yet — `reportMessage` is unused by the client.~~ Report UI built 2026-07-28.
- Fixed: Exercise clips now play intro → loop → outro (intro was previously skipped).
- Fixed: Account deletion re-authenticates Google/Apple users (via provider) *before* wiping data, so `user.delete()` can no longer fail halfway and leave an orphaned Auth account.
- Fixed: Dark-mode white-on-white text in My Space tiles, journal list, saved messages, and day-view drawing overlays.
- Fixed (2026-07-28 audit): Balloon pop is persisted *before* the pop animation (write-then-animate), so "once popped, never shown again" and the daily limit hold even if the app dies or the write fails (a failed write now shows an error and keeps the balloon).
- Fixed (2026-07-28 audit): Email change is reconciled at login — after `verifyBeforeUpdateEmail` completes, the next login/auto-login syncs the new address into `users/{uid}/email` and `usernames/{key}/email`, so login-by-username no longer breaks permanently after an email change.
- Fixed (2026-07-28 audit): Logout deregisters this device's FCM token (`NotificationService.onLogout`) and resets theme/locale, so signed-out accounts stop receiving pushes on shared devices.
- Fixed (2026-07-28 audit): Notification init no longer blocks the first frame (permission dialog appeared over the splash; an init failure prevented startup), and device registration reads only `notificationPrefs` instead of the whole user tree.
- Fixed (2026-07-28 audit): Account deletion now lists/deletes Storage under `users/{uid}/drawings` and `users/{uid}/avatars` directly — listing `users/{uid}` itself is denied by storage.rules, so previously *no* files were deleted.
- Fixed (2026-07-28 audit): Auto-login only signs out on session-fatal auth codes; a network failure while offline no longer destroys the persisted session.
- Fixed (2026-07-28 audit): Passwords are used exactly as typed everywhere (settings re-auth/change no longer trim), matching registration and login.
- Fixed (2026-07-28 audit): Theme choice is persisted (`users/{uid}/themeMode`) and restored at login, like the locale.
- Fixed (2026-07-28 audit): Calendar day-keys no longer shift a day in UTC-negative timezones (table_calendar hands over UTC date-only markers; they are read by face value now).
- Fixed (2026-07-28 audit): Double-tap guards on mood save/skip, care-corner bookmarks, and category open; stale-response guard on the registration username check; journal load failure shows retry instead of an infinite spinner; failed journal saves offer retry instead of dropping the text.
- Fixed (2026-07-28 audit): Drawing canvas disposes its native bitmaps (save snapshot, flood-fill intermediates, fill layers on unmount); hidden tabs' balloon/star animations are ticker-muted via `TickerMode`.
- Fixed (2026-07-28 audit): Deleting a storage-discovered drawing no longer fails (file names contain `.`, illegal in RTDB paths); already-deleted files no longer block metadata cleanup.
- Fixed (2026-07-28 audit): `moderateMessage` requires a POST confirmation (email scanners prefetch GET links and could auto-approve/reject), uses a timing-safe token compare, and refuses re-review; `reportMessage` handles SMTP failure (marks report `email_failed`, returns a real error). `message_reports` client writes locked (`.write: false` — only the callable writes, via Admin SDK).
- Fixed (2026-07-28 audit): iOS push badge removed from scheduled sends (nothing ever cleared it); Android foreground pushes now surface as an in-app snackbar (previously silently dropped).
- Fixed (2026-07-28 audit): Functions runtime bumped Node 20 → 22 (Node 20 decommission 2026-10-30; deploy needs a current firebase-tools); firebase-admin 12 → 13, nodemailer 6 → 9 (npm audit: 22 vulns → 8 moderate, all one transitive `uuid` advisory inside firebase-admin awaiting upstream).
- Fixed (2026-07-28 audit): `functions/node_modules/` (5,684 files) and `android/build/` untracked from git; `assets/avatars/` + `assets/monster_clips/` + `assets/store/` committed (they are declared in pubspec — fresh clones could not build without them); working docs/backups gitignored.
- Added (2026-07-28 audit): `test/` suite (safeKey, all-locale l10n resolution, monster-clip manifest vs. on-disk files, logo widget) — CI's `flutter test` and `dart format test/` steps were failing on the missing directory.
- Note (2026-07-28 audit): New l10n keys `messageOpenFailed`, `genericLoadFailed`, `genericSaveFailed`, `genericDeleteFailed`, `retryLabel`, `careCornerActionReference` were added to all 9 ARBs in English — needs translation.
- Added (2026-07-28): Tapping outside the body + "Reflect" records the point, and Save now plays the `07_outside_the_body` clip directly (no join prompt — the Reflect choice is the consent), followed by the usual feedback page. `00_intro`/`26_outro` clips remain bundled but unreferenced by code.
- Added (2026-07-28): In-app report UI for balloon messages — flag button on the thought cloud → confirm dialog → `reportMessage` callable → moderation email. New l10n keys `reportLabel`, `reportMessageAction`, `reportMessageConfirmBody`, `reportMessageSent`, `reportMessageFailed` (English in all 9 ARBs — needs translation). Reporting requires `functions/.env` to define SMTP_* , MODERATION_EMAIL, and MODERATION_BASE_URL, or the callable returns failed-precondition.
