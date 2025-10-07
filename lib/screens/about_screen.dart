import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.cleaning_services, color: Colors.blueGrey),
            title: Text('CleanHome'),
            subtitle: Text('Professional Home Cleaning Services'),
          ),
          SizedBox(height: 8),
          Text(
            'We connect busy households with vetted cleaning professionals. '
            'Book in minutes, manage appointments, and pay securely.',
          ),
          SizedBox(height: 16),
          Text('Our Services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Card(
            child: Column(
              children: const [
                ListTile(leading: Icon(Icons.home_outlined), title: Text('Standard Cleaning'), subtitle: Text('General home upkeep')),
                Divider(height: 1),
                ListTile(leading: Icon(Icons.sanitizer), title: Text('Deep Cleaning'), subtitle: Text('Thorough, detailed clean')),
                Divider(height: 1),
                ListTile(leading: Icon(Icons.local_laundry_service), title: Text('Move-out Cleaning'), subtitle: Text('End-of-lease ready')),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text('Why Choose Us', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _Bullet(text: 'Trusted, background-checked professionals'),
                  _Bullet(text: 'Flexible scheduling and easy rescheduling'),
                  _Bullet(text: 'Transparent, upfront pricing'),
                  _Bullet(text: 'Responsive support'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• '),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}


