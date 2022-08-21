import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';

class NewThingPage extends StatefulWidget {
  const NewThingPage({Key? key}) : super(key: key);

  @override
  State<NewThingPage> createState() => _NewThingPageState();
}

class _NewThingPageState extends State<NewThingPage> {
  final items = [
    "Kg",
    "Km",
    "Metres",
    "Minutes",
    "Hours",
  ];
  String? selectedItem = 'Kg';

  String thingTitle = "";
  String thingSubtitle = "";
  String thingCount = "";

  final _thingtitleController = TextEditingController();
  final _thingsubtitleController = TextEditingController();
  final _thingcountController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 50,
        width: 300,
        child: FloatingActionButton(
          backgroundColor: Colors.black87,
          child: Text(
            'Create',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          onPressed: () async {
            Navigator.pop(context);
            SubmitForm();
          },
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text("Add new Thing"),
        backgroundColor: Colors.black87,
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: _thingtitleController,
              decoration: const InputDecoration(
                labelText: "Title",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 0, 101, 110)),
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
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 0, 101, 110)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(),
              height: 80,
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
                        controller: _thingcountController,
                        decoration: const InputDecoration(
                          labelText: "Count",
                          border: InputBorder.none,

                          // enabledBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(
                          //     color: Colors.black,
                          //   ),
                          // ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(
                          //     color: Color.fromARGB(255, 0, 101, 110),
                          //   ),
                          // ),
                          // floatingLabelBehavior: FloatingLabelBehavior.never,
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
                    Expanded(
                      child: SizedBox(
                        width: 60,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void SubmitForm() {
    setState(() {
      thingTitle = _thingtitleController.text;
      thingSubtitle = _thingsubtitleController.text;
      thingCount = _thingcountController.text;
    });
    print(thingTitle);
    print(thingSubtitle);
    print(thingCount);
    print(selectedItem);
  }
}
