import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homework_firebase_auth/auth_sevice.dart';
import 'package:homework_firebase_auth/network_service.dart';
import 'package:homework_firebase_auth/pages/home_page.dart';

import '../../loading.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}
class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  bool showErrorTextForEmail = false;
  bool showErrorTextForConfirmPassword = false;
  bool showErrorTextForPassword = false;
  String errorTextForEmail = '';
  String errorTextForPassword = '';
  String errorTextForConfirmPassword = '';
  bool inProgress = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create account', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        children: [
          const SizedBox(height: 100),
          TextField(
            onTap: () => setState(() => showErrorTextForEmail = false),
            controller: email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Email kiriting',
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
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                labelText: 'Parol',
                hintText: 'Parol kiriting',
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
          const SizedBox(height: 10),
          TextField(
            onTap: () => setState(() => showErrorTextForConfirmPassword= false),
            controller: confirmPassword,
            obscureText: obscureConfirmPassword,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'Parolni tasdiqlash',
              hintText: 'Parolni qayta kiting',
              prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                    highlightColor: Colors.transparent,
                    onPressed: () => setState(() => obscureConfirmPassword = !obscureConfirmPassword),
                    icon: Icon(obscureConfirmPassword ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash_fill)
                ),
              errorText: showErrorTextForConfirmPassword? errorTextForConfirmPassword : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if(checkData){
                loading(context);
                setState(() => inProgress = true);
                User? user = await AuthService.createAccount(fullName: "Diyorbek/Qurbonov", email: email.text.trim(), password: password.text.trim());
                navigatorPop;
                setState(() => inProgress = false);
                if(user != null) {
                  await ClientService.post({
                    "email": user.email,
                    "uid": user.uid
                  });
                  pushAndRemoveUntil(user);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            ),
            child: const Text('Account ochish', style: TextStyle(fontSize: 22, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> get navigatorPop async => Navigator.pop(context);
  Future<void> pushAndRemoveUntil(user) async => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(user: user)), (route) => false);

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
    if(confirmPassword.text.trim().isEmpty){
      errorTextForConfirmPassword = 'Majburiy maydon';
      showErrorTextForConfirmPassword = true;
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
    if(confirmPassword.text.trim() != password.text.trim() && confirmPassword.text.trim().isNotEmpty){
      errorTextForConfirmPassword= "Parol tasdiqlanmadi";
      showErrorTextForConfirmPassword = true;
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
