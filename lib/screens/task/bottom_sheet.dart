import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add New Task',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: taskTitleController,
            decoration: InputDecoration(
              hintText: 'Task Title',
              enabledBorder: UnderlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: taskDescriptionController,
            decoration: InputDecoration(
              hintText: 'Task Description',
              enabledBorder: UnderlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Select Date',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          SizedBox(
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
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Add Task'),
          )
        ],
      ),
    );
  }
}
