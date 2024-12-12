

import 'package:flutter/material.dart';
import 'package:task_manager/component/color_component.dart';
import 'package:task_manager/component/text_component.dart';

class BaseElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final FontWeight fontWeight;
  final bool baseCondition;

  BaseElevatedButton({
    required this.text,
    required this.onPressed,
    this.color,
    this.borderRadius = 10.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w600,
    this.baseCondition = false
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? primaryColor500,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: baseCondition ? Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Text(
            text,
            style: AppTextStyles.baseTextStyle(color: Colors.transparent, fontSize: fontSize, fontWeight: fontWeight),
          ),
          SizedBox(
            width: fontSize.toDouble(),
            height: fontSize.toDouble(),
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.5,
            ),
          ),
        ],
      ) : Text(
        text,
        style: AppTextStyles.baseTextStyle(color: Colors.white, fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}