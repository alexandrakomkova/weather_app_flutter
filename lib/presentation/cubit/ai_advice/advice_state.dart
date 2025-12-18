part of 'advice_cubit.dart';

enum AdviceStatus {
  initial,
  loading,
  success,
  failure;
}

@JsonSerializable()
final class AdviceState extends Equatable {
  final AdviceStatus status;
  final String advice;
  final String errorMessage;

  const AdviceState({
    this.status = AdviceStatus.initial,
    this.advice = '',
    this.errorMessage = '',
  });

  AdviceState copyWith({
    AdviceStatus? status,
    String? advice,
    String? errorMessage,
  }) {
    return AdviceState(
      status: status ?? this.status,
      advice: advice ?? this.advice,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory AdviceState.fromJson(Map<String, dynamic> json) =>
      _$AdviceStateFromJson(json);

  Map<String, dynamic> toJson() => _$AdviceStateToJson(this);

  @override
  List<Object> get props => [
    status,
    advice,
    errorMessage,
  ];
}

