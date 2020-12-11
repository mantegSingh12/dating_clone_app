import 'package:dating_clone_app/model/user.dart';
import 'package:dating_clone_app/providers/feedbackPositionProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCardWidget extends StatelessWidget {
  final User user;
  final bool isUSerInFocus;

  UserCardWidget({@required this.user, @required this.isUSerInFocus});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedbackPositionProvider>(context);
    final swipingDirection = provider.swipingDirection;
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      width: size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 0.5)],
        gradient: LinearGradient(
            colors: [Colors.black12, Colors.black87],
            begin: Alignment.center,
            stops: [0.4, 1.0],
            end: Alignment.bottomCenter),
        image: DecorationImage(
          image: AssetImage(user.imgUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 10,
            left: 10,
            bottom: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildUserInfo(user: user),
                Padding(
                  padding: EdgeInsets.only(bottom: 16, right: 8),
                  child: Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          if (isUSerInFocus) buildLikeUnlikeBadge(swipingDirection)
        ],
      ),
    );
  }
}

Widget buildUserInfo({@required User user}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '${user.name},${user.age}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '${user.designation}',
          style: TextStyle(color: Colors.white),
        )
      ],
    ),
  );
}

Widget buildLikeUnlikeBadge(SwipingDirection swipingDirection) {
  final isSwipingRight = swipingDirection == SwipingDirection.right;
  final color = isSwipingRight ? Colors.green : Colors.red;
  final angle = isSwipingRight ? -0.5 : 0.5;
  if (swipingDirection == SwipingDirection.none) {
    return Container();
  } else {
    return Positioned(
      top: 20,
      right: isSwipingRight ? null : 20,
      left: isSwipingRight ? 20 : null,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration:
              BoxDecoration(border: Border.all(color: color, width: 2.0)),
          child: Text(
            isSwipingRight ? 'LIKE' : 'NOPE',
            style: TextStyle(
                color: color, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
