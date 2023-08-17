import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gp/widgets/AdminBottomBar.dart';
import 'package:gp/widgets/DeafultButton.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:gp/Screens/HomePage.dart';
import '../Constants/AppColours.dart';
import '../widgets/BottomBar.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';

class DisplayImage extends StatefulWidget {
  static List<Image> image = [];
  static List<dynamic> bytes = [];
  static List<dynamic> saveGallaryImg = [];
  static List<dynamic> imagePath = [];
  static String text = '';
  @override
  _DisplayImage createState() => _DisplayImage();
}

class _DisplayImage extends State<DisplayImage> {
  @override
  void initState() {
    HomePage.isLoading = true;
    APIgetter(DisplayImage.text).then((value) {
      setState(() {
        HomePage.isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          HomePage.isAdmin == true ? AdminBottomBar() : BottomBar(),
      backgroundColor: AppColours.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: !HomePage.isLoading
          ? SingleChildScrollView(
              child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5.w,
                ),
                DisplayImage.image.length > 0
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(2.w, 3.h, 2.w, 3.h),
                        child: FullScreenWidget(child: DisplayImage.image[0]))
                    : SizedBox(),
                SizedBox(height: 2.h),
                DisplayImage.image.length > 1
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(2.w, 3.h, 2.w, 3.h),
                        child: FullScreenWidget(child: DisplayImage.image[1]))
                    : SizedBox(),
                DisplayImage.image.length > 1
                    ? SizedBox(height: 2.h)
                    : SizedBox(),
                DisplayImage.image.length > 2
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(2.w, 3.h, 2.w, 3.h),
                        child: FullScreenWidget(child: DisplayImage.image[2]))
                    : SizedBox(),
                DisplayImage.image.length > 2
                    ? SizedBox(height: 2.h)
                    : SizedBox(),
                DisplayImage.image.length > 3
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(2.w, 3.h, 2.w, 3.h),
                        child: FullScreenWidget(child: DisplayImage.image[3]))
                    : SizedBox(),
                DisplayImage.image.length > 1
                    ? SizedBox(height: 2.h)
                    : SizedBox(),
                DefultButton(
                  text: "Save to gallery",
                  nwAT: 'imageTogallery',
                  toWhere: '',
                ),
                DefultButton(
                  text: "Save to your previous work",
                  nwAT: 'imageTOprev',
                  toWhere: '/prevWork',
                ),
                DefultButton(
                  text: "Feedback",
                  nwAT: 'feedback',
                  toWhere: '/prevWork',
                ),
              ],
            ))
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

