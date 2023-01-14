import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var a;
  Map? b;

  getData() async {
    Response res = await get(Uri.parse('https://api.ipify.org?format=json'));
    a = jsonDecode(res.body)['ip'];
    Response res2 = await get(Uri.parse('https://ipinfo.io/$a/geo'));
    return b = jsonDecode(res2.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.blue,
          child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              print('???${b}');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.black54,
                ));
              } else {
                return Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(b!['city']),
                    SizedBox.fromSize(
                      size: Size(10, 10),
                    ),Text(b!['ip']),SizedBox.fromSize(size: Size(10, 10),),Text(b!['region'])],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
