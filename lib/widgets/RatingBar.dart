import 'package:flutter/material.dart';

class RatingStars extends StatefulWidget {
  final int starCount;
  final double rating;
  final Color color;

  const RatingStars({super.key,
    this.starCount = 5,
    this.rating = 0.0,
    this.color = Colors.yellow,
  });

  @override
  _RatingStarsState createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.rating;
  }

  Widget buildStar(int index) {
    Icon icon;
    if (index >= _rating) {
      icon = Icon(
        Icons.star_border,
        color: widget.color,
      );
    } else if (index > _rating - 1 && index < _rating) {
      icon = Icon(
        Icons.star_half,
        color: widget.color,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: widget.color,
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.starCount,
            (index) => buildStar(index),
      ),
    );
  }
}
