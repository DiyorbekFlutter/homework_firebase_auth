import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:homework_firebase_auth/pages/registration/register.dart';

class Onboarding extends StatelessWidget {
  final Color kDarkBlueColor = const Color(0xFF053149);
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: "Ro'yhatdan o'tish",
      onFinish: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => const Register())),
      finishButtonStyle: FinishButtonStyle(backgroundColor: Colors.amber, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      skipTextButton: Text('Skip', style: TextStyle(fontSize: 16, color: kDarkBlueColor, fontWeight: FontWeight.w600)),
      controllerColor: kDarkBlueColor,
      totalPage: 3,
      speed: 1.8,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      background: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          alignment: Alignment.center,
          child: Image.asset('assets/welcome_image.png', height: 350),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          alignment: Alignment.center,
          child: Image.asset('assets/img.png', height: 250),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          alignment: Alignment.center,
          child: Image.asset('assets/auth.png', height: 250),
        ),
      ],
      pageBodies: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Welcome', textAlign: TextAlign.center, style: TextStyle(color: kDarkBlueColor, fontSize: 24.0, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              const Text('Welcome to Quiz Craft!', textAlign: TextAlign.center, style: TextStyle(color: Colors.black26, fontSize: 18.0, fontWeight: FontWeight.w600)),
              const SizedBox(height: 60),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Quiz Craft', textAlign: TextAlign.center, style: TextStyle(color: kDarkBlueColor, fontSize: 24.0, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              const Text("Quiz Craft bilan o'rganish oson", textAlign: TextAlign.center, style: TextStyle(color: Colors.black26, fontSize: 18.0, fontWeight: FontWeight.w600)),
              const SizedBox(height: 60),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Roʻyxatdan oʻtish', textAlign: TextAlign.center, style: TextStyle(color: kDarkBlueColor, fontSize: 24.0, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              const Text("Ilovadan foydalanish uchun ro'yhatdan o'tish kerak", textAlign: TextAlign.center, style: TextStyle(color: Colors.black26, fontSize: 18.0, fontWeight: FontWeight.w600)),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ],
    );
  }
}
