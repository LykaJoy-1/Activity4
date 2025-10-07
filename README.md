# CleanHome — Home Cleaning Service Scheduling and Payment

Production-ready Flutter mockup that demonstrates a complete cleaning service flow (login, booking, order summary) and fulfills Activity 3 and Activity 4 requirements with meaningful, in-app placements.

## Where each Activity requirement lives

### Activity 3 — Forms & Input Handling
1. (3.1) Simple TextFormField + controller preview
   - `lib/screens/username_demo_screen.dart`
2. (3.2) Login form with email and password
   - `lib/screens/login_screen.dart`
3. (3.3) Validation: email contains "@", password non-empty
   - `lib/screens/login_screen.dart`
4. (3.4) Use `GlobalKey<FormState>`
   - `lib/screens/login_screen.dart`, `lib/screens/registration_screen.dart`, `lib/screens/cleaning_booking_screen.dart`
5. (3.5) TextField + Checkbox + Switch in a form
   - `lib/screens/cleaning_booking_screen.dart`
6. (3.6) Registration form (name, email, password, confirm password)
   - `lib/screens/registration_screen.dart`
7. (3.7) Dropdown inside a form (role/type)
   - `lib/screens/cleaning_booking_screen.dart`
8. (3.8) Date picker and time picker
   - `lib/screens/cleaning_booking_screen.dart`
9. (3.9) Controller to capture and display text; notes dialog
   - `lib/screens/username_demo_screen.dart`, `lib/screens/cleaning_booking_screen.dart`
10. (3.10) Save data locally and display beneath form
    - `lib/screens/cleaning_booking_screen.dart`

### Activity 4 — Navigation (Stack, Drawer, Bottom Tabs, TabBar)
1. (4.1) Two screens with push/pop
   - `lib/screens/two_screen_demo.dart`
2. (4.2) Drawer to three pages
   - `lib/screens/home_screen.dart` (`_AppDrawer`)
3. (4.3) BottomNavigationBar with three tabs
   - `lib/screens/home_screen.dart`
4. (4.4) TabBar with TabBarView inside Scaffold
   - `lib/screens/home_screen.dart` (Settings tab)
5. (4.5) Icons on BottomNavigationBar items
   - `lib/screens/home_screen.dart`
6. (4.6) Combine Drawer and BottomNavigationBar
   - `lib/screens/home_screen.dart`
7. (4.7) Named routes for Home, About, Contact
   - `lib/main.dart`
8. (4.8) push() vs pushReplacement()
   - `lib/screens/push_replace_demo.dart`, also used in order completion
9. (4.9) TabBar inside AppBar with three tabs (Chats, Tickets, Calls)
   - `lib/screens/appbar_tabs_screen.dart`
10. (4.10) Login → Home (Drawer + Bottom Tabs)
    - `lib/screens/login_screen.dart` → `lib/screens/home_screen.dart`

## Key user flows
- Login → Home (Dashboard)
- Quick Booking: Service Selection → Review → Booking Form → Order Summary
- Booking Form → Order Summary with action buttons
- Drawer: About, Contact, Support Center, Quick Feedback, Service Complete
- Settings: Preferences and Privacy tabs with meaningful options

## Tech notes
- Responsive layouts: primary lists use `ListView` with padding.
- The order summary is scrollable to prevent overflow.
- Routes: configured in `lib/main.dart`.

## Run
```
flutter run
```
