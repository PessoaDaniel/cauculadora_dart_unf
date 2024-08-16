class CliException implements Exception {
  final String message;

  CliException(this.message);  // Pass your message in constructor.
  @override
  String toString() {
    return message;
  }
}