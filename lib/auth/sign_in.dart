import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite_practice/app_config.dart';
import 'package:sqlite_practice/db/com_helper.dart';
import 'package:sqlite_practice/db/db_helper.dart';
import 'package:sqlite_practice/db/navigator_key.dart';
import 'package:sqlite_practice/models/user_model.dart';
import 'package:sqlite_practice/screens/home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var dbHeler;

  @override
  void initState() {
    dbHeler = DbHelper();
    super.initState();
  }

  login() async {
    String email = emailController.text;
    String passwd = passwordController.text;

    if (email.isEmpty) {
      alertDialog("Please Enter Email ID");
    } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      alertDialog("Invalid Email");
    } else if (passwd.isEmpty) {
      alertDialog("Please Enter Password");
    } else if (!RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)')
        .hasMatch(passwd)) {
      alertDialog(
          "Please Enter Strong Password\n\nHint : Password must contain Upper/Lower case, number and special character");
    } else {
      await dbHeler.getLoginUser(email, passwd).then((userData) {
        if (userData != null && userData.email != null) {
          setSP(userData).whenComplete(() {
            print('--------------->LOGIN SUCCEESSFULLL');
            Navigator.pushAndRemoveUntil(
                NavigatorKey.navigatorKey.currentContext!,
                MaterialPageRoute(builder: (_) => const Home()),
                (Route<dynamic> route) => false);
          });
        } else {
          print("Error: User Not Found");
        }
      }).catchError((error) {
        print("Error: Login Fail");
      });
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    sp.setInt(AppConfig.textUserId, user.id!);
    sp.setString("name", user.name!);
    sp.setString("email", user.email!);
    sp.setString("mobileno", user.mobile!);
    sp.setString("password", user.password!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: 'Enter Email Address',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
