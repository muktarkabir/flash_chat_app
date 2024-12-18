import 'package:flash_chat_app/components/rounded_button.dart';
import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flash_chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const pathName = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animationController.forward();

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(animationController);
    // animation =
    //     CurvedAnimation(parent: animationController, curve: Curves.easeOutBack);
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     animationController.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     animationController.forward();
    //   }
    // });
    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 60.0,
                      child: Image(image: AssetImage('images/logo.png')),
                    ),
                  ),
                ),
                SizedBox(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TyperAnimatedText('Flash Chat'),
                        TyperAnimatedText('Message your friends'),
                        TyperAnimatedText('Talk about Stuff'),
                        TyperAnimatedText('All in real time'),
                        TyperAnimatedText('The ultimate Chat App'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                colour: Colors.greenAccent.shade400,
                title: 'Log in',
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.pathName);
                }),
            RoundedButton(
                title: 'Register',
                colour: Colors.green,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const RegistrationScreen();
                  }));
                }),
          ],
        ),
      ),
    );
  }
}
