import 'package:dating_clone_app/widgets/userCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:dating_clone_app/data/users.dart';
import 'package:dating_clone_app/model/user.dart';
import 'package:dating_clone_app/widgets/bottomButtons.dart';
import 'package:dating_clone_app/providers/feedbackPositionProvider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<User> users = dummyUsers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            users.isEmpty
                ? Center(child: Text('NO More Users'))
                : Stack(children: users.map(buildUser).toList()),
            Expanded(child: Container()),
            BottomButtonsWidget(),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() => AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: FaIcon(FontAwesomeIcons.fire, color: Colors.deepOrange),
        elevation: 0.0,
        actions: <Widget>[
          Icon(Icons.chat, color: Colors.grey),
          SizedBox(width: 16.0)
        ],
        leading: Icon(Icons.person, color: Colors.grey),
      );

  Widget buildUser(User user) {
    final userIndex = users.indexOf(user);
    final isUserInFocus = userIndex == users.length - 1;
    return Listener(
      onPointerMove: (PointerMoveEvent moveEvent) {
        Provider.of<FeedbackPositionProvider>(context, listen: false)
            .updatePosition(moveEvent.localDelta.dx);
      },
      onPointerUp: (_) {
        Provider.of<FeedbackPositionProvider>(context, listen: false)
            .resetPosition();
      },
      onPointerCancel: (_) {
        Provider.of<FeedbackPositionProvider>(context, listen: false)
            .resetPosition();
      },
      child: Draggable(
        child: UserCardWidget(user: user, isUSerInFocus: isUserInFocus),
        feedback: Material(
          type: MaterialType.transparency,
          child: UserCardWidget(user: user, isUSerInFocus: isUserInFocus),
        ),
        childWhenDragging: Container(),
        onDragEnd: (DraggableDetails details) => onDragEnd(details, user),
      ),
    );
  }

  void onDragEnd(DraggableDetails details, User user) {
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      user.isSwipedOff = true;
      setState(() {
        users.remove(user);
      });
    } else if (details.offset.dx < -minimumDrag) {
      user.isLiked = true;
      setState(() {
        users.remove(user);
      });
    }
  }
}
