import 'package:catch_app/services/database_handler.dart';
import 'package:catch_app/widgets/app_bar_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchController = new TextEditingController();

  DatabaseHandler databaseHandler = new DatabaseHandler();

  QuerySnapshot querySnapshot;


  initiateSearch() {

    databaseHandler.getUserByUsername(searchController.text).then((val) {

     setState(() {
       querySnapshot = val;
     });
    });

  }

  // createChatRoomNow(String username) {
  //   List<String> users = [username, myusername];
  //   databaseHandler.createChatRoom(chatRoomId, chatRoomMap)
  // }

  Widget searchList() {
    return querySnapshot != null ? ListView.builder(
        itemCount: querySnapshot.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SearchResult(
            username: querySnapshot.docs[index]['name'],
            email: querySnapshot.docs[index]['email'],
          );
        }) :
    Text('Nothing Found');


  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: searchController,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: 'Enter username to search',
                      hintStyle: TextStyle(color: Colors.black87),
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          gradient: LinearGradient(
                            colors: [
                              Colors.amberAccent,
                              Colors.amberAccent
                            ]
                          )
                        ),
                        child:Icon(Icons.search)),
                  )
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

class SearchResult extends StatelessWidget {

  final String username;
  final String email;

  SearchResult({this.username, this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  username,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
              ),
              SizedBox(height: 4,),
              Text(
                  email,
                  style: TextStyle(
                    color: Colors.black54
                  ),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {

            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                color: Colors.amberAccent
              ),
              child: Text(
                'Catch up',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
