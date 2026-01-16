part of 'internet_cubit.dart';

enum InternetStatus { loading, connected, disconnected }

final class InternetState {
  final InternetStatus status;

  const InternetState({this.status = InternetStatus.loading});

  InternetState copyWith({InternetStatus? status}) {
    return InternetState(status: status ?? this.status);
  }

  List<Object> get props => [status];
}
