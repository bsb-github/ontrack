import 'package:flutter/material.dart';
import 'package:ontrack/utils/color_resources.dart';

class CommonButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  const CommonButton({super.key, required this.onPressed, required this.text});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: ColorResources.primaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        width: double.infinity,
        child: Center(
          child: widget.text == 'true'
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
