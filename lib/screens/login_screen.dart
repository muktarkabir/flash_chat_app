import 'package:flash_chat_app/services/auth/auth_service.dart';
import 'package:flash_chat_app/components/input_text_field.dart';
import 'package:flash_chat_app/components/rounded_button.dart';
import 'package:flash_chat_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const pathName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email, password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              InputTextField(
                  hintText: 'Enter your Email',
                  onChanged: (value) {
                    email = value;
                  }),
              const SizedBox(
                height: 8.0,
              ),
              InputTextField(
                  hintText: 'Enter your Password',
                  onChanged: (value) {
                    password = value;
                  }),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  title: 'Log in',
                  colour: Colors.greenAccent.shade400,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final existingUser =
                          await AuthService.signInWithEmailAndPassword(
                              email.toLowerCase(), password);
                      if (existingUser.user != null) {
                        Navigator.pushNamed(context, HomeScreen.pathName);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                      });
                      print(e);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Something went wrong'),
                              content: Text(e.toString()),
                            );
                          });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
