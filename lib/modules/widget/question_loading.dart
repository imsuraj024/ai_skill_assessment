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
          Row(
            children: [
              Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: appBlack,
                ),
              ),
              Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: appBlack,
                ),
              ),
            ],
          ),
          const Divider(),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Text(
              '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: appBlack,
              ),
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
      title: const Text(''),
      value: 0,
      groupValue: 1,
      onChanged: (int? value) {},
    );
  }
}
