import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logging/logging.dart';
import 'package:weather_app/domain/location/location_repository.dart';

part 'location_state.dart';

final _log = Logger('LocationCubit');
class LocationCubit extends Cubit<LocationState> {
  final LocationRepository _locationRepository;

  LocationCubit(this._locationRepository) : super(LocationState()) {
    getPosition();
  }

  Future<void> getPosition() async {
    emit(state.copyWith(status: LocationStatus.loading));

    try {
      final positionData = await _locationRepository.getLocation();
      _addLocationToMapMarkers(positionData);

      emit(state.copyWith(
        status: LocationStatus.success,
        position: positionData,
      ));
    } catch (e) {
      emit(state.copyWith(status: LocationStatus.failure));
    }
  }

  Future<void> _addLocationToMapMarkers(Position positionData) async {
    try {
      final location = LatLng(
        positionData.latitude,
        positionData.longitude,
      );

      final marker = Marker(
        markerId: MarkerId("id_${positionData.latitude}_${positionData.longitude}"),
        position: location,
        infoWindow: InfoWindow(title: "Your location"),
      );

      final Set<Marker> markerList = state.mapMarkers == null ? {} : Set<Marker>.from(state.mapMarkers!);
      markerList.add(marker);

      _log.info('markerList ${markerList.first.position}');

      emit(state.copyWith(mapMarkers: markerList));
    } catch(e) {
      _log.warning(e.toString());
    }
  }
}
