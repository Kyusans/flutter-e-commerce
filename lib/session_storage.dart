class SessionStorage {
  // default ani dapat is false pero for development purpose, eh true sa nako kay sakit sa mata
  static bool isDarkMode = true;
  static String url = "http://localhost/contact/";
  static String name = "";
  static String email = "";

  void setProfile(String name, String email) {
    SessionStorage.name = name;
    SessionStorage.email = email;
  }
}
