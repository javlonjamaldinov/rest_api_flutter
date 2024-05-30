// user_provider.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  List<dynamic> _users = [];
  List<dynamic> _filteredUsers = [];

  List<dynamic> get users => _filteredUsers;

  void fetchUsers() async {
    print("fetchUsers called");
    const url = 'https://randomuser.me/api?results=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    _users = json['results'];
    _filteredUsers = _users;
    notifyListeners();
    print("fetchUsers completed");
  }

  void filterUsers(String query) {
    final lowerCaseQuery = query.toLowerCase();
    _filteredUsers = _users.where((user) {
      final name = user['name']['first'].toLowerCase();
      return name.contains(lowerCaseQuery);
    }).toList();
    notifyListeners();
  }
}
