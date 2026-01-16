import '../models/credential.dart';

abstract class AuthRepository {
  Future<List<Credential>> fetchCredentials();
}
