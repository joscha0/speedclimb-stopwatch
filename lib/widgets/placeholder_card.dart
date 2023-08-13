import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlaceholderCard extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  const PlaceholderCard({
    super.key,
    this.width = 150,
    this.height = 150,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade800,
        highlightColor: Colors.grey.shade800,
        enabled: true,
        child: Container(
          height: height,
          width: width,
          color: Colors.black,
        ),
      ),
    );
  }
}
