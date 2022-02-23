import 'package:comp1640_web/modules/login/controlls/login_controller.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.email)),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: passController,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.password)),
            ),
            const SizedBox(
              height: 45,
            ),
            OutlinedButton.icon(
                onPressed: () {
                  LoginController.login(
                      emailController.text, passController.text, context);
                },
                icon: const Icon(
                  Icons.login,
                  size: 18,
                ),
                label: const Text("Login")),
          ],
        )),
      ),
    ));
  }
}
