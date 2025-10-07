import 'package:flutter/material.dart';

// (Activity #4.9: Create a TabBar inside an AppBar with three tabs: Chats, Status, Calls.)
class AppBarTabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Support Center'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Chats', icon: Icon(Icons.chat_bubble_outline)),
              Tab(text: 'Tickets', icon: Icon(Icons.confirmation_number_outlined)),
              Tab(text: 'Calls', icon: Icon(Icons.call_outlined)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Dummy chat list
            ListView(
              children: const [
                ListTile(leading: CircleAvatar(child: Icon(Icons.support_agent)), title: Text('Agent Mia'), subtitle: Text('Hello! How can I assist you today?')),
                ListTile(leading: CircleAvatar(child: Icon(Icons.support_agent)), title: Text('Agent Carlo'), subtitle: Text('Your cleaner is on the way.')),
                ListTile(leading: CircleAvatar(child: Icon(Icons.support_agent)), title: Text('Agent Ava'), subtitle: Text('We have applied a 10% discount.')),
              ],
            ),
            // Dummy tickets list
            ListView(
              children: const [
                ListTile(leading: Icon(Icons.confirmation_number_outlined), title: Text('TCK-10231'), subtitle: Text('Reschedule request - Pending')),
                ListTile(leading: Icon(Icons.confirmation_number_outlined), title: Text('TCK-10204'), subtitle: Text('Refund inquiry - Resolved')),
                ListTile(leading: Icon(Icons.confirmation_number_outlined), title: Text('TCK-10177'), subtitle: Text('Add window cleaning - Open')),
              ],
            ),
            // Dummy call logs
            ListView(
              children: const [
                ListTile(leading: Icon(Icons.call_received, color: Colors.green), title: Text('Support Call'), subtitle: Text('Today, 2:15 PM')),
                ListTile(leading: Icon(Icons.call_missed_outgoing, color: Colors.redAccent), title: Text('Missed Call'), subtitle: Text('Yesterday, 9:41 AM')),
                ListTile(leading: Icon(Icons.call_made, color: Colors.blueGrey), title: Text('Outgoing Call'), subtitle: Text('Mon, 5:23 PM')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


