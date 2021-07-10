import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  IconTextButton({this.text, this.data, this.openAction});

  final String text;
  final IconData data;
  final Function openAction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orangeAccent.shade700,
              Colors.orange.shade600,
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ElevatedButton(
          onPressed: () {
            openAction();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(data, size: 23),
                Text(
                  text,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
