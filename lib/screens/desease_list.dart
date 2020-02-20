import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_care/bloc/navigator.dart';
import 'package:skin_care/models/deseases.dart';
import 'package:skin_care/screens/desease_detail.dart';

class DeseaseList extends StatefulWidget {
  DeseaseList({Key key}) : super(key: key);

  @override
  _DeseaseListState createState() => _DeseaseListState();
}

class _DeseaseListState extends State<DeseaseList> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(top: media.padding.top),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("DESEASES",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    )),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: theme.primaryColor,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                physics: BouncingScrollPhysics(),
                children: Desease.all.map((e) => _buildCard(e)).toList()),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Desease _desease) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              blurRadius: 10, color: Colors.black12, offset: Offset(10, 10))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () async {
            Provider.of<NavigatorBloc>(context, listen: false)
                .navigatorKey
                .currentState
                .push(
                  CupertinoPageRoute(
                    builder: (_) => DeseaseDetail(
                      desease: _desease,
                    ),
                  ),
                );
          },
          child: Hero(
            tag: _desease.image,
            key: Key(_desease.image),
            child: Container(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                      child: Image.asset(
                    _desease.image,
                    fit: BoxFit.cover,
                  )),
                  Positioned.fill(
                      child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black87],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                  )),
                  Positioned(
                    right: 6,
                    left: 6,
                    bottom: 10,
                    child: Text(
                      _desease.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
