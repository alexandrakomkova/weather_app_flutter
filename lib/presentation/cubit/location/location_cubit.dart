import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/domain/location/location_repository.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationRepository _locationRepository;

  LocationCubit(this._locationRepository) : super(LocationState()) {
   getPosition();
  }

  Future<void> getPosition() async {
    emit(state.copyWith(status: LocationStatus.loading));

    try {
      final positionData = await _locationRepository.getLocation();

      emit(state.copyWith(
        status: LocationStatus.success,
        position: positionData,
      ));
    } catch (e) {
      emit(state.copyWith(status: LocationStatus.failure));
    }
  }
}
