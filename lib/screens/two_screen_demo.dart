import 'package:flutter/material.dart';

// (Activity #4.1: Two screens and navigate between them using Navigator.push() and Navigator.pop().)
// Recontextualized as a quick booking flow: Service Selection -> Review Selection.
class TwoScreenDemoA extends StatefulWidget {
  @override
  State<TwoScreenDemoA> createState() => _TwoScreenDemoAState();
}

class _TwoScreenDemoAState extends State<TwoScreenDemoA> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Service')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose a service package:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            RadioListTile<String>(
              value: 'Standard Cleaning',
              groupValue: _selected,
              onChanged: (v) => setState(() => _selected = v),
              secondary: Icon(Icons.cleaning_services),
              title: Text('Standard Cleaning'),
              subtitle: Text('2 hrs • ₱1,200'),
            ),
            RadioListTile<String>(
              value: 'Deep Cleaning',
              groupValue: _selected,
              onChanged: (v) => setState(() => _selected = v),
              secondary: Icon(Icons.sanitizer),
              title: Text('Deep Cleaning'),
              subtitle: Text('4 hrs • ₱2,500'),
            ),
            RadioListTile<String>(
              value: 'Move-out Cleaning',
              groupValue: _selected,
              onChanged: (v) => setState(() => _selected = v),
              secondary: Icon(Icons.local_laundry_service),
              title: Text('Move-out Cleaning'),
              subtitle: Text('6 hrs • ₱4,000'),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _selected == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => TwoScreenDemoB(selectedService: _selected!)),
                        );
                      },
                child: Text('Review Selection'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TwoScreenDemoB extends StatelessWidget {
  final String selectedService;
  TwoScreenDemoB({required this.selectedService});

  Map<String, Map<String, String>> get _details => {
        'Standard Cleaning': {'duration': '2 hours', 'cost': '₱1,200'},
        'Deep Cleaning': {'duration': '4 hours', 'cost': '₱2,500'},
        'Move-out Cleaning': {'duration': '6 hours', 'cost': '₱4,000'},
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review Selection')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selected: ' + selectedService, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Estimated Duration: ' + (_details[selectedService]!['duration']!)),
            Text('Estimated Cost: ' + (_details[selectedService]!['cost']!)),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Modify'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/booking'),
                  child: Text('Continue to Booking'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Convenience: open review directly with a preselected service (used by Recommended Services)
void openReviewWithService(BuildContext context, String service) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => TwoScreenDemoB(selectedService: service)),
  );
}


