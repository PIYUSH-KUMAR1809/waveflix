import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waveflix/auth/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(236, 239, 246, 1.0),
        appBar: AppBar(
          title: const Text('WaveFlix'),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: 20.0,
                  ),
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: 20.0,
                  ),
                  child: Text(
                    'Welcome Back! Please enter your details',
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: Color.fromRGBO(153, 153, 153, 1.0),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 20.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.black),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(
                                10.0,
                              ),
                              topRight: Radius.circular(
                                10.0,
                              ),
                              bottomLeft: Radius.circular(
                                10.0,
                              ),
                              bottomRight: Radius.circular(
                                10.0,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: loginController.email,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'This can not be empty';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                            decoration: InputDecoration(
                              icon: const Icon(Icons.email_outlined),
                              hintText: "Enter your email",
                              hintStyle: GoogleFonts.poppins(),
                              filled: true,
                              border: InputBorder.none,
                              fillColor: Color.fromRGBO(236, 239, 246, 1.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.black),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(
                                10.0,
                              ),
                              topRight: Radius.circular(
                                10.0,
                              ),
                              bottomLeft: Radius.circular(
                                10.0,
                              ),
                              bottomRight: Radius.circular(
                                10.0,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            () => TextFormField(
                              controller: loginController.password,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'This can not be empty';
                                }
                                return null;
                              },
                              obscureText: loginController.isObscure.value,
                              onSaved: (value) {},
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(loginController.isObscure.value
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    loginController.updatePasswordStatus();
                                  },
                                ),
                                icon: const Icon(Icons.lock_outline_rounded),
                                hintText: "Enter your password",
                                hintStyle: GoogleFonts.poppins(),
                                filled: true,
                                border: InputBorder.none,
                                fillColor: Color.fromRGBO(236, 239, 246, 1.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 20.0,
                        ),
                        child: Container(
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                10.0,
                              ),
                              topRight: Radius.circular(
                                10.0,
                              ),
                              bottomLeft: Radius.circular(
                                10.0,
                              ),
                              bottomRight: Radius.circular(
                                10.0,
                              ),
                            ),
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(
                                    width: 1,
                                    color: Colors.blue,
                                  )),
                            ),
                            onPressed: () {
                              loginController.login(context);
                            },
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.offAllNamed('/registration');
                    },
                    child: const Text(
                      'New to WaveFlix? Create an account',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
