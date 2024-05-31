import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_notebook/bloc/activity_log_bloc.dart';
import 'package:digital_notebook/bloc/activity_log_event.dart';

class AddActivityDialog extends StatelessWidget {
  final TextEditingController userController;
  final TextEditingController activityController;
  final DateTime? selectedDateTime;
  final Function(String, String, DateTime) onAddActivity;
  final VoidCallback onCloseDialog;
  final ValueNotifier<DateTime?> selectedDateTimeNotifier;

  AddActivityDialog({
    super.key,
    required this.userController,
    required this.activityController,
    required this.selectedDateTime,
    required this.onAddActivity,
    required this.onCloseDialog,
  }) : selectedDateTimeNotifier = ValueNotifier<DateTime?>(selectedDateTime);

  static Widget create(BuildContext context) {
    return AddActivityDialog(
      userController: TextEditingController(),
      activityController: TextEditingController(),
      selectedDateTime: DateTime.now(),
      onAddActivity: (user, activity, dateTime) {
        context.read<ActivityLogBloc>().add(AddActivityEvent(
          user: user,
          activity: activity,
          dateTime: dateTime,
        ));
      },
      onCloseDialog: () {
        Navigator.of(context).pop();
      },
    );
  }

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
                  child: Text(value == null
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
                      onAddActivity(
                        userController.text,
                        activityController.text,
                        selectedDateTimeNotifier.value ?? DateTime.now(),
                      );
                      onCloseDialog();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all fields.'),
                        ),
                      );
                    }
                  },
                  child: const Text('Add', style: TextStyle(color: Colors.blueGrey)),
                ),
                ElevatedButton(
                  onPressed: onCloseDialog,
                  child: const Text('Cancel', style: TextStyle(color: Colors.blueGrey)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
