class Validator {
  static basicValidator(String str) {
    if (str == null || str.length == 0) {
      return "Enter details";
    }
    return null;
  }

  static basicPhoneNumber(String str) {
    if (str == null || str.length < 10) {
      return "Enter valid phone number";
    }
    return null;
  }

  static basicEmail(String str) {
    if (str == null || str.length == 0 || !str.contains("@")) {
      return "Enter valid Email Address";
    }
    return null;
  }
}
