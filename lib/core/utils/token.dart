import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

Future<void> storeToken(String? token) async {
  try {
    await storage.write(key: 'auth_token', value: token);
  } catch (e) {
    // Handle any errors that might occur during write
    print('Error storing token: $e');
  }
}

Future<String?> getToken() async {
  try {
    return await storage.read(key: 'auth_token');
  } catch (e) {
    // Handle any errors that might occur during read
    print('Error reading token: $e');
    return null;
  }
}
