import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:project2/db/dbhelper.dart';
import 'package:project2/model/notes.dart';
import 'package:project2/pages/page2.dart';
import 'package:project2/pages/page4.dart';
import 'package:project2/pages/page3.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DbHelper helper;
  Color color;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF9B700),
        title: Center(
          child: Text(translator.translate('appTitle')),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Get.to(SettingsPage());
              }),
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                setState(() {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(translator.translate("del")),
                          content: Text(translator.translate("notdelall")),
                          actions: [
                            FlatButton(
                              child: Text(translator.translate("yes")),
                              onPressed: () {
                                helper.deleteNotesall();
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                            ),
                            FlatButton(
                              child: Text(translator.translate("no")),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                });
              })
        ],
      ),
      ////list

      body: FutureBuilder(
        future: helper.allNotes(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  Notes notes = Notes.fromMap(snapshot.data[i]);
                  if (notes.import == 1) {
                    color = Colors.green;
                  } else {
                    color = Colors.white;
                  }
                  return Card(
                    color: color,
                    margin: EdgeInsets.all(10),
                    elevation: 10,
                    child: ListTile(
                      title: Text('${notes.titel}'),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(translator.translate("del")),
                                    content:
                                        Text(translator.translate("notdel")),
                                    actions: [
                                      FlatButton(
                                        child:
                                            Text(translator.translate("yes")),
                                        onPressed: () {
                                          helper.deleteNotes(notes.id);
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        },
                                      ),
                                      FlatButton(
                                        child: Text(translator.translate("no")),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          });
                        },
                      ),
                      onTap: () {
                        Get.to(NotDetails(notes));
                      },
                    ),
                  );
                });
          }
        },
      ),
      /*body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(50, (index) {
          return Container(
            child: Card(
              color: Color(0xffFFCCBC), //FF5722//FFCCBC
            ),
          );
        }),
      ),*/
      ///end list
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          Get.to(AddPage());
        }),
        tooltip: translator.translate('pageaddtitl'),
        child: Icon(Icons.add),
        backgroundColor: Color(0xffF9B700),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
