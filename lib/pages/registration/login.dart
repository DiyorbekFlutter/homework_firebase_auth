import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homework_firebase_auth/auth_sevice.dart';
import 'package:homework_firebase_auth/pages/home_page.dart';

import '../../loading.dart';
import 'create_account.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool showErrorTextForEmail = false;
  bool showErrorTextForPassword = false;
  String errorTextForEmail = '';
  String errorTextForPassword = '';
  bool inProgress = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        children: [
          const SizedBox(height: 40),
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/auth.png'))),
          ),
          const SizedBox(height: 40),
          TextField(
            onTap: () => setState(() => showErrorTextForEmail = false),
            controller: email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Emailni kiriting',
              prefixIcon: const Icon(Icons.email),
              errorText: showErrorTextForEmail ? errorTextForEmail : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            onTap: () => setState(() => showErrorTextForPassword = false),
            controller: password,
            obscureText: obscurePassword,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'Parol',
              hintText: 'Parolni kiriting',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                highlightColor: Colors.transparent,
                onPressed: () => setState(() => obscurePassword = !obscurePassword),
                icon: Icon(obscurePassword ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash_fill)
              ),
              errorText: showErrorTextForPassword? errorTextForPassword : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  if(inProgress) return;

                  if(email.text.trim().isEmpty){
                    showText("Email kiritilishi shart");
                    return;
                  } else if(!isEmailValid(email.text.trim())){
                    showText("Email noto'g'ri formatda");
                    return;
                  }

                  inProgress = true;
                  setState((){});

                  try{
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text.trim());
                    showText("Parolni tiklash uchun havolani emailingizga yubordik");
                  } catch(e){
                    showText("Xatolik");
                  }

                  inProgress = false;
                  setState((){});
                },
                child: const Text("Forgot Password ?", style: TextStyle(color: Colors.blue))
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if(checkData){
                loading(context);
                setState(() => inProgress = true);
                User? user = await AuthService.login(email.text.trim(), password.text.trim());
                navigatorPop;
                setState(() => inProgress = false);
                if(user != null) pushAndRemoveUntil(user);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            ),
            child: const Text('Login', style: TextStyle(fontSize: 22, color: Colors.white)),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const CreateAccount())),
            child: const Text("Sizda account yo'qmi ?",
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }


  Future<void> get navigatorPop async => Navigator.pop(context);
  Future<void> pushAndRemoveUntil(User user) async => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(user: user)), (route) => false);

  void showText(String text){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text))
    );
  }

  bool get checkData {
    bool check = true;
    if(inProgress) return false;
    if(email.text.trim().isEmpty){
      errorTextForEmail = 'Majburiy maydon';
      showErrorTextForEmail = true;
      check = false;
    }
    if(password.text.trim().isEmpty){
      errorTextForPassword = 'Majburiy maydon';
      showErrorTextForPassword = true;
      check = false;
    }
    if(!isEmailValid(email.text.trim()) && email.text.trim().isNotEmpty){
      errorTextForEmail = "No'to'g'ri formatdagi email";
      showErrorTextForEmail = true;
      check = false;
    }
    if(password.text.trim().length<6 && password.text.trim().isNotEmpty){
      errorTextForPassword = "Eng kamida 6 ta belgi bo'lishi kerak";
      showErrorTextForPassword = true;
      check = false;
    }

    setState((){});
    return check;
  }

  bool isEmailValid(String email) {
    RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([a-z0-9-]+(\.[a-z0-9-]+)*?\.[a-z]{2,}|(\d{1,3}\.){3}\d{1,3})$',
      caseSensitive: false,
      multiLine: false,
    );
    return emailRegex.hasMatch(email);
  }
}

