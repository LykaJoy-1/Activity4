import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // (Activity #3.4: Use a GlobalKey<FormState> to manage validation and submission.)
  final _formKey = GlobalKey<FormState>();
  // (Activity #3.2: Build a login form with two fields: email and password.)
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // (Activity #3.3: Validate email contains "@" and password is not empty.)
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty || !value.contains('@')) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  // Fixed login credentials: email = 'lyka@demo.com', password = 'lyka'
  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      if (_emailController.text == 'lyka@demo.com' &&
          _passwordController.text == 'lyka') {
        // (Activity #4.10: Build a navigation flow where login navigates to a home screen containing a Drawer and Bottom Tabs.)
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or password. Please try again.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey, // Activity #4
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: _validatePassword,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitLogin,
                child: Text('Login'),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
