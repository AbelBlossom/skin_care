import 'package:flutter/material.dart';
import 'package:skin_care/screens/bot_chat.dart';
import 'package:skin_care/screens/bot_start.dart';

class Botpage extends StatefulWidget {
  Botpage({Key key}) : super(key: key);

  @override
  _BotpageState createState() => _BotpageState();
}

class _BotpageState extends State<Botpage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: ,
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          BotStart(
            tabController: _tabController,
          ),
          BotChat(
            tabController: _tabController,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
