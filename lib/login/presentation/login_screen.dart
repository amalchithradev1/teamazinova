import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:demofirst/rest/hive_repo.dart';
import 'package:demofirst/routes/app_router.gr.dart';
import 'package:demofirst/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../theme/colors.dart';
import '../../widgets/login_button.dart';
import '../data/login_provider.dart';


@RoutePage()
  class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var _userName = TextEditingController();
  var _password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.blue.shade700,
          toolbarHeight: 0.0
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: const BoxDecoration(
            color: screenBackgroundColor,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0XFF1875D3),
                  backgroundColor
                ]
            )
          ),
          height: MediaQuery.of(context).size.height * 1.5,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(bottom: keyboardHeight),
                child: Column(
                  children: [
                    Gap(80),
                    Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                    Gap(120),
                    TextFormField(
                      controller: _userName,
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: GoogleFonts.poppins(color: Colors.white38, fontSize: 14, fontWeight: FontWeight.w300),
                        prefixIcon: Icon(Iconsax.user, color: Colors.yellow,),
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        counterText: "",
                        filled: true,
                        fillColor: Colors.transparent,
                        border: themeData().inputDecorationTheme.border
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }
                        return null;
                      },
                      onChanged: (v){
                        _userName.text = v.toString();
                      },
                    ),
                    Gap(20),
                    TextFormField(
                      controller: _password,
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                      maxLength: 10,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: GoogleFonts.poppins(color: Colors.white38, fontSize: 14, fontWeight: FontWeight.w300),
                        prefixIcon: Icon(Iconsax.lock, color: Colors.yellow,),
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        prefixIconConstraints: BoxConstraints(minWidth: 50),
                        counterText: "",
                        filled: true,
                        fillColor: Colors.transparent,
                          border: themeData().inputDecorationTheme.border
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }
                        return null;
                      },
                      onChanged: (v){
                        _password.text = v.toString();
                      },
                    ),
                    Gap(40),
                    LoginButton(
                      showActions: false,
                      title: "Sign In",
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          FocusScope.of(context).unfocus();

                          final loginService = ref.read(loginProvider);
                          bool isValid = loginService.validateCredentials(
                            _userName.text,
                            _password.text,
                          );
                          if (isValid) {
                            HiveRepo.instance.setUser(user: "true");
                            context.pushRoute(HomeRoute());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Invalid username or password")),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
