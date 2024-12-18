import 'package:flash_chat_app/services/auth/auth_gate.dart';
import 'package:flash_chat_app/screens/home_screen.dart';
import 'package:flash_chat_app/screens/settings_page.dart';
import 'package:flash_chat_app/themes/dark_mode.dart';
import 'package:flash_chat_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_app/screens/welcome_screen.dart';
import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flash_chat_app/screens/registration_screen.dart';
import 'package:flash_chat_app/screens/group_chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const FlashChat(),
  ));
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AuthGate.pathName,
      routes: {
        AuthGate.pathName: (context) => const AuthGate(),
        WelcomeScreen.pathName: (context) => const WelcomeScreen(),
        LoginScreen.pathName: (context) => const LoginScreen(),
        RegistrationScreen.pathName: (context) => const RegistrationScreen(),
        GroupChatPage.pathName: (context) => const GroupChatPage(),
        HomeScreen.pathName: (context) => const HomeScreen(),
        SettingsPage.pathName: (context) => const SettingsPage(),
      },
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
