import 'package:flutter/material.dart';
import 'package:habit_tracker_with_hive/components/my_floatingactionbutton.dart';

import '../components/my_alert_box.dart';
import '../components/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //data structure for todays list

  List todayHabitList = [
    ['Morning Run', false],
    ['Read Book', false],
    ['Code App', false],
  ];

  //bool to control habit completed

  bool habitCompleted = false;

  //checkbox tapped

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todayHabitList[index][1] = value;
    });
  }

  //Create new habit
  final _newHabitNameController = TextEditingController();

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  void saveNewHabit() {
// add a new habit todays habit list

    setState(() {
      todayHabitList.add([_newHabitNameController.text, false]);
    });

    Navigator.of(context).pop();

    //Clear the textfield
    _newHabitNameController.clear();
  }

  void cancelDialogBox() {
    Navigator.of(context).pop();

    //Clear the textfield
    _newHabitNameController.clear();
  }

  // open the habit settings to edit

  void openHabitSettings(index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
            controller: _newHabitNameController,
            onSave: () => saveExistingHabit(index),
            onCancel: cancelDialogBox);
      },
    );
  }

  // Save Existing Habit

  void saveExistingHabit(int index) {
    setState(() {
      todayHabitList[index][0] = _newHabitNameController.text;
    });
  }

  void deleteHabit(int index) {
    setState(() {
      todayHabitList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: MyFloatingActionButton(
          onPressed: () => createNewHabit(),
        ),
        body: ListView.builder(
            itemCount: todayHabitList.length,
            itemBuilder: ((context, index) {
              return HabitTile(
                habitName: todayHabitList[index][0],
                habitCompleted: todayHabitList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                settingsTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            })));
  }
}
