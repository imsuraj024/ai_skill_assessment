import 'package:flutter/material.dart';
import 'package:ai_skill_assessment/styles/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class QuestionLoading extends StatelessWidget {
  const QuestionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: appGrey300,
      highlightColor: appGrey100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 100.0,
            color: appWhite,
            margin: const EdgeInsets.all(20.0),
          ),
          const SizedBox(height: 20.0),
          ...List.generate(
            4,
            (index) => const AnswerLoading(),
          ),
        ],
      ),
    );
  }
}

class AnswerLoading extends StatelessWidget {
  const AnswerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Container(
            width: 30.0,
            height: 30.0,
            color: appWhite,
            margin: const EdgeInsets.symmetric(vertical: 10.0),
          ),
          const SizedBox(width: 15.0),
          Container(
            width: 300.0,
            height: 30.0,
            color: appWhite,
            margin: const EdgeInsets.symmetric(vertical: 10.0),
          ),
        ],
      ),
    );
  }
}
