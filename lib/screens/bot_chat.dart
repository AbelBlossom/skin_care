import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:skin_care/bloc/bot.dart';
import 'package:skin_care/models/question.dart';

class BotChat extends StatefulWidget {
  final TabController tabController;
  BotChat({Key key, @required this.tabController}) : super(key: key);

  @override
  _BotChatState createState() => _BotChatState();
}

class _BotChatState extends State<BotChat> {
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController(keepScrollOffset: true);
  List<Input> _conversation = [];
  Bot bot;
  @override
  void initState() {
    super.initState();
    Provider.of<Bot>(context, listen: false).receives.listen((_data) {
      setState(() {
        _conversation.insert(0, _data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bot = Provider.of<Bot>(context);
    var kBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    );
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              itemCount: _conversation.length,
              itemBuilder: (context, index) {
                return ChatCard(
                  input: _conversation.elementAt(index),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.grey.shade800,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: kBorder,
                hintText: "Write a message",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              onSubmitted: _query,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _query(String data) async {
    await bot.query(data);
    _controller.clear();
    _scrollController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  void dispose() {
    bot.saveConversation(_conversation);
    super.dispose();
  }
}

typedef Future<void> Query(String data);

class ChatCard extends StatelessWidget {
  final Input input;
  const ChatCard({@required this.input, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    return Container(
      child: Row(
        mainAxisAlignment:
            input.isAnswer ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            constraints: BoxConstraints(maxWidth: width * 0.7),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: input.isAnswer ? Colors.white : Colors.black26,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  input.text,
                  style: TextStyle(
                    color: input.isAnswer ? Colors.black : Colors.white,
                    fontSize: 17,
                  ),
                ),
                Builder(
                  builder: (_) {
                    if (input.suggestions != null) {
                      if (input.suggestions.isNotEmpty) {
                        List _helps = input.suggestions;
                        return ListView.builder(
                          itemCount: _helps.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, i) {
                            return GestureDetector(
                              onTap: () async {
                                await Provider.of<Bot>(context, listen: false)
                                    .query(_helps.elementAt(i));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Container(
                                    padding: EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Text(
                                      _helps.elementAt(i),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            );
                          },
                        );
                      }
                    }
                    return SizedBox.shrink();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
