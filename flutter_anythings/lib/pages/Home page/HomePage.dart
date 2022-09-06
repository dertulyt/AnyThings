import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_anythings/pages/model/thing.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';

import '../common/ThingCard.dart';
import '../db/AllThingsDatabase.dart';
import 'NoteDetailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final isDealOpen = ValueNotifier(false);
  // late List<Thing> Mythings;
  List<Thing> things = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    this.things = await AllMyThings.instance.readAllNotes();
    setState(() => isLoading = false);
    setState(() {});
  }

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
            // SpeedDialChild(
            //   label: "Filter and sorting (doesn't work)",
            //   child: Icon(
            //     Icons.filter_alt,
            //   ),
            // ),
            SpeedDialChild(
              label: "Create new Thing",
              child: InkWell(
                onTap: () async {
                  Navigator.pushNamed(context, '/new-thing').then((_) => {
                        refreshNotes(),
                      });
                  isDealOpen.value = false;
                  refreshNotes();
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
          child: SingleChildScrollView(
            child: isLoading
                ? CircularProgressIndicator()
                : things.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              'Tap + to add new Thing',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          // Title
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Today',
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          buildNewThing(refreshNotes, things),
                        ],
                      ),
          ),
        ),
      ),
    );
  }

  Widget buildNewThing(val, things) {
    // refreshNotes();
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: things.length,
      primary: false,
      itemBuilder: (context, index) {
        String hourDate =
            '${things[index].createdTime.hour.toString()}:${things[index].createdTime.minute.toString()}';
        return InkWell(
            onLongPress: () async {
              AllMyThings.instance.delete(things[index].id);
              refreshNotes();
            },
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: things[index]!),
              ));

              refreshNotes();
            },
            child: NewThingWidget(
              icon: myGetIcon(things[index].choose),
              title: things[index].title,
              subtitle: "${things[index].count} ${things[index].category}",
              // date: hourDate,
              date: checkDate(things[index]),
              // date: things[index].createdTime,
            ));
      },
    );
  }

  myGetIcon(val) {
    List<Map> myCategories = [
      {"name": "Study", "icon": Icons.school},
      {"name": "Sport", "icon": Icons.directions_run},
      {"name": "Work", "icon": Icons.work},
      {"name": "Kitchen", "icon": Icons.kitchen},
      {"name": "Hobbies", "icon": Icons.emoji_emotions},
      {"name": "Reading", "icon": Icons.book},
      {"name": "Relax", "icon": Icons.weekend},
      {"name": "Meditation", "icon": Icons.self_improvement},
      {"name": "Own", "icon": Icons.favorite},
    ];
    IconData myIcon = Icons.school_outlined;

    myCategories.forEach((element) {
      if (element["name"] == val) {
        myIcon = element["icon"];
      }
    });

    return myIcon;
  }

  checkDate(vale) {
    String newCheckDate = "";
    if (DateFormat.yMMMd().format(vale.createdTime) ==
        DateFormat.yMMMd().format(DateTime.now())) {
      newCheckDate =
          '${vale.createdTime.hour.toString()}:${vale.createdTime.minute.toString()}';
    } else {
      newCheckDate = DateFormat.yMMMd().format(vale.createdTime);
    }

    return newCheckDate;
  }
}
