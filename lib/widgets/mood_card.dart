import 'package:flutter/material.dart';
import 'package:mental_health_tracker_mobile/widgets/left_drawer.dart';
import 'package:mental_health_tracker_mobile/screens/moodentry_form.dart';
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
    return Material(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
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
          }
          // Add any other routes if needed, for example:
          // else if (item.name == "Logout") { ... }
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