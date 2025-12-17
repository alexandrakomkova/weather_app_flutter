import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/domain/repository/advice_repository.dart';
import 'package:weather_app/presentation/cubit/model/weather_cubit_model.dart';

part 'advice_state.dart';
part 'advice_cubit.g.dart';

class AdviceCubit extends HydratedCubit<AdviceState> {
  final AdviceRepository _adviceRepository;

  AdviceCubit({
    required AdviceRepository adviceRepository,
  }) : _adviceRepository = adviceRepository,
        super(const AdviceState());

  Future<void> fetchRecommendation({
    required WeatherCubitModel weather,
    required TemperatureUnits temperatureUnits,
  }) async {
    debugPrint('AdviceCubit fetchRecommendation');
    return await _getAIRecommendation(
      weather: weather,
      temperatureUnits: temperatureUnits,
    );
  }

  Future<void> _getAIRecommendation({
    required WeatherCubitModel weather,
    required TemperatureUnits temperatureUnits,
  }) async {
    emit(state.copyWith(
      status: AdviceStatus.loading,
    ));

    try {
      final res = await _adviceRepository.getClothesRecommendation(
        weather: weather,
        temperatureUnits: temperatureUnits,
      );

      emit(state.copyWith(
        status: AdviceStatus.success,
        advice: res,
        errorMessage: ''
      ));

    } catch(e) {
      emit(state.copyWith(
        status: AdviceStatus.failure,
        errorMessage: e.toString()
      ));
    }
  }

  @override
  AdviceState? fromJson(Map<String, dynamic> json) =>
    AdviceState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AdviceState state) =>
    state.toJson();
}
