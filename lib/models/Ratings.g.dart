// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Ratings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RatingsImpl _$$RatingsImplFromJson(Map<String, dynamic> json) =>
    _$RatingsImpl(
      rate: (json['rate'] as num).toDouble(),
      count: (json['count'] as num).toDouble(),
    );

Map<String, dynamic> _$$RatingsImplToJson(_$RatingsImpl instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'count': instance.count,
    };
