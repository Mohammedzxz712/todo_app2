import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app3/models/edit_model.dart';

import '../../layout/my_provider.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = 'edit';

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var taskTitleController = TextEditingController();

  var taskDescriptionController = TextEditingController();

  var selectedData = DateTime.now();

  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var args = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as EditModel;

    taskTitleController.text = args.title;
    taskDescriptionController.text = args.description;

    int ts = int.parse(args.date);
    // var dt = DateTime.fromMillisecondsSinceEpoch(ts);
    //var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    // print(dt);
    return Consumer(
      builder: (context, value, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('To Do App'),
            elevation: 0,
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.blue,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  height: 400,
                  width: 300,
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Edit Task',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                            decoration: const InputDecoration(
                              hintText: 'Task Description',
                              enabledBorder: UnderlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Select Date',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
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
                                  const Duration(days: 800),
                                ),
                              ).then((value) {
                                if (value != null) {
                                  selectedData = value;
                                  setState(() {});
                                }
                              });
                            },
                            child: Text(
                              selectedData == DateTime.now()
                                  ? DateTime.fromMillisecondsSinceEpoch(ts)
                                      .toString()
                                  : selectedData.toString().substring(0, 10),
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
                              provider.updateUser(
                                description: taskDescriptionController.text,
                                title: taskTitleController.text,
                                isDone: args.isDone,
                                id: args.id,
                                date: DateUtils.dateOnly(selectedData)
                                    .millisecondsSinceEpoch,
                              );
                              Navigator.pop(context);
                            },
                            child: Text('Edit Task'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
