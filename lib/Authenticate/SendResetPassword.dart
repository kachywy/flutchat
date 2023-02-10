import 'package:flutchat/Authenticate/LoginScreen.dart';
import 'package:flutchat/Authenticate/Methods.dart';
import 'package:flutter/material.dart';

class SendResetPassword extends StatefulWidget {
  const SendResetPassword({super.key});

  @override
  State<SendResetPassword> createState() => _SendResetPasswordState();
}

class _SendResetPasswordState extends State<SendResetPassword> {
  final TextEditingController _email = TextEditingController();
  bool isLoading = false;

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
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                  Image(
                    image: AssetImage('assets/img/logo.png'),
                    height: 150,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "Email", Icons.lock, _email),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  customButton(size),
                  SizedBox(
                    height: size.height / 40,
                  ),
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          SendResetPasswordFunction(_email.text);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginScreen()));
          print("Reset Password sent sucessfully");
        } else {
          print("Please fill form correctly");
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 5.2,
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
            "Reset",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