Future<void> APIgetter(String text) async {
  DisplayImage.bytes.clear();
  DisplayImage.saveGallaryImg.clear();
  DisplayImage.imagePath.clear();
  DisplayImage.image.clear();
  if (HomePage.category == "Wedding Dress") {
    final url = Uri.parse(
        'https://amgad59-keras-cv-wedding-dress.hf.space/run/predict');
    final headers = {"Content-Type": "application/json"};
    final body = {
      "data": [text ?? '', 12],
    };
    final jsonString = json.encode(body);
    var base64, base;
    final response = await http.post(url, headers: headers, body: jsonString);

    if (response.statusCode != 200) {
      print(response.statusCode);
      print('Failed to generate image');
    } else {
      try {
        print(response.bodyBytes);

        base64 = response.body.split(",");
        // encode and save image 1
        base = base64[1].toString().replaceAll(r'"', "");
        DisplayImage.bytes.add(base);
        DisplayImage.image.add(Image.memory(base64Decode(base)));
        final documentDirectory = await getApplicationDocumentsDirectory();
        DisplayImage.imagePath.add(await File(
                '${documentDirectory.path}/${DateTime.now().microsecondsSinceEpoch}0.png')
            .create());

        DisplayImage.saveGallaryImg.add(base64Decode(base));

        // encode and save image 2
        base = base64[3].toString().replaceAll(RegExp(r'"|]'), "");
        DisplayImage.bytes.add(base);
        DisplayImage.image.add(Image.memory(base64Decode(base)));
        DisplayImage.imagePath.add(await File(
                '${documentDirectory.path}/${DateTime.now().microsecondsSinceEpoch}1.png')
            .create());

        DisplayImage.saveGallaryImg.add(base64Decode(base));
        // encode and save image 3
        base = base64[5].toString().replaceAll(r'"', "");
        DisplayImage.bytes.add(base);
        DisplayImage.image.add(Image.memory(base64Decode(base)));
        DisplayImage.imagePath.add(await File(
                '${documentDirectory.path}/${DateTime.now().microsecondsSinceEpoch}2.png')
            .create());

        DisplayImage.saveGallaryImg.add(base64Decode(base));
        // encode and save image 4
        base = base64[7].toString().replaceAll(RegExp(r'"|]'), "");
        DisplayImage.bytes.add(base);
        DisplayImage.image.add(Image.memory(base64Decode(base)));

        DisplayImage.imagePath.add(await File(
                '${documentDirectory.path}/${DateTime.now().microsecondsSinceEpoch}3.png')
            .create());

        DisplayImage.saveGallaryImg.add(base64Decode(base));
      } on Exception catch (e) {
        print('Failed to generate image');
      }
    }
  } else if (HomePage.category == "Casual") {
    final url = Uri.parse('https://amgad59-test-space.hf.space/run/predict');
    final headers = {"Content-Type": "application/json"};

    final body = {
      "data": [text ?? '', 7],
    };
    final jsonString = json.encode(body);
    var base64, base;
    final response = await http.post(url, headers: headers, body: jsonString);

    if (response.statusCode != 200) {
      print(response.statusCode);
      print('Failed to generate image');
    } else {
      try {
        print(response.bodyBytes);
        base64 = response.body.split(",");
        // encode and save image 1
        base = base64[1].toString().replaceAll(r'"', "");
        DisplayImage.bytes.add(base);
        DisplayImage.image.add(Image.memory(base64Decode(base)));
        final documentDirectory = await getApplicationDocumentsDirectory();
        DisplayImage.imagePath.add(await File(
                '${documentDirectory.path}/${DateTime.now().microsecondsSinceEpoch}0.png')
            .create());

        DisplayImage.saveGallaryImg.add(base64Decode(base));

        // encode and save image 2
        base = base64[3].toString().replaceAll(RegExp(r'"|]'), "");
        DisplayImage.bytes.add(base);
        DisplayImage.image.add(Image.memory(base64Decode(base)));
        DisplayImage.imagePath.add(await File(
                '${documentDirectory.path}/${DateTime.now().microsecondsSinceEpoch}1.png')
            .create());

        DisplayImage.saveGallaryImg.add(base64Decode(base));
        // encode and save image 3
        base = base64[5].toString().replaceAll(r'"', "");
        DisplayImage.bytes.add(base);
        DisplayImage.image.add(Image.memory(base64Decode(base)));
        DisplayImage.imagePath.add(await File(
                '${documentDirectory.path}/${DateTime.now().microsecondsSinceEpoch}2.png')
            .create());

        DisplayImage.saveGallaryImg.add(base64Decode(base));
        // encode and save image 4
        base = base64[7].toString().replaceAll(RegExp(r'"|]'), "");
        DisplayImage.bytes.add(base);
        DisplayImage.image.add(Image.memory(base64Decode(base)));

        DisplayImage.imagePath.add(await File(
                '${documentDirectory.path}/${DateTime.now().microsecondsSinceEpoch}3.png')
            .create());

        DisplayImage.saveGallaryImg.add(base64Decode(base));
      } on Exception catch (e) {
        print('Failed to generate image');
      }
    }
  } else {
    const baseUrl = 'https://api.stability.ai';
    final url = Uri.parse(
        '$baseUrl/v1alpha/generation/stable-diffusion-512-v2-0/text-to-image');
    // Make the HTTP POST request to the Stability Platform API
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'sk-bqvENEQ8pWbLxQy1YUI0w1F10gFK4hvpiwJo1tp6QDy10qsG',
        'Accept': 'image/png',
      },
      body: jsonEncode({
        'cfg_scale': 7,
        'clip_guidance_preset': 'FAST_BLUE',
        'height': 512,
        'width': 512,
        'samples': 1,
        'steps': 50,
        'text_prompts': [
          {
            'text': text ?? '',
            'weight': 1,
          }
        ],
      }),
    );
    if (response.statusCode != 200) {
      print('Failed to generate image');
    } else {
      try {
        // DisplayImage.image = Image.memory(response.bodyBytes);
        //DisplayImage.bytes = response.bodyBytes;
        print(response.bodyBytes);
        DisplayImage.bytes.add(response.bodyBytes);
        DisplayImage.image.add(Image.memory(response.bodyBytes));
        final documentDirectory = await getApplicationDocumentsDirectory();
        DisplayImage.imagePath.add(await File(
                '${documentDirectory.path}/${DateTime.now().microsecondsSinceEpoch}.png')
            .create());

        DisplayImage.saveGallaryImg.add(response.bodyBytes);
      } on Exception catch (e) {
        print('Failed to generate image');
      }
    }
  }
}
