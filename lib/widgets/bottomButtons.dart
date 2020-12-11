import 'package:flutter/material.dart';

class BottomButtonsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CircleAvatar(
          child: Icon(
            Icons.replay,
            color: Colors.yellow,
          ),
          backgroundColor: Colors.white,
        ),
        CircleAvatar(
          child: Icon(
            Icons.close,
            color: Colors.red,
          ),
          backgroundColor: Colors.white,
        ),
        CircleAvatar(
          child: Icon(
            Icons.star,
            color: Colors.blue,
          ),
          backgroundColor: Colors.white,
        ),
        CircleAvatar(
          child: Icon(
            Icons.favorite,
            color: Colors.green,
          ),
          backgroundColor: Colors.white,
        ),
        CircleAvatar(
          child: Icon(
            Icons.flash_on,
            color: Colors.purple,
          ),
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
