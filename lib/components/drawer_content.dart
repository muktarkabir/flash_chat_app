import 'package:flash_chat_app/screens/group_chat_screen.dart';
import 'package:flash_chat_app/services/auth/auth_service.dart';
import 'package:flash_chat_app/screens/settings_page.dart';
import 'package:flash_chat_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Center(
                  child: DrawerHeader(
                      child: Image.asset(
                'images/logo.png',
                color: Theme.of(context).colorScheme.primary,
              ))),
              Text(
                AuthService.getCurrentUserEmail()!,
                style: const TextStyle(fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  title: const Text('H O M E'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('S E T T I N G S'),
                  onTap: () =>
                      Navigator.popAndPushNamed(context, SettingsPage.pathName),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text('G R O U P C H A T'),
                  onTap: () =>
                      Navigator.popAndPushNamed(context, GroupChatPage.pathName),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('L O G O U T '),
              onTap: () {
                AuthService.signOut();
                context.mounted
                    ? Navigator.popAndPushNamed(context, WelcomeScreen.pathName)
                    : null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
