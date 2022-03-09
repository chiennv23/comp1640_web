import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/reponsive_pages.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/login/controlls/login_controller.dart';
import 'package:comp1640_web/utils/validations.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
    with InputValidationMixin, SingleTickerProviderStateMixin {
  // login
  var emailLoginController = TextEditingController();
  var passLoginController = TextEditingController();

  // sign up
  var emailSignUpController = TextEditingController();
  var userNameSignUpController = TextEditingController();
  var passSignUpController = TextEditingController();
  var verifyPassSignUpController = TextEditingController();

  bool rememberMe = false;
  bool visibility = true;
  bool isLoading = false;
  TabController tabController;

  final formGlobalKey1 = GlobalKey<FormState>();
  final formGlobalKey2 = GlobalKey<FormState>();
  bool hasAutoValidation1 = false;
  bool hasAutoValidation2 = false;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    emailLoginController.text =
        SharedPreferencesHelper.instance.getString(key: 'Email') ?? '';
    rememberMe =
        SharedPreferencesHelper.instance.getBool(key: 'rememberMe') ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (!ResponsiveWidget.isSmallScreen(context))
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text("Feedback System",
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 55, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            Flexible(
              flex: 2,
              child: DefaultTabController(
                length: 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: spaceColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  height: 600,
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 35, left: 24),
                        width: 200,
                        child: TabBar(
                            controller: tabController,
                            onTap: (index) {},
                            unselectedLabelColor: darkColor,
                            labelColor: darkColor,
                            labelStyle: GoogleFonts.roboto(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(32),
                              color: primaryColor,
                            ),
                            indicatorPadding: const EdgeInsets.all(4),
                            tabs: const [
                              Tab(
                                text: 'Sign in',
                              ),
                              Tab(
                                text: 'Sign Up',
                              )
                            ]),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            formLogin(),
                            formSignUp(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formLogin() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: formGlobalKey1,
        autovalidateMode: hasAutoValidation1
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: ListView(
          children: [
            const SizedBox(
              height: 35,
            ),
            TextFormField(
              controller: emailLoginController,
              validator: (email) {
                if (isEmailValid(email)) {
                  return null;
                } else {
                  return 'Enter a valid email address';
                }
              },
              decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "abc@feedback.com",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              obscureText: visibility,
              controller: passLoginController,
              validator: (password) {
                if (isPasswordValid(password)) {
                  return null;
                } else {
                  return 'Enter a valid password';
                }
              },
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        visibility = !visibility;
                      });
                    },
                    icon: Icon(
                      visibility ? Icons.visibility_off : Icons.visibility,
                      color: darkColor,
                      size: 20,
                    ),
                  ),
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value;
                            SharedPreferencesHelper.instance
                                .setBool(key: 'rememberMe', val: value);
                          });
                        }),
                    const CustomText(
                      text: "Remeber Me",
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  hasAutoValidation1 = true;
                  isLoading = true;
                });
                if (!formGlobalKey1.currentState.validate()) {
                  setState(() {
                    isLoading = false;
                  });
                  return;
                }
                print(1111);
                if (rememberMe) {
                  SharedPreferencesHelper.instance
                      .setString(key: 'Email', val: emailLoginController.text);
                } else {
                  SharedPreferencesHelper.instance.removeKey(key: 'Email');
                }
                SharedPreferencesHelper.instance
                    .setBool(key: 'rememberMe', val: rememberMe);
                LoginController.signIn(
                        emailLoginController.text, passLoginController.text)
                    .whenComplete(() => setState(() {
                          isLoading = false;
                          hasAutoValidation1 = false;
                          passLoginController.text = '';
                        }));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: active, borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: isLoading
                    ? SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: spaceColor,
                        ),
                      )
                    : const CustomText(
                        text: "Sign In",
                        color: Colors.white,
                      ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }

  Widget formSignUp() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: formGlobalKey2,
        autovalidateMode: hasAutoValidation2
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: ListView(
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: emailSignUpController,
                    validator: (email) {
                      if (isEmailValid(email)) {
                        return null;
                      } else {
                        return 'Enter a valid email';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "abc@feedback.com",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextFormField(
                    controller: userNameSignUpController,
                    validator: (username) {
                      if (username.isNotEmpty) {
                        return null;
                      } else {
                        return 'Enter a valid username';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "UserName",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              obscureText: true,
              controller: passSignUpController,
              validator: (password) {
                if (isPasswordValid(password)) {
                  return null;
                } else {
                  return 'Enter a valid password';
                }
              },
              decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              obscureText: true,
              controller: verifyPassSignUpController,
              validator: (password) {
                if (passSignUpController.text == password) {
                  return null;
                } else {
                  return 'Password verification failed';
                }
              },
              decoration: InputDecoration(
                  labelText: "VerifyPassword",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(
              height: 35,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  hasAutoValidation2 = true;
                  isLoading = true;
                });
                if (!formGlobalKey2.currentState.validate()) {
                  setState(() {
                    isLoading = false;
                  });
                  return;
                }
                print(1111);
                LoginController.signUp(
                  emailSignUpController.text,
                  userNameSignUpController.text,
                  passSignUpController.text,
                ).whenComplete(() => setState(() {
                      isLoading = false;
                      hasAutoValidation2 = false;
                      passSignUpController.text = '';
                      verifyPassSignUpController.text = '';
                    }));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: active, borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: isLoading
                    ? SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: spaceColor,
                        ),
                      )
                    : const CustomText(
                        text: "Sign Up",
                        color: Colors.white,
                      ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
