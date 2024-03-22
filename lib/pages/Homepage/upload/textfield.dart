import 'package:flutter/material.dart';

class Custometextfield extends StatefulWidget {
  const Custometextfield({
    super.key,
    required this.hintText,
    required this.onChanged,
  });
  final String hintText;
  final Function(String, String) onChanged;

  @override
  State<Custometextfield> createState() => _CustometextfieldState();
}

class _CustometextfieldState extends State<Custometextfield> {
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _controller.addListener(() {
      widget.onChanged(_controller.text, widget.hintText);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.hintText == "description"
          ? TextInputType.multiline
          : TextInputType.text,
      controller: _controller,
      onChanged: (value) {
        setState(() {
          widget.onChanged(_controller.text, widget.hintText);
        });
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
      ),
    );
  }
}
