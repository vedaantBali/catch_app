import 'package:catch_app/screens/sign_in.dart';
import 'package:catch_app/screens/sign_up.dart';
import 'package:flutter/material.dart';

class LoginAssist extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'CatchApp',
                style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic
                ),
              ),
              SizedBox(height: 26,),
              GestureDetector(
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
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn())
                  );
                  // isSignUp = false;
                  // goNext();
                },
              ),
              SizedBox(height: 26,),
              GestureDetector(
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
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp())
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

