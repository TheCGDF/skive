import 'package:flutter/material.dart';
import 'package:skive/storage/storage_client.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) => FlatButton(
          child: Text(accounts[index].remark),
          onPressed: () {},
        ),
        separatorBuilder: (_, __) => Divider(
          color: Colors.black,
          height: 0,
        ),
        itemCount: accounts.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {  },
      ),
    );
  }
}
