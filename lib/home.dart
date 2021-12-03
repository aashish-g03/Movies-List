import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth/signup.dart';
import 'main.dart';

class Home extends StatefulWidget {
  final String? uID;
  Home({this.uID}) {
    uid = uID;
  }
  @override
  State<Home> createState() => _HomeState();
}

String? uid;
const String title = "Home";

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Image.asset(
          'assets/2.jpg',
        ),
        title: const Text('Watched Movies'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((res) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                    (Route<dynamic> route) => false);
              });
            },
          )
        ],
      ),
      body: (movies.isNotEmpty)
          ? ListView.builder(
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 150,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.shade50,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 0.0,
                          blurRadius: 3.0,
                          offset: const Offset(3.0, 3.0)),
                      BoxShadow(
                          color: Colors.grey.shade400,
                          spreadRadius: 0.0,
                          blurRadius: 3.0 / 2.0,
                          offset: const Offset(3.0, 3.0)),
                      const BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2.0,
                          blurRadius: 3.0,
                          offset: Offset(-3.0, -3.0)),
                      const BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2.0,
                          blurRadius: 3.0 / 2,
                          offset: Offset(-3.0, -3.0)),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image(
                          image: poster[index],
                          fit: BoxFit.fill,
                          height: 150,
                          width: 150,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movies[index],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              letterSpacing: 0.10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'By ${director[index]}',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              letterSpacing: 0.10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            movies.removeAt(index);
                            director.removeAt(index);
                            poster.removeAt(index);
                          });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                );
              },
            )
          : const SizedBox(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).push(createRoute());
        },
      ),
    );
  }
}
