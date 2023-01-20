import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:interview/data/mock_data.dart';
import 'package:interview/data/user.dart';

class UserListProvider with ChangeNotifier {
  //loading
  bool loading = false;
  bool get isloading => loading;

  //fetch users data
  List<User> _userList = <User>[];
  List get userList => _userList;

  //all predefined users
  getUsers() async {
    _userList = User.fromJsonToList(allData());
  }

  //update list
  addUsers(User user) async {
    loading = true;
    notifyListeners();
    bool exist = checkUserExist(user);
    loading = false;
    notifyListeners();
    if (!exist) {
      _userList.add(user);
      Fluttertoast.showToast(
        msg: "User added Succesfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      loading = false;
      notifyListeners();
      Fluttertoast.showToast(
        msg: "User already exist",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  //check if user exists
  checkUserExist(User user) {
    List name = [];
    for (int i = 0; i < _userList.length; i++) {
      name.add(_userList[i].firstName.toString());
    }
    if (name.contains(user.firstName)) {
      return true;
    } else {
      return false;
    }
  }

  //search  User from list
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  List<User> _searchedClients = [];
  List<User> get searchedClients => _searchedClients;

  searchClient() {
    _searchedClients = _userList
        .where((element) =>
            element.firstName
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            element.lastName
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            element.email
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            element.role
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
        .toList();
    notifyListeners();
  }

  clearText() {
    _searchController.text = "";
    notifyListeners();
  }
}
