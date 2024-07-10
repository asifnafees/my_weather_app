import 'package:flutter/material.dart';
import 'package:my_weather_app/view/constant.dart';
class ReusableContainer extends StatelessWidget {
  final String  title;
  final double value;
  const ReusableContainer({super.key,
  required this.title,
  required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*.07,
      width: MediaQuery.of(context).size.width*.25,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(30)
      ),
      child:   Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(title,style: tempTextStyle,),
          Text(value.toString(),style: tempTextStyle),
        ],),
      ),
    );
  }
}
