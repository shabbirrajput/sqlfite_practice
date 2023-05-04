import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                onPressed: () {},
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
