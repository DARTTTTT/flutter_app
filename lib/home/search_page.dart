import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/model/Content.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Page();
  }
}

class Page extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.red,
          title: TextField(
            autofocus: true,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                hintText: "搜素你要的内容",
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                hintStyle: TextStyle(fontSize: 15, color: Colors.white)),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],
        ),
        preferredSize: Size.fromHeight(Content.BAR_HEIGHT),
      ),
    );
  }
}
