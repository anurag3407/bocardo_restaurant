class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  final Map<String, _Account> _accounts = {};
  _Account? _current;

  String? get restaurantName => _current?.restaurantName;

  Future<void> signIn(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final account = _accounts[email.trim().toLowerCase()];
    if (account == null || account.password != password) {
      throw 'Email or password is incorrect.';
    }
    _current = account;
  }

  Future<void> signUp({
    required String restaurantName,
    required String ownerName,
    required String phone,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final key = email.trim().toLowerCase();
    if (_accounts.containsKey(key)) {
      throw 'An account with this email already exists.';
    }
    final account = _Account(restaurantName.trim(), ownerName.trim(), phone.trim(), password);
    _accounts[key] = account;
    _current = account;
  }

  void signOut() => _current = null;
}

class _Account {
  _Account(this.restaurantName, this.ownerName, this.phone, this.password);
  final String restaurantName;
  final String ownerName;
  final String phone;
  final String password;
}