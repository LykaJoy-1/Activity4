import 'package:flutter/material.dart';

// Order Summary screen that closes the booking loop and demonstrates pushReplacement flow
class OrderSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  const OrderSummaryScreen({Key? key, required this.bookingData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
        automaticallyImplyLeading: false, // Prevent back button
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
            // Success header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Booking Confirmed!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green.shade800)),
                        Text('Your cleaning service has been scheduled successfully', style: TextStyle(color: Colors.green.shade700)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Booking details
            Text('Booking Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DetailRow('Customer', bookingData['name']),
                    _DetailRow('Email', bookingData['email']),
                    _DetailRow('Service Type', bookingData['customerType'] + (bookingData['includeWindowCleaning'] ? ' + Windows' : '')),
                    _DetailRow('Date', bookingData['date'].toLocal().toString().split(' ')[0]),
                    _DetailRow('Time', bookingData['time'].format(context)),
                    _DetailRow('Payment Method', bookingData['paymentMethod']),
                    if (bookingData['notes'].isNotEmpty) _DetailRow('Notes', bookingData['notes']),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Next steps
            Text('What\'s Next?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.email, color: Colors.blue),
                      title: Text('Confirmation Email'),
                      subtitle: Text('Check your inbox for booking details'),
                    ),
                    ListTile(
                      leading: Icon(Icons.notifications, color: Colors.orange),
                      title: Text('Reminder Notifications'),
                      subtitle: Text('We\'ll send reminders before your appointment'),
                    ),
                    ListTile(
                      leading: Icon(Icons.support_agent, color: Colors.green),
                      title: Text('Customer Support'),
                      subtitle: Text('Contact us if you need to make changes'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pushNamed(context, '/home'),
                    child: Text('View Dashboard'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    // (Activity #4.8: Demonstrate pushReplacement to close the booking flow)
                    onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                    child: Text('Finish and Return Home'),
                  ),
                ),
              ],
            ),
          ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label + ':', style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.grey.shade700)),
          ),
        ],
      ),
    );
  }
}
