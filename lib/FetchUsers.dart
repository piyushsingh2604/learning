import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning/Api.dart';
import 'package:http/http.dart' as http;

class Fetchusers extends StatefulWidget {
  const Fetchusers({super.key});

  @override
  State<Fetchusers> createState() => _FetchusersState();
}

class _FetchusersState extends State<Fetchusers> {
  List<User> users = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    alluser();
  }

  Future<void> alluser() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/users'));
    if (response.statusCode == 200) {
      final jsondata = jsonDecode(response.body);
      setState(() {
        users = (jsondata['users'] as List)
            .map((data) => User.fromJson(data))
            .toList();
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].name),
          );
        },
      ),
    );
  }
}
