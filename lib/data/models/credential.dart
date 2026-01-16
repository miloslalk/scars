class Credential {
  const Credential({required this.username, required this.password});

  final String username;
  final String password;

  factory Credential.fromJson(Map<String, dynamic> json) {
    final username = json['username'];
    final password = json['password'];
    if (username is String && password is String) {
      return Credential(username: username, password: password);
    }
    throw const FormatException('Invalid credential payload');
  }
}
