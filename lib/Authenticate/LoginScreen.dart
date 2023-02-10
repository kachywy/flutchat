import 'package:flutchat/Authenticate/CreateAccount.dart';
import 'package:flutchat/Authenticate/SendResetPassword.dart';
import 'package:flutchat/Screens/HomeScreen.dart';
import 'package:flutchat/Authenticate/Methods.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formfield = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool passToggle = true;
  bool isLoading = false;
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formfield,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 20,
                    ),
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   width: size.width / 0.5,
                    //   child: IconButton(
                    //       icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
                    // ),
                    SizedBox(
                      height: size.height / 10,
                    ),
                    Image(
                      image: AssetImage('assets/img/logo.png'),
                      height: 150,
                    ),

                    SizedBox(
                      height: size.height / 30,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _email,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: validateEmail,
                      ),
                    ),

                    SizedBox(
                      height: size.height / 30,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        obscureText: passwordVisible,
                        controller: _password,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password";
                          } else if (_password.text.length < 6) {
                            return "Password should be 6 or more characters";
                          }
                          return null;
                        },
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 18.0),
                    //   child: Container(
                    //     width: size.width,
                    //     alignment: Alignment.center,
                    //     child: field(
                    //         size, "Password", Icons.lock, _password, true),
                    //   ),
                    // ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => SendResetPassword())),
                      child: Text("Forgot Password?",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                          textAlign: TextAlign.left),
                    ),

                    SizedBox(
                      height: size.height / 50,
                    ),
                    customButton(size),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => CreateAccount())),
                        child: Text(
                          "Don't have an account? Sign up here!",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 40,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_formfield.currentState!.validate()) {
          if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
            setState(() {
              isLoading = true;
            });

            logIn(_email.text, _password.text).then((user) {
              if (user != null) {
                print("Login Sucessful");
                setState(() {
                  isLoading = false;
                });
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              } else {
                setState(() {
                  isLoading = false;
                });
              }
            });
          } else {
            print("Please fill form correctly");
          }
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), //shadow color
                spreadRadius: 2, // spread radius
                blurRadius: 5, // shadow blur radius
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'SFPro',
            ),
          )),
    );
  }

  // Widget field(
  //     Size size, String hintText, IconData icon, TextEditingController cont) {
  //   return Container(
  //     height: size.height / 14,
  //     width: size.width / 1.1,
  //     child: TextField(
  //       controller: cont,
  //       decoration: InputDecoration(
  //         prefixIcon: Icon(icon),
  //         hintText: hintText,
  //         hintStyle: TextStyle(color: Colors.grey),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  if (value!.isNotEmpty && !regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  if (value!.isEmpty) {
    return "Enter Email";
  }

  return null;
}
