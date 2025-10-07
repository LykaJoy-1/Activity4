import 'package:flutter/material.dart';

// (Activity #3.1: Simple form with a TextFormField for entering a username.)
// (Activity #3.9: Use a controller to capture and display text after pressing a button.)
// Recontextualized as a cleaning feedback form
class UsernameDemoScreen extends StatefulWidget {
  @override
  State<UsernameDemoScreen> createState() => _UsernameDemoScreenState();
}

class _UsernameDemoScreenState extends State<UsernameDemoScreen> {
  final _controller = TextEditingController();
  String _displayed = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quick Feedback')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How was your cleaning service?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter your feedback',
                hintText: 'e.g., "Excellent service, very thorough!"',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => setState(() => _displayed = _controller.text.trim()),
              child: Text('Preview Feedback'),
            ),
            SizedBox(height: 12),
            if (_displayed.isNotEmpty) ...[
              Text('Your feedback:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(_displayed, style: TextStyle(fontStyle: FontStyle.italic)),
              ),
              SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Thank you for your feedback! We appreciate your input.'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  Navigator.pop(context);
                },
                icon: Icon(Icons.send),
                label: Text('Submit Feedback'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


