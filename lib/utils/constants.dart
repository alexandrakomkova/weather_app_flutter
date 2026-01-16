import 'package:weather_app/utils/environment.dart';

const baseUrlOpenMeteo = 'api.open-meteo.com';

const clarifaiUrl =
    'https://api.clarifai.com/v2/users/openai/apps/'
    'chat-completion/models/${Environment.clarifaiModel}/'
    'versions/${Environment.clarifaiModelVersion}/outputs';
