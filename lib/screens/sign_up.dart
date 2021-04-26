import 'package:catch_app/screens/chat_home.dart';
import 'package:catch_app/screens/sign_in.dart';
import 'package:catch_app/services/auth.dart';
import 'package:catch_app/services/database_handler.dart';
import 'package:catch_app/widgets/app_bar_main.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;

  Auth auth = new Auth();

  DatabaseHandler databaseHandler = new DatabaseHandler();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  signUpFunction() {
    if(formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      auth.signUpWithEmailAndPassword(
          emailController.text,
          passwordController.text).then((value) {

            Map<String, String> userMap =
            {'name': usernameController.text,
              'email': emailController.text};

            databaseHandler.uploadUserInfo(userMap);
            
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => ChatHome())
            );
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
          padding: EdgeInsets.symmetric(
              horizontal: 24
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: usernameController,
                  key: ValueKey('username'),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  key: ValueKey('email'),
                  validator: (value) {
                    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value) ? null : 'Please enter a valid email address.';
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
                SizedBox(height: 32,),
                GestureDetector(
                  onTap: () {
                    signUpFunction();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.amberAccent.shade200,
                              Colors.amberAccent.shade400,]
                        ),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: isLoading ? Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.black87)
                        ,),) : Text(
                      'Sign up',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.black87,
                            Colors.black]
                      ),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: isLoading ? Center(
                    child: CircularProgressIndicator(),) :  Text(
                    'Sign up with Google',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.amberAccent
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn())
                          );
                        },
                        child: Text(
                            'Sign in now'
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
