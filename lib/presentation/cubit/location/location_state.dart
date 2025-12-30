
part of 'location_cubit.dart';

enum LocationStatus { initial, loading, success, failure }

final class LocationState {
  final Position? position;
  final Set<Marker>? mapMarkers;
  final LocationStatus status;

  LocationState({
    this.position,
    this.mapMarkers,
    this.status = LocationStatus.initial,
  });

  LocationState copyWith({
    Position? position,
    LocationStatus? status,
    Set<Marker>? mapMarkers,
  }) {
    return LocationState(
      status: status ?? this.status,
      position: position ?? this.position,
      mapMarkers: mapMarkers ?? this.mapMarkers,
    );
  }

  List<Object?> get props => [
    position,
    status,
    mapMarkers,
  ];
}
