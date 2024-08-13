import "package:fe_mal/models/user.dart";

class SessionHelper {
  static User? _currentUser;

  static User? get currentUser => _currentUser;

  static void setCurrentUser(User? user) {
    _currentUser = user;
  }
}
