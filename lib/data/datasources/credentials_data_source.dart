import '../models/credential.dart';

abstract class CredentialsDataSource {
  Future<List<Credential>> fetchCredentials();
}
