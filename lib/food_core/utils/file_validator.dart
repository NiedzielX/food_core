class FileValidator {
  static bool isValid(String path) {
    var regex =  RegExp(
        r"^https://[a-zA-Z0-9./]+")
        .hasMatch(path);
    return !regex;
  }
}
