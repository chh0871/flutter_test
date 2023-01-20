// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:interview/data/user.dart';
import 'package:interview/provider/userList_Provider.dart';
import 'package:interview/widgets/avatar_widget.dart';
import 'package:interview/widgets/userTile.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final searchController = TextEditingController();
  var users;
  late UserListProvider userListProvider;
  @override
  void initState() {
    super.initState();
    userListProvider = Provider.of<UserListProvider>(context, listen: false);
    userListProvider.getUsers();
    searchController.addListener(_filterList);
  }

  @override
  void dispose() {
    super.dispose();
    userListProvider.searchController.clear();
    userListProvider.searchController.text = "";
  }

  _filterList() {}
  @override
  Widget build(BuildContext context) {
    _getUserAvatar(url) {
      return CircleAvatar(backgroundImage: NetworkImage(url));
    }

    return Consumer<UserListProvider>(builder: (context, userlist, _) {
      return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.title)),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    userlist.searchClient();
                  },
                  controller: userlist.searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            userlist.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : userlist.userList == null
                    ? Center(
                        child: Text("No Users Availabkle"),
                      )
                    : userlist.searchController.text.isEmpty
                        ? Flexible(
                            child: ListView.builder(
                              itemCount: userlist.userList.length == null
                                  ? 0
                                  : userlist.userList.length,
                              itemBuilder: (context, index) {
                                // final item = users[index];
                                return UserListTile(
                                    userlist.userList[index].avatar == null
                                        ? "null"
                                        : userlist.userList[index].avatar,
                                    userlist.userList[index].firstName,
                                    userlist.userList[index].lastName,
                                    userlist.userList[index].role);
                              },
                            ),
                          )
                        : Flexible(
                            child: ListView.builder(
                              itemCount: userlist.searchedClients.length == null
                                  ? 0
                                  : userlist.searchedClients.length,
                              itemBuilder: (context, index) {
                                // final item = users[index];

                                return UserListTile(
                                    userlist.searchedClients[index].avatar ==
                                            null
                                        ? "null"
                                        : userlist
                                            .searchedClients[index].avatar!,
                                    userlist.searchedClients[index].firstName,
                                    userlist.searchedClients[index].lastName,
                                    userlist.searchedClients[index].role);
                              },
                            ),
                          ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var newUser = User(
                id: "b32ec56c-21bb-4b7b-a3a0-635b8bca1f9d",
                avatar: null,
                firstName: "James",
                lastName: "May",
                email: "ssaull1c@tripod.com",
                role: "Developer");
            userlist.addUsers(newUser);
          },
          tooltip: 'Add new',
          child: Icon(Icons.add),
        ),
      );
    });
  }
}
