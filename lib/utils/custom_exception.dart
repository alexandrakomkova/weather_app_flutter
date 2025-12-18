class CustomException implements Exception {
  final String message;

  const CustomException([
    this.message = '',
  ]);

  @override
  String toString() => 'CustomException: $message';
}

class WeatherRequestFailure extends CustomException {
  const WeatherRequestFailure([super.message = 'Can not processed a request. Please, try later.']);
}
class WeatherNotFoundFailure extends CustomException {
  const WeatherNotFoundFailure([super.message = 'Can not parse a request. Please, try later.']);
}

class ClarifaiApiRequestFailure extends CustomException {
  const ClarifaiApiRequestFailure([super.message = 'Can not processed a request. Please, try later.']);
}
class ClarifaiApiOutputNotFound extends CustomException {
  const ClarifaiApiOutputNotFound([super.message = 'Can not parse a request. Please, try later.']);
}