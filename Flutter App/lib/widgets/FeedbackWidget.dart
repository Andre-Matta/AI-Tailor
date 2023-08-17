import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:sizer/sizer.dart';
import '../providers/FeedbackItem.dart';

class FeedbackWidget extends StatefulWidget {
  FeedbackItem item;
  FeedbackWidget({Key? key, required this.item}) : super(key: key);
  @override
  _FeedbackWidgetState createState() => _FeedbackWidgetState(item);
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  FeedbackItem item;
  _FeedbackWidgetState(this.item);
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5.w),
        ListTile(
          title: Text(
            item.feedback,
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
          Column(
            children: [
              Text(
                item.text,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5.w),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.w),
                  height: 35.h,
                  child: FullScreenWidget(child: Image.network(item.image))),
            ],
          ),
        Divider()
      ],
    );
  }
}
