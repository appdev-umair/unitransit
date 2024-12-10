import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/core/utils/scaffold_messenger_service.dart';
import '/theme/app_theme.dart';
import 'core/utils/navigation_service.dart';
import 'core/utils/token.dart';
import 'presentation/screens/authentications/sign_in/sign_in_screen.dart';
import 'presentation/widgets/bottom_navigation_bar.dart';
import 'routes/app_routes.dart';

const storage = FlutterSecureStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final token = await getToken();

  runApp(
    MyApp(
      token: token,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? token;
  MyApp({super.key, this.token});

  final NavigationService _navigationService = NavigationService();
  final ScaffoldMessengerService _scaffoldMessengerService =
      ScaffoldMessengerService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().lightTheme,
      navigatorKey: _navigationService.navigatorKey,
      scaffoldMessengerKey: _scaffoldMessengerService.messengerKey,
      onGenerateRoute: AppRoutes.generateRoute,
      home: token == null ? SignInScreen() : const BottomNavBar(),
    );
  }
}
