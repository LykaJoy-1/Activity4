import 'package:flutter/material.dart';
import 'two_screen_demo.dart';

// (Activity #4.6: Combine Drawer and BottomNavigationBar in the same app.)
// (Activity #4.5: Add icons to each item in a BottomNavigationBar.)
// (Activity #4.3: BottomNavigationBar with three tabs: Home, Profile, Settings.)
// (Activity #4.4: TabBar with TabBarView inside the Settings tab.)
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onBottomTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _HomeTab(),
      _ProfileTab(),
      _SettingsTab(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Home')), // Shown for consistency across tabs
      // (Activity #4.2: Drawer menu that navigates to three different pages.)
      drawer: _AppDrawer(),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          // (Activity #4.2: Drawer to three different pages)
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            onTap: () => Navigator.pushNamed(context, '/about'),
          ),
          ListTile(
            leading: Icon(Icons.contact_mail_outlined),
            title: Text('Contact'),
            onTap: () => Navigator.pushNamed(context, '/contact'),
          ),
          ListTile(
            leading: Icon(Icons.chat_bubble_outline),
            title: Text('Support Center'),
            onTap: () => Navigator.pushNamed(context, '/tabs3'), // (Activity #4.9)
          ),
          ListTile(
            leading: Icon(Icons.rate_review),
            title: Text('Quick Feedback'),
            onTap: () => Navigator.pushNamed(context, '/usernameDemo'), // (Activity #3.1 & #3.9)
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.check_circle),
            title: Text('Service Complete'),
            subtitle: Text('View completed service details'),
            onTap: () => Navigator.pushNamed(context, '/pushDemo'), // (Activity #4.8)
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          // Next appointment summary card (dummy data to make the app feel complete)
          Card(
            child: ListTile(
              leading: Icon(Icons.event_available, color: Colors.blueGrey),
              title: Text('Next Appointment'),
              subtitle: Text('Deep Cleaning • Oct 12, 2:00 PM'),
              trailing: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/appointmentDetails'),
                child: Text('View'),
              ),
            ),
          ),
          SizedBox(height: 16),

          Text('Quick Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: Icon(Icons.flash_on),
                  label: Text('Quick Booking'),
                  onPressed: () => Navigator.pushNamed(context, '/twoScreenDemo'),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  icon: Icon(Icons.cleaning_services),
                  label: Text('Booking Form'),
                  onPressed: () => Navigator.pushNamed(context, '/booking'),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          Text('Recommended Services', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _ServiceChip(label: 'Standard Cleaning', icon: Icons.cleaning_services),
                _ServiceChip(label: 'Deep Cleaning', icon: Icons.sanitizer),
                _ServiceChip(label: 'Move-out Cleaning', icon: Icons.local_laundry_service),
                _ServiceChip(label: 'Windows', icon: Icons.window),
                _ServiceChip(label: 'Carpet', icon: Icons.layers),
              ],
            ),
          ),
          SizedBox(height: 16),

          Text('Recent Activity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Card(
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.done_all, color: Colors.green),
                  title: Text('Deep Cleaning completed'),
                  subtitle: Text('Oct 2 • Rating given: 5 ★'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.schedule, color: Colors.blueGrey),
                  title: Text('Reschedule requested'),
                  subtitle: Text('Sep 28 • Awaiting confirmation'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.payment, color: Colors.indigo),
                  title: Text('Payment received'),
                  subtitle: Text('Sep 25 • Credit Card • ₱2,500'),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ServiceChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _ServiceChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 8),
      child: OutlinedButton(
        onPressed: () {
          // Deep-link to review with the selected service for a distinct UX
          final service = label;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TwoScreenDemoB(selectedService: service),
            ),
          );
        },
        style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blueGrey),
            SizedBox(height: 6),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        ListTile(
          leading: CircleAvatar(child: Icon(Icons.person)),
          title: Text('Lyka Demo'),
          subtitle: Text('lyka@demo.com'),
          trailing: Chip(label: Text('Regular')),
        ),
        SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Default Address'),
            subtitle: Text('Unit 3B, Maple Residences, QC'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Preferred Payment'),
            subtitle: Text('Credit Card •••• 4242'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.star_rate),
            title: Text('Recent Rating'),
            subtitle: Text('Deep Cleaning • 5.0 ★'),
          ),
        ),
      ],
    );
  }
}

class _SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // (Activity #4.4: TabBar with TabBarView that switches between two screens inside a Scaffold)
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: Theme.of(context).colorScheme.primary,
            tabs: const [
              Tab(icon: Icon(Icons.tune), text: 'Preferences'),
              Tab(icon: Icon(Icons.security), text: 'Privacy'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _PreferencesTab(),
                _PrivacyTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PreferencesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text('Notification Preferences', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        SwitchListTile(
          title: Text('Booking Reminders'),
          subtitle: Text('Get notified 24 hours before your appointment'),
          value: true,
          onChanged: (value) {},
        ),
        SwitchListTile(
          title: Text('Service Updates'),
          subtitle: Text('Receive updates about your cleaning service'),
          value: true,
          onChanged: (value) {},
        ),
        SwitchListTile(
          title: Text('Promotional Offers'),
          subtitle: Text('Get notified about special deals and discounts'),
          value: false,
          onChanged: (value) {},
        ),
        Divider(),
        Text('Service Preferences', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        ListTile(
          leading: Icon(Icons.cleaning_services),
          title: Text('Preferred Service Type'),
          subtitle: Text('Deep Cleaning'),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: Icon(Icons.access_time),
          title: Text('Preferred Time Slot'),
          subtitle: Text('Afternoon (2:00 PM - 6:00 PM)'),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('Default Payment Method'),
          subtitle: Text('Credit Card •••• 4242'),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ],
    );
  }
}

class _PrivacyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text('Data & Privacy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('Personal Information'),
            subtitle: Text('Manage your personal data and contact information'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.history),
            title: Text('Service History'),
            subtitle: Text('View and manage your cleaning service history'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.security),
            title: Text('Account Security'),
            subtitle: Text('Password, two-factor authentication, and login settings'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
        SizedBox(height: 16),
        Text('Privacy Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        SwitchListTile(
          title: Text('Data Analytics'),
          subtitle: Text('Help improve our service by sharing anonymous usage data'),
          value: true,
          onChanged: (value) {},
        ),
        SwitchListTile(
          title: Text('Location Services'),
          subtitle: Text('Allow location access for accurate service delivery'),
          value: true,
          onChanged: (value) {},
        ),
        SwitchListTile(
          title: Text('Marketing Communications'),
          subtitle: Text('Receive marketing emails and promotional content'),
          value: false,
          onChanged: (value) {},
        ),
      ],
    );
  }
}


