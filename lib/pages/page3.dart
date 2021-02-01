import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:project2/model/notes.dart';
import 'package:project2/pages/page5.dart';

class NotDetails extends StatelessWidget {
  final Notes notes;
  NotDetails(this.notes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF9B700),
        title: Center(
          child: Text(translator.translate('txtfilddetalladd')),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Get.to(UpdateNots(notes));
              })
        ],
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Center(
                child: Text(
                  notes.titel,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Text(
                notes.detals,
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
