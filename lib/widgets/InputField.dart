import 'package:flutter/material.dart';

class Inputfield extends StatefulWidget {
  final String? title;
  final String? messageempty;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType? textType;
  final bool isPassword;
  final Function(String)? onChanged;
  const Inputfield(
      {this.title,
      required this.hint,
      this.controller,
      this.widget,
      this.textType,
      this.onChanged,
      this.messageempty,
      this.isPassword = false,
      super.key});

  @override
  State<Inputfield> createState() => _InputfieldState();
}

class _InputfieldState extends State<Inputfield> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title!,
                style: const TextStyle(
                  color: Color(0xff224773),
                )),
            TextFormField(
              validator: (input) {
                if (widget.controller!.text.isEmpty) {
                  return '${widget.title} not be empty';
                } else {
                  return null;
                }
              },
              onChanged: widget.onChanged,
              controller: widget.controller,
              obscuringCharacter: "♡",
              obscureText: widget.isPassword ? _obscureText : false,
              keyboardType: widget.textType,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: widget.hint,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                enabled: true,
                contentPadding: const EdgeInsets.all(16.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color:Colors.grey,
                      style: BorderStyle.solid,
                      width: 1,
                    )),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xff224773),
                    width: 2,
                  ),
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
