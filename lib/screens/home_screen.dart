import 'package:flash_chat_app/components/drawer_content.dart';
import 'package:flash_chat_app/components/user_tile.dart';
import 'package:flash_chat_app/screens/chat_page.dart';
import 'package:flash_chat_app/services/auth/auth_service.dart';
import 'package:flash_chat_app/services/databases/user_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const pathName = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: DrawerContent(),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: SizedBox(
          height: kToolbarHeight,
          child: Image.asset(
            'images/logo.png',
            fit: BoxFit.contain,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildUsersList(),
    );
  }

  Widget _buildUsersList() {
    return StreamBuilder(
        stream: UsersDatabase.getUsersStreamAsList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return const Text('Error buillding users list');
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No Users yet'));
            }
          }
          return ListView(
            children: snapshot.data!.map<Widget>((userData) {
              return _buildUserListItem(userData, context);
            }).toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != AuthService.currentUserEmail!) {
      return UserTile(
          text: userData['email'],
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          receiverEmail: userData['email'],
                          receiverId: userData['uid'],
                        )));
          });
    } else {
      return const SizedBox(height: 0, width: 0);
    }
  }
}
