import 'package:flutter/material.dart';
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

    UserModel uModel = UserModel();

    uModel.name = name;
    uModel.email = email;
    uModel.mobile = mobileno;
    uModel.password = passwd;
    dbHelper = DbHelper();
    await dbHelper.saveData(uModel).then((userData) {
      print("Successfully Saved");
      /* Navigator.push(
          context, MaterialPageRoute(builder: (_) => const ScreenLogin()));
*/
    }).catchError((error) {
      print("Error: Data Save Fail--$error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
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
    );
  }
}
