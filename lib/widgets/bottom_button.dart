import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  BottomButton({
    @required this.onTap,
    @required this.buttonTitle,
    @required this.imageSelected,
  });

  final Function onTap;
  final String buttonTitle;
  final bool imageSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: imageSelected ? Color(0xFFEB1555) : Colors.grey,
        width: double.infinity,
        height: 50,
        padding: EdgeInsets.only(bottom: 20),
        child: Center(
          child: Text(
            buttonTitle,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: imageSelected ? Colors.white : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
