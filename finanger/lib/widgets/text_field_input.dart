import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
  final TextEditingController? textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Icon? icon;
  final Function? onChanged;
  final double width;
  final double? height;
  final Function? onTap;

  const TextFieldInput({
    super.key,
    this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    this.icon,
    this.onChanged,
    this.width = double.infinity,
    this.height,
    this.onTap,
  });

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(8));

    return Container(
      width: widget.width,
      height: widget.height,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
        BoxShadow(
          color: _isFocused
              ? Colors.green.withOpacity(0.3)
              : Colors.green.withOpacity(0.15),
          spreadRadius: 2,
          blurRadius: 4,
          offset: _isFocused ? const Offset(2, 3) : const Offset(0, 0),
        ),
      ]),
      child: TextField(
        controller: widget.textEditingController,
        focusNode: _focusNode,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          prefixIcon: widget.icon,
          prefixIconColor: _isFocused
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.6),
          // label: Text(hintText),
          labelText: widget.hintText,
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          // hintText: hintText,
          border: inputBorder,
          disabledBorder: widget.onChanged != null ? inputBorder : null,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(12),
        ),
        onChanged: widget.onChanged as void Function(String)?,
        keyboardType: widget.textInputType,
        obscureText: widget.isPass,
        onTap: widget.onTap as void Function()?,
      ),
    );
  }
}
