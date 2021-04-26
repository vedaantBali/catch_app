import 'package:catch_app/assist/login_assist.dart';
import 'package:catch_app/screens/search.dart';
import 'package:catch_app/services/auth.dart';
import 'package:flutter/material.dart';

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {

  Auth auth = new Auth();

  void _select(String value) {
    switch(value) {
      case 'Profile':

        break;
      case 'Exit':
        auth.signOut();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginAssist()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CatchApp',
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              auth.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginAssist()));
            },
            child: Row(
              children: [
                PopupMenuButton(
                  onSelected: _select,
                  itemBuilder: (BuildContext context) {
                    return {'Profile','Exit'}.map((String choice) {
                      return PopupMenuItem(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                )
                // Container(
                //     padding: EdgeInsets.only(right: 16),
                //     child: Icon(Icons.exit_to_app_outlined)
                // ),
              ]
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
    );
  }
}
