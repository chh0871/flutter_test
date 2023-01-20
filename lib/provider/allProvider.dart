import 'package:interview/provider/userList_Provider.dart';
import 'package:provider/provider.dart';

var allProvider = [
  ChangeNotifierProvider<UserListProvider>(
    create: (_) => UserListProvider(),
    lazy: true,
  ),
];
