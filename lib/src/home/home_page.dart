import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:barcode_scan/barcode_scan.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String barcode = "";
  
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
     return  MaterialApp(
      home:  Scaffold(
        appBar:  AppBar(
          title:  Text('Barcode Scanner Example'),
        ),
        body:  Center(
          child:  Column(
            children: <Widget>[
                Container(
                child:  MaterialButton(
                  onPressed: scan, 
                  child:  Text("Scan")
                ),
                padding: const EdgeInsets.all(8.0),
              ),
                Text(barcode),
            ],
          ),
        )
      ),
    );
  }
}
