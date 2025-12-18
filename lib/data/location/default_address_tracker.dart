import '/domain/location/address_tracker.dart';
import 'package:geocoding/geocoding.dart';

 class DefaultAddressTracker implements AddressTracker {
  @override
  Future<String> getAddress({
    required double latitude,
    required double longitude,
  }) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];

    return '${place.name}, ${place.country}';
  }
}