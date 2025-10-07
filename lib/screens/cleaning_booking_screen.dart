import 'package:flutter/material.dart';

class CleaningBookingScreen extends StatefulWidget {
  @override
  _CleaningBookingScreenState createState() => _CleaningBookingScreenState();
}

class _CleaningBookingScreenState extends State<CleaningBookingScreen> {
  // (Activity #3.3: Add form validation to check inputs before submission.)
  final _formKey = GlobalKey<FormState>();

  // (Activity #3.6: Capture multiple inputs including name and email.)
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  // (Activity #3.9: Use a controller to capture and display text via dialog.)
  final _notesController = TextEditingController();

  // (Activity #3.5: Include Checkbox and Switch in the form.)
  bool _termsAccepted = false;
  bool _includeWindowCleaning = false;
  bool _paymentConfirmed = false; // Fake payment confirm checkbox

  // (Activity #3.7: Dropdown menu inside the form to select a role/type.)
  String _customerType = 'Regular';
  String _paymentMethod = 'Credit Card'; // Payment dropdown

  // (Activity #3.8: Date & time pickers for appointment scheduling.)
  DateTime? _pickedDate;
  TimeOfDay? _pickedTime;

  // (Activity #3.10: Save submitted form data locally and display below.)
  final List<Map<String, dynamic>> _bookings = [];

  String? _validateEmail(String? value) {
    if (value == null || !value.contains('@')) return 'Email must contain "@"';
    return null;
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    return null;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (selectedDate != null) setState(() => _pickedDate = selectedDate);
  }

  Future<void> _pickTime() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) setState(() => _pickedTime = selectedTime);
  }

  void _showNotesDialog() {
    final notes = _notesController.text;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Additional Notes'),
        content: Text(notes.isEmpty ? 'No notes entered' : notes),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please accept the terms and conditions to continue.'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!_paymentConfirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please confirm your payment to complete the booking.'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_pickedDate == null || _pickedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select both appointment date and time.'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _bookings.add({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'customerType': _customerType,
        'includeWindowCleaning': _includeWindowCleaning,
        'paymentMethod': _paymentMethod,
        'date': _pickedDate,
        'time': _pickedTime,
        'notes': _notesController.text.trim(),
      });

      _formKey.currentState!.reset();
      _nameController.clear();
      _emailController.clear();
      _notesController.clear();
      _termsAccepted = false;
      _includeWindowCleaning = false;
      _paymentConfirmed = false;
      _customerType = 'Regular';
      _paymentMethod = 'Credit Card';
      _pickedDate = null;
      _pickedTime = null;
    });

    // Navigate to order summary screen instead of just showing a snackbar
    Navigator.pushNamed(
      context, 
      '/orderSummary', 
      arguments: _bookings.last,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Cleaning Service')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Form(
              // (Activity #4.2)
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // (Activity #3.6: Name input)
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: _validateRequired,
                  ),
                  SizedBox(height: 16),

                  // Activity #6 + #3: Email input with validation
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),
                  SizedBox(height: 16),

                  // (Activity #3.7: Dropdown menu for customer type)
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Customer Type',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.group),
                    ),
                    value: _customerType,
                    items: ['Regular', 'One-time']
                        .map((type) =>
                            DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (val) =>
                        setState(() => _customerType = val ?? 'Regular'),
                  ),
                  SizedBox(height: 16),

                  // (Activity #3.5: Terms checkbox)
                  CheckboxListTile(
                    title: Text('Accept Terms and Conditions'),
                    value: _termsAccepted,
                    onChanged: (val) =>
                        setState(() => _termsAccepted = val ?? false),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),

                  // (Activity #3.5: Switch for window cleaning option)
                  SwitchListTile(
                    title: Text('Add Window Cleaning'),
                    value: _includeWindowCleaning,
                    onChanged: (val) =>
                        setState(() => _includeWindowCleaning = val),
                  ),
                  SizedBox(height: 16),

                  // (Activity #3.8: Date picker)
                  Row(
                    children: [
                      Expanded(
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Appointment Date',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            _pickedDate != null
                                ? _pickedDate!
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0]
                                : 'Select a date',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                          onPressed: _pickDate, child: Text('Pick Date')),
                    ],
                  ),
                  SizedBox(height: 16),

                  // (Activity #3.8: Time picker)
                  Row(
                    children: [
                      Expanded(
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Appointment Time',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            _pickedTime != null
                                ? _pickedTime!.format(context)
                                : 'Select a time',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                          onPressed: _pickTime, child: Text('Pick Time')),
                    ],
                  ),
                  SizedBox(height: 16),

                  // (Activity #3.9: Notes textarea with show notes button)
                  TextFormField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      labelText: 'Additional Notes',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.note),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      icon: Icon(Icons.visibility),
                      label: Text('Show Notes'),
                      onPressed: _showNotesDialog,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Payment section (fake)
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Payment Method',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.payment),
                    ),
                    value: _paymentMethod,
                    items: [
                      'Credit Card',
                      'Paypal',
                      'Cash on Arrival',
                      'Bank Transfer',
                    ]
                        .map((method) => DropdownMenuItem(
                            value: method, child: Text(method)))
                        .toList(),
                    onChanged: (val) =>
                        setState(() => _paymentMethod = val ?? 'Credit Card'),
                  ),
                  SizedBox(height: 16),

                  CheckboxListTile(
                    title: Text('I confirm I have made the payment'),
                    value: _paymentConfirmed,
                    onChanged: (val) =>
                        setState(() => _paymentConfirmed = val ?? false),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  // Duplicate terms acknowledgement near the submit button to avoid confusion
                  // (Activity #3.5)
                  CheckboxListTile(
                    title: Text('Accept Terms and Conditions'),
                    value: _termsAccepted,
                    onChanged: (val) =>
                        setState(() => _termsAccepted = val ?? false),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      child: Text('Confirm Booking',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Your Bookings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            _bookings.isEmpty
                ? Text('No bookings yet. Create your first booking above!',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey[600]))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _bookings.length,
                    itemBuilder: (context, index) {
                      final booking = _bookings[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 10),
                        elevation: 3,
                        child: ListTile(
                          leading: Icon(Icons.cleaning_services,
                              color: Colors.blueGrey),
                          title: Text(
                              '${booking['name']} (${booking['customerType']})'),
                          subtitle: Text(
                            'Email: ${booking['email']}\n'
                            'Date: ${booking['date'].toLocal().toString().split(' ')[0]}  Time: ${booking['time'].format(context)}\n'
                            'Window Cleaning: ${booking['includeWindowCleaning'] ? "Yes" : "No"}\n'
                            'Payment Method: ${booking['paymentMethod']}\n'
                            'Notes: ${booking['notes'].isEmpty ? "None" : booking['notes']}',
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
