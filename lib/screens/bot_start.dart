import 'package:flutter/material.dart';

class BotStart extends StatefulWidget {
  final TabController tabController;
  BotStart({Key key, @required this.tabController}) : super(key: key);

  @override
  _BotStartState createState() => _BotStartState();
}

class _BotStartState extends State<BotStart> {
  @override
  Widget build(BuildContext context) {
    var inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      gapPadding: 1.0,
      borderSide: BorderSide(
        width: 0,
        color: Colors.transparent,
        style: BorderStyle.none,
      ),
    );
    List<String> tips = [
      'I need help',
      "Skin Deseases",
      "Hey",
      "Enquiry",
    ];
    var theme = Theme.of(context);
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25),
            physics: BouncingScrollPhysics(),
            child: DefaultTextStyle(
              textAlign: TextAlign.start,
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black45,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Hello I'm TOBi",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("How can i help you ?"),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black12,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: inputBorder,
                          enabledBorder: inputBorder,
                          focusedBorder: inputBorder,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          hintText: "Ask me a question",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            // color: Colors.white60,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text("Quick help"),
                  ),
                  ListView.builder(
                    itemCount: tips.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // perform some actions to load the chat
                          widget.tabController.animateTo(1);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                tips[index],
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.white30,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("see more"),
                        Icon(
                          Icons.arrow_downward,
                          color: Colors.black38,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          margin: EdgeInsets.symmetric(vertical: 10.0),
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(color: Colors.white,
              // borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black12,
                ),
              ]),
          child: Text(
            "Conversation History",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
