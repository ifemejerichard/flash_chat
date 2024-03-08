import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 return runApp(const FlashChat());
}


class FlashChat extends StatefulWidget {
  const FlashChat({super.key});
  @override
  State<FlashChat> createState() => _FlashChatState();
}
class _FlashChatState extends State<FlashChat> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  getScreen (){
    if (auth.currentUser != null) {
      return ChatScreen();
    }
    else{
      return WelcomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => getScreen(),
        '/loginscreen': (context) => const LoginScreen(),
        '/registrationscreen': (context) => const RegistrationScreen(),
        '/chatscreen': (context) => const ChatScreen(),
      },
    );
  }
}
