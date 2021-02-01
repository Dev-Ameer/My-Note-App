import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:project2/db/dbhelper.dart';
import 'package:project2/model/notes.dart';
import 'package:project2/pages/page1.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  //final myController1 = TextEditingController();
  //final myController2 = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();
  GlobalKey<FormState> form1 = GlobalKey();
  String titel, details;
  int imp = 1;
  DbHelper helper;
  int g = 1;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF9B700),
        title: Center(
          child: Text(translator.translate('pageaddtitl')),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: form,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextFormField(
                  maxLength: 30,
                  cursorColor: Color(0xffF9B700),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value == ''||value.length>=30) {
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
                  onChanged: (value) {
                    setState(() {
                      titel = value;
                    });
                  },
                ),
              ),
            ),
            Form(
              key: form1,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                child: TextFormField(
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
                    this.details = newValue;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: translator.translate('txtfilddetalladd'),
                  ),
                  onChanged: (value) {
                    setState(() {
                      details = value;
                    });
                  },
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
                  g = value;
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
                  g = value;
                });
              },
            ),
            Container(
              height: 30,
            ),
            Center(
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xffF9B700),
                child: Text(
                  translator.translate('save'),
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  savForm();
                  savForm1();
                  if (valeresult == true && valeresult1 == true) {
                    var notes = Notes(
                        {'titel': titel, 'detals': details, 'import': imp});
                    int id = await helper.createNote(notes);
                    Get.offAll(MyHomePage());
                    print('note id is $id');
                    showTopSnackBar(
                      context,
                      CustomSnackBar.success(
                        message: translator.translate("donadd"),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
