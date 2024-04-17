import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> users = [];

  // Get api request
  void fetchUsers() async {
    print('#### Fetch Users Started');
    final url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json["results"];
    });
    print('#### Fetch Users Completed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[500],
        foregroundColor: Colors.white,
        title: Text('Random Users'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: ((context, index) {
            //
            final user = users[index];
            final fname = user["name"]["first"];
            final lname = user["name"]["first"];
            final age = user["dob"]["age"];
            final email = user["email"];
            final imgurl = user["picture"]["thumbnail"];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
              child: Card(
                color: Colors.white,
                elevation: 3,
                child: ListTile(
                  contentPadding: EdgeInsets.all(5),
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        imgurl,
                      )),
                  title: Text(
                    '$fname $lname',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          children: [
                        TextSpan(
                            text: 'age : ',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        TextSpan(text: '$age\n'),
                        TextSpan(
                            text: 'Email : ',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        TextSpan(text: '$email\n')
                      ])),
                ),
              ),
            );
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
