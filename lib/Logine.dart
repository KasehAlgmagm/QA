import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/HomePage.dart';
import 'package:flutter_application_6/my_widget/Email.dart';
import 'package:flutter_application_6/my_widget/password_field.dart';

GlobalKey<FormState> formState = GlobalKey();
GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => Logine();
}

class Logine extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,

      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade800,
              Colors.blue.shade400,
            ],
          ),
        ),
        child: Form(
          key: formState,

          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: constraints.maxHeight * 0.1),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FadeInUp(
                            duration: Duration(milliseconds: 1000),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.02),
                          FadeInUp(
                            duration: Duration(milliseconds: 1300),
                            child: Text(
                              "Welcome To WMS",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: constraints.maxHeight * 0.1),
                            FadeInUp(
                              duration: Duration(milliseconds: 1400),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                        255,
                                        119,
                                        185,
                                        240,
                                      ),
                                      blurRadius: 20,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),

                                child: Column(
                                  children: <Widget>[
                                    EmailField(),
                                    PasswordField(),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.05),
                            /* FadeInUp(
                            duration: Duration(milliseconds: 1500),
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),*/
                            SizedBox(height: constraints.maxHeight * 0.05),
                            FadeInUp(
                              duration: Duration(milliseconds: 1600),
                              child: MaterialButton(
                                onPressed: () {
                                  if (formState.currentState!.validate()) {
                                    formState.currentState!.save();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const MyHomePage(),
                                      ),
                                    );
                                  }
                                },
                                height: 50,
                                minWidth: double.infinity,
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            /*  SizedBox(height: constraints.maxHeight * 0.05),
                          FadeInUp(
                            duration: Duration(milliseconds: 1700),
                            child: Text(
                              "Continue with social media",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.03),
                           Row(
                            children: <Widget>[
                              Expanded(
                                child: FadeInUp(
                                  duration: Duration(milliseconds: 1800),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    height: 50,
                                    color: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Facebook",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: constraints.maxWidth * 0.03),
                              Expanded(
                                child: FadeInUp(
                                  duration: Duration(milliseconds: 1900),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    height: 50,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    color: Colors.black,
                                    child: Center(
                                      child: Text(
                                        "Github",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /* Widget _buildTextField(String hintText, {bool obscureText = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }*/
}
