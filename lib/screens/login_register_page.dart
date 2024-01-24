// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/app_theme.dart';
import '../logic/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';

  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerSmsCode = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool isRegistered = true;
  bool isVerificationSent =
      false; 

  Future<void> signInWithPhoneAndPassword() async {
    try {
      await Auth().signInWithPhoneNumberAndPassword(
        phoneNumber: _controllerPhone.text,
        smsCode: _controllerSmsCode.text,
      );
    } on FirebaseAuthException catch (e) {
      print("Firebase Authentication Error: ${e.code} - ${e.message}");
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> signUpWithPhoneNumberAndPassword() async {
    try {
      await Auth().signUpWithPhoneNumberAndPassword(
        password: _controllerPassword.text,
        phoneNumber: _controllerPhone.text,
        verificationSent: isVerificationSent, 
      );
      if (isVerificationSent) {
        setState(() {
          isRegistered = true;
          isVerificationSent =
              false;
        });
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Authentication Error: ${e.code} - ${e.message}");
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('Авторизація');
  }

  Widget _entryField(
    String title,
    TextEditingController controller, {
    bool isVisible = true,
  }) {
    return Visibility(
      visible: isVisible,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          filled: true,
          fillColor: const Color.fromARGB(192, 255, 255, 255),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 190, 173, 253),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Oops ? $errorMessage');
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: () {
        if (isRegistered) {
          signInWithPhoneAndPassword();
        } else {
          signUpWithPhoneNumberAndPassword();
        }
      },
      child: Text(
        isRegistered ? 'Вхід' : 'Реєстрація',
        style: const TextStyle(color: Color.fromARGB(176, 0, 0, 0)),
      ),
    );
  }

  Widget _registerButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isRegistered = !isRegistered;
          if (isRegistered) {
            isVerificationSent = false;
          }
        });
      },
      child: Text(
        isRegistered ? 'Ще не зареєстрований' : 'Вже маю акаунт',
        style: const TextStyle(color: Color.fromARGB(176, 0, 0, 0)),
      ),
    );
  }

  Widget _confirmButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isVerificationSent =
              true; 
        });
        signUpWithPhoneNumberAndPassword();
      },
      child: const Text(
        'Підтвердити',
        style: TextStyle(color: Color.fromARGB(176, 0, 0, 0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(
      builder: (context, appThemeProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: _title(),
          ),
          body: Container(
            height: double.infinity,
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _entryField('Номер телефону', _controllerPhone),
                const SizedBox(height: 8),
                _entryField('Пароль', _controllerPassword),
                const SizedBox(height: 8),
                _entryField('SMS код', _controllerSmsCode,
                    isVisible: !isRegistered),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _errorMessage(),
                ),
                const SizedBox(height: 8),
                _loginButton(),
                const SizedBox(height: 8),
                _registerButton(),
                const SizedBox(height: 8),
                _confirmButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}



/* class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    username.text = ""; //innitail value of text field
    password.text = "";
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar( 
             title: Text("Icons on TextField"),
             backgroundColor: Colors.deepOrangeAccent,
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column( 
              children: [
                TextField( 
                  controller: username,
                  decoration: InputDecoration( 
                      labelText: "Username",
                      prefixIcon: Icon(Icons.people),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                  )
                ),

                Container(height:20),

                TextField( 
                  controller: password,
                  decoration: InputDecoration( 
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Password",
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                  )
                ),

              ],
            ),
          )
       );
  }

  OutlineInputBorder myinputborder(){ //return type is OutlineInputBorder
    return OutlineInputBorder( //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
          color:Colors.redAccent,
          width: 3,
        )
    );
  }

  OutlineInputBorder myfocusborder(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
          color:Colors.greenAccent,
          width: 3,
        )
    );
  }

  //create a function like this so that you can use it wherever you want
}*/