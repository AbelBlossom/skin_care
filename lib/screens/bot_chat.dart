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
    Future.microtask(
      () => Provider.of<Bot>(context, listen: false).receives.listen((_data) {
        // setState(() {
        _conversation.insert(0, _data);
        // });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    bot = Provider.of<Bot>(context);
    var kBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: BorderSide(
        color: Colors.transparent,
        style: BorderStyle.none,
        width: 0.0,
      ),
    );
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    widget.tabController.animateTo(0);
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: _query,
                    decoration: InputDecoration(
                      hintText: "write a message",
                      border: kBorder,
                      enabledBorder: kBorder,
                      focusedBorder: kBorder,
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: StreamBuilder<Object>(
                  stream: Provider.of<Bot>(context, listen: false).receives,
                  builder: (context, snapshot) {
                    return ListView.builder(
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                      // reverse: true,
                      padding: EdgeInsets.only(
                        right: 10.0,
                        left: 10.0,
                        top: 10.0,
                      ),
                      itemCount: _conversation.length,
                      itemBuilder: (context, index) {
                        return ChatCard(
                          input: _conversation.elementAt(index),
                        );
                      },
                    );
                  }),
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
    var media = MediaQuery.of(context);
    double width = media.size.width;
    var theme = Theme.of(context);
    return Container(
      // padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
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
              boxShadow: [
                BoxShadow(
                  blurRadius: 7,
                  color: Colors.black.withOpacity(0.10),
                ),
              ],
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
                                  ),
                                ),
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
