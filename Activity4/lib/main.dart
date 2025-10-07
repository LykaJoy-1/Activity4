import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/cleaning_booking_screen.dart';

void main() {
  runApp(HomeCleaningApp());
}

class HomeCleaningApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Cleaning Service Booking',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: LoginScreen(),
      routes: {
        '/booking': (context) => CleaningBookingScreen(),
      },
    );
  }
}
