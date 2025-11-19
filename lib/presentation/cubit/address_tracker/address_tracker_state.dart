part of 'address_tracker_cubit.dart';

enum AddressTrackerStatus {
  initial,
  loading,
  success,
  failure,
}

final class AddressTrackerState extends Equatable {
  final String address;
  final AddressTrackerStatus status;

  const AddressTrackerState({
    this.address = 'No location found',
    this.status = AddressTrackerStatus.initial,
  });

  AddressTrackerState copyWith({
    String? address,
    AddressTrackerStatus? status,
  }) {
    return AddressTrackerState(
      status: status ?? this.status,
      address: address ?? '',
    );
  }

  @override
  List<Object?> get props => [
    address,
    status,
  ];
}
