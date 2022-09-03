import 'dart:io' as io;

class Config {
  List<String> requiredEnvVars = ['HTTP_PORT'];
  String HTTP_PORT = '8080';

  Config() {
    Map<String, String> env = io.Platform.environment;
    for (var envVar in requiredEnvVars) {
      if (!env.containsKey(envVar)) {
        throw '${envVar} missing from env';
      }
    }
    HTTP_PORT = env['HTTP_PORT']!;
  }
}
