import 'package:flutter/material.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appointment Details')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.cleaning_services, color: Colors.blueGrey),
              title: Text('Deep Cleaning'),
              subtitle: Text('Oct 12, 2:00 PM • 4 hours'),
              trailing: Chip(label: Text('Scheduled')),
            ),
          ),
          SizedBox(height: 12),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Row('Cleaner', 'Assigned Team A'),
                  _Row('Address', 'Unit 3B, Maple Residences, QC'),
                  _Row('Add-ons', 'Windows'),
                  _Row('Payment', 'Credit Card •••• 4242'),
                  _Row('Amount', '₱2,500'),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.event_repeat),
                  title: Text('Reschedule'),
                  subtitle: Text('Change date or time'),
                  onTap: () {},
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.cancel),
                  title: Text('Cancel Appointment'),
                  subtitle: Text('Cancellation policy may apply'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  const _Row(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label + ':', style: TextStyle(fontWeight: FontWeight.w600))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}


