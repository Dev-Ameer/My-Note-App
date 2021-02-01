import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:project2/pages/page1.dart';

class Beforpage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   Future.delayed(Duration(seconds: 3)).then((value) => Get.off(MyHomePage()));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            Text(
              translator.translate('appTitle'),
              style: TextStyle(fontSize: 25,),
            )
          ],
        ),
      ),
    );
  }
}
