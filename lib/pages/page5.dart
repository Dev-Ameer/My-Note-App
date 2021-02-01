import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:project2/db/dbhelper.dart';
import 'package:project2/model/notes.dart';
import 'package:project2/pages/page1.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UpdateNots extends StatefulWidget {
  final Notes notes;
  UpdateNots(this.notes);

  @override
  _UpdateNotsState createState() => _UpdateNotsState();
}

class _UpdateNotsState extends State<UpdateNots> {
  TextEditingController tetitel = TextEditingController();
  TextEditingController tedetals = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();
  GlobalKey<FormState> form1 = GlobalKey();
  String titel, details;
  int imp;
  DbHelper helper;
  bool valeresult;
  bool valeresult1;
  savForm() {
    valeresult = form.currentState.validate();
    if (valeresult) {
      form.currentState.save();
    } else {
      return null;
    }
  }

  savForm1() {
    valeresult1 = form1.currentState.validate();
    if (valeresult1) {
      form.currentState.save();
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    tetitel.text = widget.notes.titel;
    tedetals.text = widget.notes.detals;
  }

  @override
  Widget build(BuildContext context) {
    int g = widget.notes.import;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF9B700),
        title: Center(
          child: Text(translator.translate('pageedittitl')),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            Form(
              key: form,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextFormField(
                  maxLength: 30,
                  controller: tetitel,
                  cursorColor: Color(0xffF9B700),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value == '' || value.length >= 30) {
                      return translator.translate("errtitel");
                    }
                  },
                  onSaved: (newValue) {
                    this.titel = newValue;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: translator.translate('txtfildtiteladd'),
                  ),
                ),
              ),
            ),
            Form(
              key: form1,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                child: TextFormField(
                  controller: tedetals,
                  cursorColor: Color(0xffF9B700),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 15,
                  validator: (value) {
                    if (value == null || value == '') {
                      return translator.translate("errtitel");
                    }
                  },
                  onSaved: (newValue) {
                    this.titel = newValue;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: translator.translate('txtfilddetalladd'),
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                translator.translate('importadd'),
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.green),
              ),
            ),
            RadioListTile(
              title: Text(translator.translate('import')),
              value: 1,
              groupValue: g,
              onChanged: (value) {
                setState(() {
                  imp = 1;
                  g = 1;
                  setState(() {});
                  print(value.toString() + "////////////////////////");
                });
              },
            ),
            RadioListTile(
              title: Text(translator.translate('normal')),
              value: 0,
              groupValue: g,
              onChanged: (value) {
                setState(() {
                  imp = 0;
                  g = 0;
                  print(value.toString() + "////////////////////////");
                });
              },
            ),
            Container(
              height: 30,
            ),
            RaisedButton(
                textColor: Colors.white,
                color: Color(0xffF9B700),
                child: Text(
                  translator.translate('save'),
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  savForm();
                  savForm1();
                  if (valeresult == true && valeresult1 == true) {
                    var updatedNotes = Notes({
                      'id': widget.notes.id,
                      'titel': tetitel.text,
                      'detals': tedetals.text,
                      'import': imp
                    });
                    showTopSnackBar(
                      context,
                      CustomSnackBar.success(
                        message: translator.translate("doneidt"),
                      ),
                    );
                    helper.updateCourse(updatedNotes);
                    Get.offAll(MyHomePage());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
