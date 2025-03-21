class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Store users: email → password
  final Map<String, String> _userDatabase = {};

  // Track current logged-in user
  String? _loggedInEmail;

  /// Register a new user
  /// Returns true if successful, false if email already exists
  bool register(String email, String password) {
    if (_userDatabase.containsKey(email.toLowerCase())) {
      return false; // Email already exists
    }
    _userDatabase[email.toLowerCase()] = password;
    return true;
  }

  /// Log in user
  /// Returns true if successful
  bool login(String email, String password) {
    final storedPassword = _userDatabase[email.toLowerCase()];
    if (storedPassword != null && storedPassword == password) {
      _loggedInEmail = email.toLowerCase();
      return true;
    }
    return false;
  }

  /// Is a user currently logged in?
  bool get isLoggedIn => _loggedInEmail != null;

  /// Get the email of the current user
  String? get currentUser => _loggedInEmail;

  /// Log out the current user
  void logout() {
    _loggedInEmail = null;
  }

  /// Check if a user exists by email
  bool userExists(String email) => _userDatabase.containsKey(email.toLowerCase());

  /// Get all registered users (for debugging/demo purposes)
  List<String> get allUsers => _userDatabase.keys.toList();

  /// Clear all users and logout (for testing)
  void reset() {
    _userDatabase.clear();
    _loggedInEmail = null;
  }
}