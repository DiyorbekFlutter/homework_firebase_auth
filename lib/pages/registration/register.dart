import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'create_account.dart';
import 'login.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    // Future<void> navigatorPop() async => Navigator.pop(context);
    // Future<void> pushAndRemoveUntil() => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
    // Future<void> errorText() async => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nima xato ketdi')));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              width: 280,
              height: 280,
              image: AssetImage('assets/auth.png')
            ),
            const SizedBox(height: 100),
            Row(
              children: [
                Expanded(
                  child: ZoomTapAnimation(
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => const Login())),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                      ),
                      child: const Text("Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ZoomTapAnimation(
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => const CreateAccount())),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                      ),
                      child: const Text("Sign Up",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(child: Divider()),
                SizedBox(width: 10),
                Text('OR'),
                SizedBox(width: 10),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 40),
            ZoomTapAnimation(
              child: ElevatedButton(
                onPressed: () async {
                  // loading(context);
                  // await AuthService.handleSignInWithGoogle(context);
                  // navigatorPop();
                  // if(result) {
                  //   pushAndRemoveUntil();
                  // } else {
                  //   errorText();
                  // }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                  side: const BorderSide(color: Colors.black, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/google_icon.svg', width: 28, height: 28),
                    const SizedBox(width: 10),
                    const Text('Google', style: TextStyle(fontSize: 20, color: Colors.black))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
