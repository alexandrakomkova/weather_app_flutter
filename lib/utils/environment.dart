class Environment {
  const Environment._();

  static const String clarifaiApiKey = String.fromEnvironment(
    'CLARIFAI_API_KEY',
  );
  static const String clarifaiModel = String.fromEnvironment('CLARIFAI_MODEL');
  static const String clarifaiModelVersion = String.fromEnvironment(
    'CLARIFAI_MODEL_VERSION',
  );
}
