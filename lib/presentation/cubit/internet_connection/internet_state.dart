part of 'internet_cubit.dart';

enum InternetStatus {
  loading, connected, disconnected;

  bool get isLoading => this == InternetStatus.loading;
  bool get isConnected => this == InternetStatus.connected;
  bool get isDisconnected => this == InternetStatus.disconnected;
}

final class InternetState {
  final InternetStatus status;

  const InternetState({
    this.status = InternetStatus.loading
  });

  InternetState copyWith({
    InternetStatus? status,
  }) {
    return InternetState(
      status: status ?? this.status,
    );
  }

  List<Object> get props => [status,];
}
