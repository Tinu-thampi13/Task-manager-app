import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_management_app/Styles/styles.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.indigoAccent),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

bottomSheetButton({
  required String label,
  required Function()? onTap,
  required Color clr,
  bool isClose = false,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 55,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: isClose == true ? Colors.black : clr,
        ),
        borderRadius: BorderRadius.circular(20),
        color: isClose == true ? Colors.transparent : clr,
      ),
      child: Center(
        child: Text(label,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(color: Colors.white)),
      ),
    ),
  );
}
