import 'package:flutter/material.dart';
import 'package:flash_chat/rwidgets/R_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance; // firebase auth object
  late String email;
  late String password;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD( // this shows a loading screen as the user is registering
        inAsyncCall: loading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible( // this will let the image adjust to fit different screen sizes
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
              TextField(
                keyboardType: TextInputType.emailAddress, // this will show you the @ symbol so you can type email faster
                style: const TextStyle(color: Colors.black87),
                onChanged: (value) {
                  email = value;
                },
                decoration: KTextFieldDecoration.copyWith(
                  hintText: 'Enter your email'
                ) //  the copywith method we are able to say give me a copy of this const but i want to change something.
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(color: Colors.black87),
                onChanged: (value) {
                  password = value;
                },
                decoration: KTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.blueAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: Rbutton(
                      inputGesture: () async{
                        setState(() { // this will start the loading screen animatio
                          loading = true;
                        });
                        try {
                          await _auth.createUserWithEmailAndPassword(email: email, password: password);
                        }
                        catch(error){
                          Alert(context: context, title: "TRY AGAIN", desc: '$error',
                              style: const AlertStyle(backgroundColor: Colors.black87,
                                  isButtonVisible: false, titleStyle: kSendButtonTextStyle,
                                  descStyle: kSendButtonTextStyle)
                          ).show();
                          setState(() {
                            loading = false; // turn off the loading indicator
                          });
                          return;
                        }
                        Navigator.pushNamed(context, '/chatscreen');
                      },
                      inputText: 'Register')
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}