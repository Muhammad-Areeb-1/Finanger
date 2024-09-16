import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final String displayText;
  final Icon icon;
  final Function() onPressed;

  const LoadingButton({
    super.key,
    required this.displayText,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isLoading = true;
        });
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            _isLoading = false;
          });
          widget.onPressed();
        });
      },
      child: Container(
        width: 130,
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
        child: _isLoading
            ? Container(
                height: 25,
                width: 25,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.displayText,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    widget.icon.icon,
                    color: Colors.white,
                  ),
                ],
              ),
      ),
    );
  }
}
