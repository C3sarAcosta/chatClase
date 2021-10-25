import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  final String texto;
  final Color color;
  const CustomLabel({
    Key? key,
    required this.texto,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            texto,
            style: TextStyle(
                color: color, fontSize: 20, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
