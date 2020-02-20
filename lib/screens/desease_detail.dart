import 'package:flutter/material.dart';
import 'package:skin_care/models/deseases.dart';

class DeseaseDetail extends StatefulWidget {
  final Desease desease;
  DeseaseDetail({Key key, this.desease}) : super(key: key);

  @override
  _DeseaseDetailState createState() => _DeseaseDetailState();
}

class _DeseaseDetailState extends State<DeseaseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        textTheme: TextTheme(
            title: TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        )),
        title: Text(widget.desease.name),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Hero(
              tag: widget.desease.image,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10.0,
                        color: Colors.black12,
                      )
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(
                        widget.desease.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
