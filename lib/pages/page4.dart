import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF9B700),
        title: Center(
          child: Text(translator.translate('pagsitting')),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
              child: Text(
                translator.translate('lang'),
                style: TextStyle(fontSize: 20),
              )),
          RaisedButton(
            onPressed: () {
              translator.setNewLanguage(
                context,
                newLanguage: translator.currentLanguage == 'ar' ? 'en' : 'ar',
                remember: true,
                restart: true,
              );
            },
            child: Text(translator.translate('langs'),
                style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
