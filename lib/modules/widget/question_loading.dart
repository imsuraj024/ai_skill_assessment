import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class QuestionLoading extends StatelessWidget {
  const QuestionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Simulate the level and question number shimmer
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildShimmerBox(height: 30, width: 100),
                _buildShimmerBox(height: 30, width: 80),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 30.0),
                  child: _buildShimmerBox(height: 80, width: double.infinity),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 30.0),
                  child: Column(
                    children: List.generate(
                        4,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: _buildShimmerBox(
                                  height: 30, width: double.infinity),
                            )),
                  ),
                ),
              ],
            ),
          ),
          // Simulate the submit button shimmer
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: _buildShimmerBox(height: 40, width: double.infinity),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerBox({required double height, required double width}) {
    return RepaintBoundary(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: height,
          width: width,
          color: Colors.white,
        ),
      ),
    );
  }
}
