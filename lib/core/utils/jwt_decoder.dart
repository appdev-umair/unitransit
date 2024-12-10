import 'package:jwt_decoder/jwt_decoder.dart';

 getUserRole(String token) async {
  // Decode JWT to get user role
  final decodedToken = JwtDecoder.decode(token);
  return decodedToken['role']; // Replace 'role' with the actual key for role
}
