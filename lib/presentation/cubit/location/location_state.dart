
part of 'location_cubit.dart';

enum LocationStatus { initial, loading, success, failure }

final class LocationState extends Equatable{
  final Position? position;
  final LocationStatus status;

  const LocationState({
    this.position,
    this.status = LocationStatus.initial,
  });

  LocationState copyWith({
    Position? position,
    LocationStatus? status,
  }) {
    return LocationState(
      status: status ?? this.status,
      position: position ?? this.position,
    );
  }

  @override
  List<Object?> get props => [position, status,];
}
