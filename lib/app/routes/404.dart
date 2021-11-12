/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-25 11:03:27
 * @LastEditors: saphir
 * @LastEditTime: 2021-04-27 15:29:26
 */
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("Page does not exist"),
      ),
      body: Center(
        child: Text(
          'Sorry, the page has moved~',
          style: TextStyle(fontSize: 26.0),
        ),
      ),
    );
  }
}
