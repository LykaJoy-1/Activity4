import 'package:flutter/material.dart';

// (Activity #4.8: Demonstrate the difference between push() and pushReplacement().)
// Recontextualized as a service completion flow
class PushReplaceDemoA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Service Complete')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 64, color: Colors.green),
            SizedBox(height: 16),
            Text('Your cleaning service is complete!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Thank you for choosing our cleaning service.', textAlign: TextAlign.center),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PushReplaceDemoB(from: 'push')),
                );
              },
              child: Text('View Details'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => PushReplaceDemoB(from: 'pushReplacement')),
                );
              },
              child: Text('Finish and Return Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class PushReplaceDemoB extends StatelessWidget {
  final String from;
  const PushReplaceDemoB({super.key, required this.from});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Service Summary')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Service Completed Successfully', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Service: Deep Cleaning', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Duration: 4 hours'),
                    Text('Date: Today, 2:00 PM - 6:00 PM'),
                    Text('Payment: ₱2,500 (Credit Card)'),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Back'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                    child: Text('Return to Home'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


