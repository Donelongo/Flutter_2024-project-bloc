import 'package:flutter/material.dart';

class AddActivityDialog extends StatelessWidget {
  const AddActivityDialog(
      {super.key,
      required this.userController,
      required this.activityController,
      required this.selectedDateTime,
      required this.selectedDateTimeNotifier});
  final TextEditingController userController;
  final TextEditingController activityController;
  final DateTime selectedDateTime;
  final ValueNotifier<DateTime?> selectedDateTimeNotifier;

// ValueNotifier<DateTime?>(DateTime.now())

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now(),
    );
    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        selectedDateTimeNotifier.value = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
  }

  bool _validateInputs() {
    return userController.text.isNotEmpty &&
        activityController.text.isNotEmpty &&
        selectedDateTimeNotifier.value != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userController,
              decoration: const InputDecoration(
                labelText: 'User',
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            TextField(
              controller: activityController,
              decoration: const InputDecoration(labelText: 'Activity'),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            ValueListenableBuilder<DateTime?>(
              valueListenable: selectedDateTimeNotifier,
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: () => _selectDateTime(context),
                  child: Text(
                      value == null
                          ? 'Select Date and Time'
                          : 'Date and Time: ${value.toString().substring(0, 16)}',
                      style: const TextStyle(color: Colors.blueGrey)),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_validateInputs()) {
                      Navigator.pop(context, {
                        'user': userController.text,
                        'activity': activityController.text,
                        'dateTime': selectedDateTimeNotifier.value,
                      } as Map<String, dynamic>);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all fields.'),
                        ),
                      );
                    }
                  },
                  child: const Text('Add',
                      style: TextStyle(color: Colors.blueGrey)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.blueGrey)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
