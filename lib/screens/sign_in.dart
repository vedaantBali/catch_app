import 'package:catch_app/screens/sign_up.dart';
import 'package:catch_app/services/auth.dart';
import 'package:catch_app/widgets/app_bar_main.dart';
import 'package:flutter/material.dart';

import 'chat_home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  bool isValidLogin = true;

  Auth auth = new Auth();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  signInFunction() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      auth
          .signInWithEmailAndPassword(
              emailController.text, passwordController.text)
          .then((value) {
        if (value != null) {
          isValidLogin = true;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatHome()));
        } else {
          setState(() {
            isValidLogin = false;
          });
        }

        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailController,
                  key: ValueKey('email'),
                  validator: (value) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)
                        ? null
                        : 'Please enter a valid email address.';
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value.length < 7 || value.isEmpty) {
                      return 'Password must be at least 7 characters long.';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Forgot Password?'),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    signInFunction();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.amberAccent.shade200,
                          Colors.amberAccent.shade400,
                        ]),
                        borderRadius: BorderRadius.circular(30)),
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.black87),
                            ),
                          )
                        : Text(
                            'Sign In',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87),
                          ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black87, Colors.black]),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 18, color: Colors.amberAccent),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text('Register now'))
                  ],
                ),
                if (!isValidLogin)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Theme.of(context).errorColor),
                    child: Text(
                      'Please check your credentials',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                if (isValidLogin)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 16, color: Colors.black),
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
