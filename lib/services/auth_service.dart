import '../data/models/credential.dart';
import '../data/repositories/auth_repository.dart';

class AuthService {
  AuthService({required this.repository});

  final AuthRepository repository;
  List<Credential> _cache = [];
  bool _loaded = false;

  Future<List<Credential>> loadCredentials() async {
    if (_loaded) {
      return _cache;
    }
    _cache = await repository.fetchCredentials();
    _loaded = true;
    return _cache;
  }

  Future<bool> login(String username, String password) async {
    if (!_loaded) {
      await loadCredentials();
    }
    return _cache.any(
      (credential) =>
          credential.username == username && credential.password == password,
    );
  }

  void resetCache() {
    _cache = [];
    _loaded = false;
  }
}
