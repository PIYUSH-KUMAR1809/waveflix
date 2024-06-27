import 'dart:core';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waveflix/auth/controller/registration_controller.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

//TODO: Icons for form fields
class _RegistrationScreenState extends State<RegistrationScreen> {
  RegistrationController registrationController =
      Get.put(RegistrationController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();

  @override
  void dispose() {
    // Dispose FocusNodes
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(236, 239, 246, 1.0),
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
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: 20.0,
                  ),
                  child: Text(
                    'Create an account',
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: 20.0,
                  ),
                  child: Text(
                    'Welcome! Please enter your details',
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: const Color.fromRGBO(153, 153, 153, 1.0),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                            bottom: 20.0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              registrationController.pickImage();
                            },
                            child: CircleAvatar(
                              radius: 40.0,
                              backgroundColor: Colors.grey,
                              foregroundImage: registrationController
                                          .selectedImagePath.value !=
                                      ''
                                  ? FileImage(
                                      File(registrationController
                                          .selectedImagePath.value),
                                    ) as ImageProvider
                                  : null,
                            ),
                          ),
                        ),
                      ),
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
                            controller: registrationController.name,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Name can not be empty';
                              }
                              return null;
                            },
                            focusNode: _focusNode1,
                            onFieldSubmitted: (_) {
                              _fieldFocusChange(
                                  context, _focusNode1, _focusNode2);
                            },
                            onSaved: (value) {},
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z.]')),
                            ],
                            decoration: InputDecoration(
                              icon: const Icon(Icons.person),
                              hintText: "Name",
                              hintStyle: GoogleFonts.poppins(),
                              filled: true,
                              border: InputBorder.none,
                              fillColor:
                                  const Color.fromRGBO(236, 239, 246, 1.0),
                            ),
                          ),
                        ),
                      ),
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
                            controller: registrationController.phoneNumber,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Phone number can not be empty';
                              }
                              if (value.length < 10) {
                                return 'Phone number needs 10 digits';
                              }
                              if (value.length > 10) {
                                return 'Phone number can only be 10 digits';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                            focusNode: _focusNode2,
                            onFieldSubmitted: (_) {
                              _fieldFocusChange(
                                  context, _focusNode2, _focusNode3);
                            },
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              icon: const Icon(Icons.call),
                              hintText: "Phone number",
                              hintStyle: GoogleFonts.poppins(),
                              filled: true,
                              border: InputBorder.none,
                              fillColor:
                                  const Color.fromRGBO(236, 239, 246, 1.0),
                            ),
                          ),
                        ),
                      ),
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
                            controller: registrationController.email,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email can not be empty';
                              }
                              if (!EmailValidator.validate(
                                  registrationController.email.text)) {
                                return 'Invalid email';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {},
                            focusNode: _focusNode3,
                            onFieldSubmitted: (_) {
                              _fieldFocusChange(
                                  context, _focusNode3, _focusNode4);
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r"\s")),
                            ],
                            decoration: InputDecoration(
                              icon: const Icon(Icons.email_outlined),
                              hintText: "Email",
                              hintStyle: GoogleFonts.poppins(),
                              filled: true,
                              border: InputBorder.none,
                              fillColor:
                                  const Color.fromRGBO(236, 239, 246, 1.0),
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
                              controller: registrationController.password,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Password can not be empty';
                                }
                                if (value.length < 8) {
                                  return 'Password should be of minimum length 8';
                                }
                                return null;
                              },
                              obscureText: registrationController
                                  .isObscurePassword.value,
                              onSaved: (value) {},
                              focusNode: _focusNode4,
                              onFieldSubmitted: (_) {
                                _fieldFocusChange(
                                    context, _focusNode4, _focusNode5);
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(r"\s")),
                              ],
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(registrationController
                                          .isObscurePassword.value
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    registrationController
                                        .updatePasswordStatus();
                                  },
                                ),
                                icon: const Icon(Icons.lock_outline_rounded),
                                hintText: "Password",
                                hintStyle: GoogleFonts.poppins(),
                                filled: true,
                                border: InputBorder.none,
                                fillColor:
                                    const Color.fromRGBO(236, 239, 246, 1.0),
                              ),
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
                              controller:
                                  registrationController.confirmPassword,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Password can not be empty';
                                }
                                if (value.length < 8) {
                                  return 'Password should be of minimum length 8';
                                }
                                return null;
                              },
                              obscureText: registrationController
                                  .isObscureConfirmPassword.value,
                              onSaved: (value) {},
                              focusNode: _focusNode5,
                              onFieldSubmitted: (_) {
                                _focusNode5.unfocus();
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(r"\s")),
                              ],
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    registrationController
                                            .isObscureConfirmPassword.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    registrationController
                                        .updateConfirmPasswordStatus();
                                  },
                                ),
                                icon: const Icon(Icons.lock_outline_rounded),
                                hintText: "Confirm Password",
                                hintStyle: GoogleFonts.poppins(),
                                filled: true,
                                border: InputBorder.none,
                                fillColor:
                                    const Color.fromRGBO(236, 239, 246, 1.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
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
                              _formKey.currentState!.validate();
                              if (registrationController.password.text !=
                                  registrationController.confirmPassword.text) {
                                Get.closeAllSnackbars();
                                Get.snackbar(
                                  'Error Occurred',
                                  'Password do not match',
                                  duration: const Duration(seconds: 1),
                                );
                                return;
                              }
                              if (registrationController
                                      .selectedImagePath.value ==
                                  '') {
                                Get.closeAllSnackbars();
                                Get.snackbar(
                                  'Error Occurred',
                                  'Upload profile photo',
                                  duration: const Duration(seconds: 1),
                                );
                                return;
                              }
                              _formKey.currentState!.save();
                              registrationController.registration(context);
                            },
                            child: Text(
                              'Register',
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
                      Get.offAllNamed('/login');
                    },
                    child: const Text(
                      'Already have an account? Login',
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
