import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:gp/providers/HistoryItem.dart';
import 'package:sizer/sizer.dart';

class PrevWorkWid extends StatefulWidget {
  Item item;
  PrevWorkWid({Key? key, required this.item}) : super(key: key);
  @override
  _PrevWorkWidState createState() => _PrevWorkWidState(item);
}

class _PrevWorkWidState extends State<PrevWorkWid> {
  Item item;
  _PrevWorkWidState(this.item);
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            item.text,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          trailing: IconButton(
            icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
              setState(() {
                expanded = !expanded;
              });
            },
          ),
        ),
        if (expanded)
          Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.w),
              height: 35.h,
              child: FullScreenWidget(child: Image.network(item.image))),
        Divider()
      ],
    );
  }
}
