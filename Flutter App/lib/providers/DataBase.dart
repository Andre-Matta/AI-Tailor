import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gp/Screens/DisplayImage.dart';
import 'package:gp/providers/AuthService.dart';
import 'package:gp/providers/FeedbackItem.dart';
import 'package:http/http.dart' as http;
import 'package:gp/providers/HistoryItem.dart';
import '../Screens/HomePage.dart';

class DataBase {
  static bool isPrevWork = false;
  static List<Item> history = [];
  static List<FeedbackItem> feedbacks = [];

  static Future<void> addImage() async {
    String email = AuthService.Email!;
    isPrevWork = true;
    final _firebaseStorage = FirebaseStorage.instance;

    for (int i = 0; i < DisplayImage.imagePath.length; i++) {
      //Select Image
      var f;
      if (HomePage.category == "Wedding Dress" ||
          HomePage.category == "Casual") {
        f = await DisplayImage.imagePath[i]
            .writeAsBytes(base64Decode(DisplayImage.bytes[i]));
      } else {
        f = await DisplayImage.imagePath[i].writeAsBytes(DisplayImage.bytes[i]);
      }

      var file = File(f.path);
      var snapshot = await _firebaseStorage
          .ref()
          .child('images/${DateTime.now().microsecondsSinceEpoch}$i')
          .putFile(file);

      var downloadUrl = await snapshot.ref.getDownloadURL();

      final url =
          'https://tailor-6cc1a-default-rtdb.firebaseio.com/$email/Images.json';
      try {
        final response = await http.post(
          Uri.parse(url),
          body: json.encode({
            'text': DisplayImage.text,
            'image': downloadUrl,
          }),
        );
        if (history.isNotEmpty) {
          history.add(Item(text: DisplayImage.text, image: downloadUrl));
        }
      } catch (error) {
        print(error);
        throw error;
      }
    }
  }

  static Future<void> getItem() async {
    final url =
        'https://tailor-6cc1a-default-rtdb.firebaseio.com/${AuthService.Email}/Images.json';
    try {
      final response = await http.get(Uri.parse(url));
      print(AuthService.Email);
      print(response.body);
      final extractedData = json.decode(response.body) as Map<dynamic, dynamic>;
      var text, img;
      extractedData.forEach((prodId, prodData) async {
        text = prodData['text'];
        img = prodData['image'];
        history.add(Item(text: text, image: img));
      });
      print(history);
    } catch (error) {}
  }

  static Future<void> addFeedback(String feedback) async {
    final _firebaseStorage = FirebaseStorage.instance;

    //Select Image
    var f;
    if (HomePage.category == "Wedding Dress" || HomePage.category == "Casual") {
      f = await DisplayImage.imagePath[0]
          .writeAsBytes(base64Decode(DisplayImage.bytes[0]));
    } else {
      f = await DisplayImage.imagePath[0].writeAsBytes(DisplayImage.bytes[0]);
    }

    var file = File(f.path);
    var snapshot = await _firebaseStorage
        .ref()
        .child('images/${DateTime.now().microsecondsSinceEpoch}')
        .putFile(file);

    var downloadUrl = await snapshot.ref.getDownloadURL();

    final url =
        'https://tailor-6cc1a-default-rtdb.firebaseio.com/Feedback.json';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'text': DisplayImage.text,
          'image': downloadUrl ?? "",
          "feedback": feedback
        }),
      );
    } catch (error) {
      print(error);
      throw error;
    }
  }

  static Future<void> getFeedbacks() async {
    final url =
        'https://tailor-6cc1a-default-rtdb.firebaseio.com/Feedback.json';
    try {
      final response = await http.get(Uri.parse(url));
      print(response.body);
      final extractedData = json.decode(response.body) as Map<dynamic, dynamic>;
      var text, feedback, image;
      extractedData.forEach((prodId, prodData) async {
        text = prodData['text'];
        feedback = prodData['feedback'];
        image = prodData['image'];
        feedbacks
            .add(FeedbackItem(feedback: feedback, text: text, image: image));
      });
    } catch (error) {}
  }
}
