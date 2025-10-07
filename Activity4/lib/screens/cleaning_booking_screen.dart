import 'package:flutter/material.dart';

class CleaningBookingScreen extends StatefulWidget {
  @override
  _CleaningBookingScreenState createState() => _CleaningBookingScreenState();
}

class _CleaningBookingScreenState extends State<CleaningBookingScreen> {
  final _formKey = GlobalKey<
      FormState>(); // Activity #4: Use of GlobalKey<FormState> to manage validation and submission.

  final _nameController =
      TextEditingController(); // Activity #6: Registration form with name field.
  final _emailController =
      TextEditingController(); // Activity #6 + #3: Email field with validation for “@”.
  final _notesController =
      TextEditingController(); // Activity #9: Use of controller to capture and display text.

  bool _termsAccepted =
      false; // Activity #5: Checkbox input for terms acceptance.
  bool _includeWindowCleaning =
      false; // Activity #5: Switch input for optional window cleaning.
  bool _paymentConfirmed = false; // Fake payment confirmation checkbox.

  String _customerType =
      'Regular'; // Activity #7: Dropdown menu inside form for user’s role (Regular, One-time).
  String _paymentMethod = 'Credit Card'; // Payment method dropdown.

  DateTime? _pickedDate; // Activity #8: Date picker input.
  TimeOfDay? _pickedTime; // Activity #8: Time picker input.

  final List<Map<String, dynamic>> _bookings =
      []; // Activity #10: Form saves data into local list and displays submitted inputs below form.

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
    // Activity #9: Use controller to show notes content in a dialog.
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
        SnackBar(content: Text('You must accept the terms and conditions')),
      );
      return;
    }

    if (!_paymentConfirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please confirm payment to continue')),
      );
      return;
    }

    if (_pickedDate == null || _pickedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select appointment date and time')),
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking and payment submitted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Cleaning Service Booking')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Form(
              key:
                  _formKey, // Activity #4: Use GlobalKey<FormState> to manage form validation and submission.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Activity #6: Name input with TextFormField.
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

                  // Activity #6 + #3: Email input with validation for “@”.
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

                  // Activity #7: Dropdown menu for selecting customer type.
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

                  // Activity #5: Checkbox for terms and conditions acceptance.
                  CheckboxListTile(
                    title: Text('Accept Terms and Conditions'),
                    value: _termsAccepted,
                    onChanged: (val) =>
                        setState(() => _termsAccepted = val ?? false),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),

                  // Activity #5: Switch for adding window cleaning service.
                  SwitchListTile(
                    title: Text('Add Window Cleaning'),
                    value: _includeWindowCleaning,
                    onChanged: (val) =>
                        setState(() => _includeWindowCleaning = val),
                  ),
                  SizedBox(height: 16),

                  // Activity #8: Date picker for appointment date.
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
                        onPressed: _pickDate,
                        child: Text('Pick Date'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Activity #8: Time picker for appointment time.
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
                        onPressed: _pickTime,
                        child: Text('Pick Time'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Activity #9: TextFormField with controller for additional notes.
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

                  // Activity #9: Button to display notes text.
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      icon: Icon(Icons.visibility),
                      label: Text('Show Notes'),
                      onPressed: _showNotesDialog,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Payment section: dropdown and confirmation checkbox.
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
                  SizedBox(height: 20),

                  // Activity #10: Submit button to save and display data.
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        child: Text(
                          'Confirm Booking',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            // Activity #10: Display saved bookings below the form.
            Text(
              'Submitted Cleaning Service Bookings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            _bookings.isEmpty
                ? Text(
                    'No bookings submitted yet.',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  )
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
