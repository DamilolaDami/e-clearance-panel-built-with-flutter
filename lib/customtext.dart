import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color ?color;
  final FontWeight? fontWeight;

  const CustomText({ Key? key, this.text, this.size, this.color, this.fontWeight }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        fontSize: size ?? 16,
        color: color ?? Colors.black,
        fontWeight: fontWeight ??  FontWeight.normal

      ),
      
    );
  }
}