import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:mental_health_tracker_mobile/screens/list_moodentry.dart';
import 'package:mental_health_tracker_mobile/screens/moodentry_form.dart';
import 'package:mental_health_tracker_mobile/screens/login.dart'; // Add this line if LoginPage is in a separate file

class ItemHomepage {
  final String name;
  final IconData icon;

  ItemHomepage(this.name, this.icon);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Material(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () async {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("You have pressed the ${item.name} button!"))
            );

          // Navigate to the appropriate page based on the button name
          if (item.name == "Add Mood") {
            // Navigate to MoodEntryFormPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MoodEntryFormPage()),
            );
          } else if (item.name == "View Mood") {
            // Navigate to MoodEntryPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MoodEntryPage()),
            );
          } else if (item.name == "Logout") {
            // Perform logout process asynchronously
            final response = await request.logout(
              "http://localhost:8000/auth/logout/" // Replace with your actual URL
            );
            String message = response["message"];
            if (context.mounted) {
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("$message Goodbye, $uname."))
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message))
                );
              }
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
