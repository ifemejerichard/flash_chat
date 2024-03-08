import 'package:flutter/material.dart';
import 'package:flash_chat/rwidgets/R_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  // to understand what override, extends and surper keywords mean watch the video on mixins
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  // the 'singletickerprovidermixin' enables the welcomescreenstate to act as the ticker, there by adding an extra functionality to the welcomescreenstate
  // the ticker is the one one that flips the animation to the next frame thereby calling setstate to keep track of the current frame as
  // the animation moves forward or backward
  // if we had multiple animation we will use 'tickerproviderestatemixin'.

  late AnimationController controller;
  late CurvedAnimation animation;
  late double num = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this,
      duration: const Duration(seconds: 5)
    );
    // the 'this' means that the tickerprovider which vsync requires is the current state (welcomescreenstate)
    // which has become a tickerprovider by adding the 'singletickerprovidermixin'
    // and the duration means how long the animation would last

    animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);

    controller.forward(); // this tells the animation to move forward
    //controller.reverse(from: 1); // this will reverse the animation process
    // to use a different animation in reverse you have to specify it in the curved animation property

      // animation.addStatusListener((status) { // this will make the animation repeat non stop
      //   print(status);
      //   if (status == AnimationStatus.completed){
      //     controller.reverse(from: 1);
      //   }
      //   else if (status == AnimationStatus.dismissed){
      //     controller.forward();
      //   }
      // });

    controller.addListener(() {// this listens to the ticker as it flips from frame to frame and it take a callback as input (anonymous function)
      setState(() {
        num = animation.value;
        //num = controller.value;
        // this is what is being animated and it starts from whatever the lowerbound is to what the upperbound is
        // but its default value is 0 to 1
      });
      print(controller.value); // you can see that with controller.value the animation is linear
    });
  }

  @override
  void dispose() {
    // this is one of the methods is a stateful widget that will destroy anything inside it was this screen is changed
    // we need to do this for animations because the continue working in the background which cost ram space
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(num),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero( // this animation widget animates an element that is on both screens in the app
                  tag: 'logo',
                  child: SizedBox(
                    height: (num*100),
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                Text(
                  'Flash ${(num*60).toInt()}%',
                  style: const TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900, color: Colors.black87
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: Rbutton(
                    inputGesture: () {Navigator.pushNamed(context, '/loginscreen');},
                    inputText: 'Log in'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: Rbutton(
                    inputGesture: () {Navigator.pushNamed(context, '/registrationscreen');
                      },
                    inputText: 'Register'),
              ),
            ),

            SizedBox(
              width: 250.0,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontFamily: 'Bobbers',
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('Welcome to Flash Chat'),
                  ],
                  onTap: () {
                      print("Tap Event");
                    },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// tween animations are used to transition from one variable to another be it colour, widget and so on

