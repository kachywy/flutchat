import 'package:flutter/material.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Name"),
      ),
      body: Container(),
      bottomNavigationBar: Container(
        height: size.height / 10,
        width: size.width / 10,
        alignment: Alignment.center,
        child: Container(
          height: size.height / 12,
          width: size.width / 1.1,
          child: Row(children: [
            Container(
              height: size.height / 12,
              width: size.width / 1.5,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {},
            )
          ]),
        ),
      ),
    );
  }
}
