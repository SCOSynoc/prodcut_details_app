import 'package:freezed_annotation/freezed_annotation.dart';

part 'Ratings.freezed.dart';
part 'Ratings.g.dart';

@freezed
class Ratings with _$Ratings {
  const factory Ratings({
    required double rate,
    required double count,
  }) = _Ratings;

  factory Ratings.fromJson(Map<String,dynamic> json) => _$RatingsFromJson(json);
}