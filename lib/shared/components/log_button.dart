import 'package:flutter/material.dart';

class NewButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final double height;
  final double width;
  final VoidCallback onClick;
  final double radius;
  final Color buttonColor;
  final bool isCapitalize;

  const NewButton({
    Key? key,
    required this.text,
    required this.onClick,
    this.height = 52.0,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.radius = 6.0,
    this.buttonColor = Colors.blue,
    this.isCapitalize = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: buttonColor,
      ),
      child: MaterialButton(
        onPressed: () {
          onClick();
        },
        child: Text(
          isCapitalize ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
