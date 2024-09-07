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
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50.0,
                  height: 30.0,
                  color: appWhite,
                ),
                Container(
                  width: 50.0,
                  height: 30.0,
                  color: appWhite,
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Container(
              width: double.infinity,
              height: 80.0,
              color: appWhite,
            ),
          ),
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
    return RadioListTile<int>(
      title: Container(
        width: double.infinity,
        height: 30.0,
        color: appWhite,
      ),
      value: 0,
      groupValue: 1,
      onChanged: (int? value) {},
    );
  }
}
