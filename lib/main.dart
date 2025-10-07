import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/cleaning_booking_screen.dart';
import 'screens/home_screen.dart'; // (Activity #4.10: Home with Drawer + Bottom Tabs)
import 'screens/about_screen.dart'; // (Activity #4.7: Named route About)
import 'screens/contact_screen.dart'; // (Activity #4.7: Named route Contact)
import 'screens/appbar_tabs_screen.dart'; // (Activity #4.9: AppBar TabBar with three tabs)
import 'screens/two_screen_demo.dart'; // (Activity #4.1: push/pop demo)
import 'screens/push_replace_demo.dart'; // (Activity #4.8: push vs pushReplacement demo)
import 'screens/registration_screen.dart'; // (Activity #3.6: Registration form)
import 'screens/username_demo_screen.dart'; // (Activity #3.1 & #3.9)
import 'screens/order_summary_screen.dart'; // Order completion flow
import 'screens/appointment_details_screen.dart';

void main() {
  runApp(HomeCleaningApp());
}

class HomeCleaningApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleanHome - Professional Cleaning Services',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        scaffoldBackgroundColor: Color(0xFFF7F7F7),
        drawerTheme: DrawerThemeData(backgroundColor: Color(0xFFF7F7F7)),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false, // Removes DEBUG banner from app UI
      home: LoginScreen(),
      // (Activity #4.7: Implement named routes for three screens: Home, About, and Contact.)
      routes: {
        '/home': (context) => HomeScreen(),
        '/about': (context) => AboutScreen(),
        '/contact': (context) => ContactScreen(),
        '/booking': (context) => CleaningBookingScreen(),
        // (Activity #3.6): Registration route
        '/register': (context) => RegistrationScreen(),
        // (Activity #3.1 & #3.9): Username demo route
        '/usernameDemo': (context) => UsernameDemoScreen(),
        // (Activity #4.9: Create a TabBar inside an AppBar with three tabs.)
        '/tabs3': (context) => AppBarTabsScreen(),
        // (Activity #4.1: Two screens and navigate between them using push() and pop().)
        '/twoScreenDemo': (context) => TwoScreenDemoA(),
        // (Activity #4.8: Demonstrate the difference between push() and pushReplacement().)
        '/pushDemo': (context) => PushReplaceDemoA(),
        '/orderSummary': (context) => OrderSummaryScreen(bookingData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/appointmentDetails': (context) => AppointmentDetailsScreen(),
      },
    );
  }
}
