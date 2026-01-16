import 'package:geocoding/geocoding.dart';
import 'package:weather_app/utils/widget_service.dart';

import '/domain/location/address_tracker.dart';

class DefaultAddressTracker implements AddressTracker {
  @override
  Future<String> getAddress({
    required double latitude,
    required double longitude,
  }) async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );
    final Placemark place = placemarks[0];

    final location = '${place.name}, ${place.country}';
    WidgetService.updateLocationDataWidget(location);
    return location;
  }
}
