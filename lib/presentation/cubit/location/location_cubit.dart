import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../../data/location/location_repository_impl.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationRepositoryImpl _locationRepositoryImpl;
  LocationCubit(this._locationRepositoryImpl) : super(LocationState());

  Future<void> getPosition() async {
    emit(state.copyWith(status: LocationStatus.loading));

    try {
      final positionData = await _locationRepositoryImpl.getLocation();


      emit(state.copyWith(
          status: LocationStatus.success,
        position: positionData,
      ));
    } catch (e) {
      emit(state.copyWith(status: LocationStatus.failure));
    }
  }
}
