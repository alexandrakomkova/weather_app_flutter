// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advice_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdviceState _$AdviceStateFromJson(Map<String, dynamic> json) => AdviceState(
  status:
      $enumDecodeNullable(_$AdviceStatusEnumMap, json['status']) ??
      AdviceStatus.initial,
  advice: json['advice'] as String? ?? '',
  errorMessage: json['errorMessage'] as String? ?? '',
);

Map<String, dynamic> _$AdviceStateToJson(AdviceState instance) =>
    <String, dynamic>{
      'status': _$AdviceStatusEnumMap[instance.status]!,
      'advice': instance.advice,
      'errorMessage': instance.errorMessage,
    };

const _$AdviceStatusEnumMap = {
  AdviceStatus.initial: 'initial',
  AdviceStatus.loading: 'loading',
  AdviceStatus.success: 'success',
  AdviceStatus.failure: 'failure',
};
