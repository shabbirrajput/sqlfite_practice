import 'package:flutter/material.dart';
import 'package:sqlite_practice/auth/sign_in.dart';
import 'package:sqlite_practice/db/com_helper.dart';
import 'package:sqlite_practice/db/db_helper.dart';
import 'package:sqlite_practice/models/user_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController cPassController = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    String name = nameController.text;
    String email = emailController.text;
    String mobileno = mobileController.text;
    String passwd = passController.text;
    String cpasswd = cPassController.text;

    bool isExist = false;
    if (email.isNotEmpty) {
      await dbHelper.getEmailCheck(email).then((userData) {
        if (userData != null && userData.email != null) {
          isExist = true;
        }
      });
    }

    if (name.isEmpty) {
      alertDialog('Please Enter Name');
    } else if (email.isEmpty) {
      alertDialog('Please Enter Email Address');
    } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      alertDialog('Invalid Email Address');
    } else if (isExist) {
      alertDialog('This Email Address Is Already Exist Please Enter New Email');
    } else if (mobileno.isEmpty) {
      alertDialog('Please Enter Mobile No');
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(mobileno)) {
      alertDialog('Invalid Mobile No');
    } else if (passwd.isEmpty) {
      alertDialog('Please Enter Password');
    } else if (!RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)')
        .hasMatch(passwd)) {
      alertDialog(
          "Please Enter Strong Password\n\nHint : Password must contain Upper/Lower case, number and special character");
    } else if (cpasswd.isEmpty) {
      alertDialog('Please Enter Confirm Password');
    } else if (passwd != cpasswd) {
      alertDialog('Password Mismatch');
    } else {
      UserModel uModel = UserModel();

      uModel.name = name;
      uModel.email = email;
      uModel.mobile = mobileno;
      uModel.password = passwd;
      dbHelper = DbHelper();
      await dbHelper.saveData(uModel).then((userData) {
        print("Successfully Saved");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
      }).catchError((error) {
        print("Error: Data Save Fail--$error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                'Sign Up',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: "Enter Name",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500)),
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
                    hintText: "Enter Email Address",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: mobileController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: "Enter Mobile No",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: "Enter Password",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: cPassController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: "Enter Confirm Password",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    signUp();
                  },
                  child: const Text('Sign Up'))
            ],
          ),
        ),
      ),
    );
  }
}
