import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          this.label.toString().split("|")[0],
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
          child: Container(
        height: 400,
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey),
        child: Text(
          this.label.toString().split("|")[1],
          style: const TextStyle(color: Colors.black, fontSize: 30),
        ),
      )),
    );
  }
}
