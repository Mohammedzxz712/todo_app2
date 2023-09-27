import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app3/shared/style/colors.dart';

class TaskTab extends StatelessWidget {
  static const String routeName = 'task';
  const TaskTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 800)),
          lastDate: DateTime.now().add(Duration(days: 800)),
          onDateSelected: (date) => print(date),
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
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => taskItem(),
            itemCount: 10,
          ),
        ),
      ],
    );
  }

  Widget taskItem() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8.0),
        child: Card(
          elevation: 2,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
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
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Task Title'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Task Description'),
                  ],
                ),
                Spacer(),
                Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: primaryColor,
                  ),
                  child: ImageIcon(
                    AssetImage('assets/images/icon_check.png'),
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
