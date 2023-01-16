import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  const HabitTile(
      {super.key,
      required this.habitName,
      required this.habitCompleted,
      required this.onChanged,
      this.settingsTapped,
      this.deleteTapped});

  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          //Setttings Option
          SlidableAction(
            onPressed: settingsTapped,
            backgroundColor: Colors.grey.shade800,
            icon: Icons.settings,
            borderRadius: BorderRadius.circular(12),
          ),

          //Delete Option
          SlidableAction(
            onPressed: deleteTapped,
            backgroundColor: Colors.red.shade400,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                //checkbox

                Checkbox(value: habitCompleted, onChanged: onChanged),

                //Habit name
                Text(habitName),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
