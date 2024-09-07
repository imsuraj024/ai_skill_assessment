import 'package:ai_skill_assessment/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashUsecase {
  SplashUsecase();

  Future<void> fetchModelAndKey() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('configurable_items')
        .doc('ai')
        .get();

    model = snapshot.data()!['model'];
    apiKey = snapshot.data()!['key'];
  }

  Future<void> fetchLevelParams() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('configurable_items')
        .doc('prompt')
        .get();

    beginner = snapshot.data()!['beginner'];
    intermediate = snapshot.data()!['intermediate'];
    advanced = snapshot.data()!['advanced'];
    expert = snapshot.data()!['expert'];
  }
}
