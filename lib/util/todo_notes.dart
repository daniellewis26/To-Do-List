import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoNotes extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

   ToDoNotes({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ],

        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.lightBlue[300],
            borderRadius: BorderRadius.circular(12),
          ),
        
          child: Row(
            children: [
        
              //checkbox
              Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
              ),
        
              // tast name
              Text(
                taskName,
              style: TextStyle(
                  fontSize: 16, // Adjust the font size as desired
                  decoration:taskCompleted
                      ? TextDecoration.lineThrough
                      :TextDecoration.none,
              ),
          ),
        
          ],
          ),
        ),
      ),
    );
  }
}