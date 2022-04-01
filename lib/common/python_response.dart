import 'dart:collection';

class PythonResponse {
  final String language, version;
  final dynamic run;
  PythonResponse(this.language, this.version, this.run);
}
