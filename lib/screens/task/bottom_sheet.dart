import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app3/layout/my_provider.dart';
import 'package:todo_app3/models/task_model.dart';

class BottomSheetItem extends StatefulWidget {
  const BottomSheetItem({super.key});

  @override
  State<BottomSheetItem> createState() => _BottomSheetItemState();
}

class _BottomSheetItemState extends State<BottomSheetItem> {
  var taskTitleController = TextEditingController();

  var taskDescriptionController = TextEditingController();

  var selectedData = DateTime.now();

  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Add New Task',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: taskTitleController,
            decoration: const InputDecoration(
              hintText: 'Task Title',
              enabledBorder: UnderlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: taskDescriptionController,
            decoration: InputDecoration(
              hintText: 'Task Description',
              enabledBorder: UnderlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Select Date',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () async {
              showDatePicker(
                context: context,
                initialDate: selectedData,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(
                  Duration(days: 800),
                ),
              ).then((value) {
                if (value != null) {
                  selectedData = value;
                  setState(() {});
                }
              });
            },
            child: Text(
              selectedData.toString().substring(0, 10),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              TaskModel task = TaskModel(
                  userId: FirebaseAuth.instance.currentUser!.uid,
                  title: taskTitleController.text,
                  description: taskDescriptionController.text,
                  date:
                      DateUtils.dateOnly(selectedData).millisecondsSinceEpoch);
              provider.addTask(task);

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Success'),
                    content: Text('Task Added to FireBase'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text('Close!'))
                    ],
                  );
                },
              );
            },
            child: Text('Add Task'),
          )
        ],
      ),
    );
  }
}
