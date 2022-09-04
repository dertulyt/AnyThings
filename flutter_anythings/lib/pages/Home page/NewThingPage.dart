import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_anythings/main.dart';
import 'package:flutter_anythings/pages/db/AllThingsDatabase.dart';
import 'package:flutter_anythings/pages/model/thing.dart';
import '../model/thing.dart';

class NewThingPage extends StatefulWidget {
  final Thing? thing;
  const NewThingPage({Key? key, this.thing}) : super(key: key);

  @override
  State<NewThingPage> createState() => _NewThingPageState();
}

class _NewThingPageState extends State<NewThingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final items = [
    "Minutes",
    "Metres",
    "Hours",
    "Kg",
    "Km",
  ];

  List<Map> myCategories = [
    {"name": "Study", "Icon": Icons.school},
    {"name": "Sport", "Icon": Icons.directions_run},
    {"name": "Work", "Icon": Icons.work},
    {"name": "Kitchen", "Icon": Icons.kitchen},
    {"name": "Hobbies", "Icon": Icons.emoji_emotions},
    {"name": "Reading", "Icon": Icons.book},
    {"name": "Relax", "Icon": Icons.weekend},
    {"name": "Meditation", "Icon": Icons.self_improvement},
    {"name": "Own", "Icon": Icons.favorite},
  ];

  String? selectedItem = 'Minutes';
  DateTime date = DateTime.now();
  late String newThingTitle;
  late String newThingSubtitle;
  late int newThingCount;
  TimeOfDay? selectedTime = TimeOfDay.now();

  final _thingtitleController = TextEditingController();
  final _thingsubtitleController = TextEditingController();
  final _thingcountController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    newThingTitle = widget.thing?.title ?? '';
    newThingSubtitle = widget.thing?.subtitle ?? '';
    newThingCount = widget.thing?.count ?? 0;
    selectedItem = widget.thing?.category ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: SizedBox(
          height: 50,
          width: 300,
          child: FloatingActionButton(
            backgroundColor: Colors.black87,
            child: Text(
              'Create',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                SubmitForm();
                final thing = Thing(
                    title: newThingTitle,
                    createdTime: date,
                    subtitle: newThingSubtitle,
                    count: newThingCount,
                    category: selectedItem);
                await AllMyThings.instance.create(thing);
                Navigator.pop(context);
              }
            },
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: Text("Add new Thing"),
          backgroundColor: Colors.black87,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: SafeArea(
                minimum: EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please write some title...';
                        }
                        return null;
                      },
                      controller: _thingtitleController,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 101, 110)),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _thingsubtitleController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: "Subtitle",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 101, 110)),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      // decoration: BoxDecoration(),
                      height: 60,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 200,
                              // decoration: BoxDecoration(color: Colors.blueGrey),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Write please some count...';
                                  }
                                  return null;
                                },
                                controller: _thingcountController,
                                decoration: const InputDecoration(
                                  labelText: "Count",
                                  border: InputBorder.none,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              // decoration: BoxDecoration(color: Colors.blueGrey),
                              child: DropdownButton<String>(
                                value: selectedItem,
                                items: items
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        child: Text(item),
                                        value: item,
                                      ),
                                    )
                                    .toList(),
                                onChanged: (item) => {
                                  setState(
                                    () => selectedItem = item,
                                  )
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            // height: 100,
                            child: choosingCategoryWidget(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                            ),
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );
                              if (newDate == null) return;
                              setState(
                                () {
                                  date = newDate;
                                },
                              );
                            },
                            child: Container(
                              child: Text("Tap to change date"),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 20,
                        // ),
                        // Expanded(
                        //   child: ElevatedButton(
                        //     style: ButtonStyle(
                        //       backgroundColor:
                        //           MaterialStateProperty.all(Colors.black),
                        //     ),
                        //     onPressed: () async {
                        //       // print(myCategories[2]['Icon']);
                        //       setState(
                        //         () {
                        //           date = DateTime(
                        //             date.year,
                        //             date.month,
                        //             date.day,
                        //           );
                        //         },
                        //       );
                        //     },
                        //     child: Container(
                        //       child: Text("Tap to change time"),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  void SubmitForm() {
    setState(() {
      newThingTitle = _thingtitleController.text;
      newThingSubtitle = _thingsubtitleController.text;
      newThingCount = int.parse(_thingcountController.text);
    });
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.thing != null;

      if (isUpdating) {
        // await updateNote();
      } else {
        await addNote();
      }

      Navigator.pop(context);
    }
  }

  // Future updateNote() async {
  //   final note = widget.thing!.copy(
  //     title: newThingTitle,
  //     subtitle: newThingSubtitle,
  //     count: newThingCount,
  //     category: selectedItem,
  //     createdTime: DateTime.now(),
  //   );

  //   await AllMyThings.instance.update(note);
  // }

  Future addNote() async {
    final note = Thing(
      title: newThingTitle,
      subtitle: newThingSubtitle,
      count: newThingCount,
      category: selectedItem,
      createdTime: DateTime.now(),
    );

    await AllMyThings.instance.create(note);
  }

  choosingCategoryWidget() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: myCategories.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (() {}),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(
                          5.0) //                 <--- border radius here
                      ),
                ),
                width: 100,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        myCategories[index]['Icon'],
                        size: 30,
                        // Icons.book,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      myCategories[index]['name'],
                      // 'Hello',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
        );
      },
    );
  }
}
