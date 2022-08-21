// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../common/ThingCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final isDealOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        if (isDealOpen.value) {
          isDealOpen.value = false;
          return false;
        } else {
          return true;
        }
      }),
      child: Scaffold(
        floatingActionButton: SpeedDial(
          backgroundColor: Colors.black87,
          openCloseDial: isDealOpen,
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            // Всплывающая кнопка
            SpeedDialChild(
              label: "Filter and sorting",
              child: Icon(
                Icons.filter_alt,
              ),
            ),
            SpeedDialChild(
              label: "Create new Thing",
              child: InkWell(
                onTap: () async {
                  Navigator.pushNamed(context, '/new-thing');
                  isDealOpen.value = false;
                  setState(() {});
                },
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          minimum: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // Card widget
              NewThingWidget(
                icon: Icons.keyboard_alt_outlined,
                title: "Code",
                subtitle: "120 minutes",
                date: "9:40",
              ),

              NewThingWidget(
                icon: Icons.sports_football,
                title: "Sport",
                subtitle: "60 minutes",
                date: "10:48",
              ),

              NewThingWidget(
                icon: Icons.school_outlined,
                title: "Studing",
                subtitle: "60 minutes",
                date: "11:42",
              ),

              buildNewThing()
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildNewThing() {
  int index = 3;
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: index,
    primary: false,
    itemBuilder: (context, index) {
      return InkWell(
          onLongPress: () async {
            // print(notes[index].id);
          },
          child: NewThingWidget(
            icon: Icons.school_outlined,
            title: "Studing",
            subtitle: "60 minutes",
            date: "11:42",
          ));
    },
  );
}
