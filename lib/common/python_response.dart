class PythonResponse {
  final String _language, _version;
  final dynamic _run;
  PythonResponse(this._language, this._version, this._run);
  // getter for run
  dynamic get run => _run;
  // getter for stdout
  String get stdout => _run['stdout'];
  // getter for stderr
  String get stderr => _run['stderr'];
  // getter for language
  String get language => _language;
  // getter for version
  String get version => _version;
}
