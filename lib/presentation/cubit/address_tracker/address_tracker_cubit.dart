import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/data/location/default_address_tracker.dart';
import 'package:weather_app/domain/location/address_tracker.dart';

part 'address_tracker_state.dart';

class AddressTrackerCubit extends Cubit<AddressTrackerState> {
  final AddressTracker _addressTracker;

  AddressTrackerCubit(this._addressTracker) : super(AddressTrackerState());

  Future<void> getAddress(double latitude, double longitude) async {
    emit(state.copyWith(status: AddressTrackerStatus.loading));
    
    try {
      final address = await _addressTracker.getAddress(latitude, longitude);

      emit(state.copyWith(
          status: AddressTrackerStatus.success,
        address: address,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: AddressTrackerStatus.failure,
      ));
    }
  }
}
