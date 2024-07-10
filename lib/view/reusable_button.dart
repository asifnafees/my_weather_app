import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ReusableButton extends StatelessWidget {
  final String title;
  final VoidCallback voidCallback;
  const ReusableButton({super.key,
  required this.title,
  required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallback,
      child: Container(
        height: MediaQuery.of(context).size.height*.07,
        width: MediaQuery.of(context).size.width*.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: [
            BoxShadow(
            blurRadius: 10,spreadRadius: 5,
            color: Colors.blueAccent
            ,blurStyle: BlurStyle.outer
        )
        ]),
        child: Center(child: Text(title,style: TextStyle(
          color: Colors.blueAccent,fontWeight: FontWeight.w700,
          fontSize: 18
        ),)),
      ),
    );
  }
}
