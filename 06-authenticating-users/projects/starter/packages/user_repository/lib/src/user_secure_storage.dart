import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const String _tokenKey = 'wonder-words-token';
  static const String _usernameKey = 'wonder-words-username';
  static const String _emailKey = 'wonder-words-email';

  const UserSecureStorage({
    FlutterSecureStorage? secureStorage,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

  Future<void> upsertUserInfo({
    required String username,
    required String email,
    String? token,
  }) =>
      Future.wait(
        [
          //username
          _secureStorage.write(
            key: _usernameKey,
            value: username,
          ),
          //email
          _secureStorage.write(
            key: _emailKey,
            value: email,
          ),
          //token if not null
          if (token != null)
            _secureStorage.write(
              key: _tokenKey,
              value: token,
            ),
        ],
      );

  Future<void> deleteUserInfo() => Future.wait(
        [
          _secureStorage.delete(
            key: _usernameKey,
          ),
          _secureStorage.delete(
            key: _emailKey,
          ),
          _secureStorage.delete(
            key: _tokenKey,
          ),

          //Check if there is any other key to be saved , if not , just use this
          // _secureStorage.deleteAll();
        ],
      );

  Future<String?> readUsername() => _secureStorage.read(
        key: _usernameKey,
      );

  Future<String?> readUserEmail() => _secureStorage.read(
        key: _emailKey,
      );

  Future<String?> readUserToken() => _secureStorage.read(
        key: _tokenKey,
      );
}
