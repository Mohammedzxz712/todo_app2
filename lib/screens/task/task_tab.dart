import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app3/models/edit_model.dart';
import 'package:todo_app3/shared/style/colors.dart';

import '../../layout/my_provider.dart';
import '../../models/task_model.dart';
import '../ediet/ediet_screen.dart';

class TaskTab extends StatefulWidget {
  static const String routeName = 'task';

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  DateTime selectedData = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, value, _) {
        var provider = Provider.of<MyProvider>(context);
        return Column(
          children: [
            CalendarTimeline(
              initialDate: selectedData,
              firstDate: DateTime.now().subtract(Duration(days: 800)),
              lastDate: DateTime.now().add(Duration(days: 800)),
              onDateSelected: (date) {
                selectedData = date;
                setState(() {});
              },
              leftMargin: 20,
              monthColor: Colors.blue[300],
              dayColor: Colors.blueGrey[400],
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.blue,
              dotsColor: Colors.white,
              selectableDayPredicate: (date) => true,
              locale: 'en_ISO',
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot<TaskModel>>(
              stream: provider.getTask(selectedData),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Text('SomeThing is wrong');
                }

                List<TaskModel> tasks =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      taskItem(tasks[index], context),
                  itemCount: tasks.length,
                );
              },
            )),
          ],
        );
      },
    );
  }

  Widget taskItem(TaskModel model, context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 8.0),
        child: Card(
          elevation: 2,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Slidable(
            startActionPane: ActionPane(
              motion: DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    Provider.of<MyProvider>(context, listen: false)
                        .deleteTask(model.id);
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                    Navigator.pushNamed(context, EditScreen.routeName,
                        arguments: EditModel(
                            isDone: model.isDone,
                            title: model.title,
                            description: model.description,
                            id: model.id,
                            date: (model.date).toString()));
                  },
                  backgroundColor: Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 3,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: model.isDone ? Colors.green : primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('${model.description}'),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Provider.of<MyProvider>(context, listen: false).updateUser(
                      description: model.description,
                      title: model.title,
                      isDone: true,
                      id: model.id,
                      date: model.date,
                    );
                  },
                  child: model.isDone
                      ? Container(
                          width: 60,
                          height: 30,
                          child: const Text(
                            'Done!',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        )
                      : Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: primaryColor,
                          ),
                          child: const ImageIcon(
                            AssetImage('assets/images/icon_check.png'),
                            color: Colors.white,
                          ),
                        ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ),
      );
}
