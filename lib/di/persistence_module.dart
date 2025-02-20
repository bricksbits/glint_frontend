import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract class AppModule {
  @lazySingleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage();

  @preResolve // Very important: Wait for initialization
  Future<EncryptedSharedPreferencesAsync> getEncryptedSharedPreferencesAsync(
      FlutterSecureStorage secureStorage) async {
    // 1. Get the encryption key from secure storage (or generate if first time)
    const encryptionKeyName = 'my_encryption_key'; // Choose a good name
    var encryptionKey = await secureStorage.read(key: encryptionKeyName);

    if (encryptionKey == null) {
      // Generate a new key if it doesn't exist.  Use a strong random key generation method.
      encryptionKey = generateRandomKey(); // Implement this function!
      await secureStorage.write(key: encryptionKeyName, value: encryptionKey);
    }

    // 2. Initialize with the retrieved/generated key.
    await EncryptedSharedPreferencesAsync.initialize(encryptionKey);
    return EncryptedSharedPreferencesAsync.getInstance();
  }

  // Example of a strong random key generation function (you might need a package for this):
  String generateRandomKey() {
    // In a real app, use a secure random key generation method.
    // Consider using the `cryptography` package or similar.
    // This is a placeholder for demonstration.  Don't use this in production!
    return 'a_very_strong_random_key_that_should_be_at_least_32_characters_long'; // Replace this!
  }
}
