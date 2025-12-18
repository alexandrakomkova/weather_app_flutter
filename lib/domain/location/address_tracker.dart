abstract class AddressTracker {
  Future<String> getAddress({
    required double latitude,
    required double longitude,
  });
}