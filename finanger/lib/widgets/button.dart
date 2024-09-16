import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String displayText;
  final void Function() onPressed;
  final double width;
  final double height;
  final Icon? icon;

  const Button({
    super.key,
    required this.displayText,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 48,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: width,
        height: icon != null ? 53 : height,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: ShapeDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.greenAccent,
                Colors.greenAccent.shade700,
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            shadows: [
              BoxShadow(
                color: Colors.green.shade200,
                blurRadius: 4,
                offset: const Offset(1.5, 2),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayText,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(width: icon != null ? 8 : 0),
            icon != null
                ? Icon(
                    icon!.icon,
                    color: Colors.white,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
