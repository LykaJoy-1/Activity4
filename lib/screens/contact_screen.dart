import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text('We\'re here to help', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Card(
            child: Column(
              children: const [
                ListTile(leading: Icon(Icons.email_outlined), title: Text('Email'), subtitle: Text('support@cleanhome.app')),
                Divider(height: 1),
                ListTile(leading: Icon(Icons.phone_outlined), title: Text('Phone'), subtitle: Text('+1 555 0100')),
                Divider(height: 1),
                ListTile(leading: Icon(Icons.location_on_outlined), title: Text('Address'), subtitle: Text('22 Pioneer Street, QC')),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text('Business Hours', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Card(
            child: Column(
              children: const [
                ListTile(title: Text('Mon - Fri'), trailing: Text('9:00 AM - 6:00 PM')),
                Divider(height: 1),
                ListTile(title: Text('Saturday'), trailing: Text('10:00 AM - 4:00 PM')),
                Divider(height: 1),
                ListTile(title: Text('Sunday'), trailing: Text('Closed')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


