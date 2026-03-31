import 'package:boifiok/user/auth/model/colours.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback? onTap;
  final String buttonText;
  final Color? color;
  const Button({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.color = AppColors.primary
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )
        ),
        onPressed: onTap, 
        child: Text(
          buttonText, 
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400,
          color: Colors.white),
        )),
    );
  }
}