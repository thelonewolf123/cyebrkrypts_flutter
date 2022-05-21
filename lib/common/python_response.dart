class PythonResponse {
  final List<String> output;
  final List<String> stderr;
  final bool error;

  PythonResponse(this.output, this.stderr, this.error);
}
