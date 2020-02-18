import 'package:flutter/material.dart';
import 'package:skin_care/screens/bot_start.dart';

class NewBotPage extends StatefulWidget {
  NewBotPage({Key key}) : super(key: key);

  @override
  _NewBotPageState createState() => _NewBotPageState();
}

class _NewBotPageState extends State<NewBotPage> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Container(
      width: media.size.width,
      height: media.size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: media.size.width,
            height: 60,
            color: Colors.green,
          ),
          Expanded(
            child: BotStart(tabController: null),
          ),
        ],
      ),
    );
  }
}
