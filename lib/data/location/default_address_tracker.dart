import '../../domain/location/address_tracker.dart';
import 'package:geocoding/geocoding.dart';

 class DefaultAddressTracker implements AddressTracker {
  @override
  Future<String> getAddress(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];

    return '${place.country}, ${place.name}';
  }
}