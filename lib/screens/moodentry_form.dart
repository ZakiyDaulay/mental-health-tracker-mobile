import 'package:flutter/material.dart';
import 'package:mental_health_tracker_mobile/widgets/left_drawer.dart'; // Import the drawer

class MoodEntryFormPage extends StatefulWidget {
  const MoodEntryFormPage({super.key});

  @override
  State<MoodEntryFormPage> createState() => _MoodEntryFormPageState();
}

class _MoodEntryFormPageState extends State<MoodEntryFormPage> {
  final _formKey = GlobalKey<FormState>(); // Create the _formKey variable
  String _mood = ""; // Variable to store mood
  String _feelings = ""; // Variable to store feelings
  int _moodIntensity = 0; // Variable to store mood intensity

  // Function to display the dialog
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Mood Entry Saved"),
          content: Text(
            "Mood: $_mood\nFeelings: $_feelings\nMood Intensity: $_moodIntensity",
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _resetForm(); // Reset the form after closing the dialog
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Function to reset the form
  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _mood = "";
      _feelings = "";
      _moodIntensity = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Your Mood Today',
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(), // Add the drawer here
      body: Form(
        key: _formKey, // Assign _formKey to the Form widget
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left)
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Mood",
                    labelText: "Mood",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _mood = value!; // Update _mood when user types
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Mood cannot be empty!"; // Show error if field is empty
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Feelings",
                    labelText: "Feelings",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _feelings = value!; // Update _feelings when user types
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Feelings cannot be empty!"; // Show error if field is empty
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Mood intensity",
                    labelText: "Mood intensity",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _moodIntensity = int.tryParse(value!) ?? 0; // Update mood intensity when user types
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Mood intensity cannot be empty!"; // Show error if field is empty
                    }
                    if (int.tryParse(value) == null) {
                      return "Mood intensity must be a number!"; // Show error if not a number
                    }
                    return null;
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onPressed: () {
                      // Check if the form is valid before showing the dialog
                      if (_formKey.currentState!.validate()) {
                        _showDialog(); // Show the dialog if the form is valid
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
