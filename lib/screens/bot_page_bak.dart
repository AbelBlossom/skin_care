import 'package:flutter/material.dart';
import 'package:skin_care/screens/bot_chat.dart';
import 'package:skin_care/screens/bot_start.dart';
import 'package:skin_care/utils/notch.dart';

// Color primaryColor = Color.fromRGBO(255, 0, 0, 1);

class BotPageBak extends StatefulWidget {
  BotPageBak({Key key}) : super(key: key);

  @override
  _BotPageBakState createState() => _BotPageBakState();
}

class _BotPageBakState extends State<BotPageBak>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    tabController = TabController(vsync: this, length: 2)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size imgSize = Size(80, 80);
    var media = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: media.padding.top + imgSize.height / 4,
            left: media.size.width / 2 - imgSize.width / 2 + 15,
            child: Container(
              width: imgSize.width - 20,
              height: imgSize.height - 20,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(imgSize.width / 2),
              ),
              child: Center(
                  child: Icon(
                Icons.bluetooth_connected,
                color: Colors.white,
                size: 30,
              )),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  height: imgSize.height / 2,
                  width: imgSize.height / 2,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                    child: CustomPaint(
                      painter: NotchPainter(imgSize,
                          bgColor: Theme.of(context).primaryColor),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: imgSize.width / 10,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    tabController.index == 0
                                        ? SizedBox.shrink()
                                        : IconButton(
                                            icon: Icon(Icons.arrow_back),
                                            color: Colors.white,
                                            onPressed: () {
                                              tabController.animateTo(0);
                                            },
                                          ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      color: Colors.white,
                                      icon: Icon(Icons.close),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: tabController,
                                children: <Widget>[
                                  BotStart(
                                    tabController: tabController,
                                  ),
                                  BotChat(
                                    tabController: tabController,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
