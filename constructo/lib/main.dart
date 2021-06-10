import 'package:flutter/material.dart';
import 'package:constructo/components/home.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
        accentColor: Colors.amber,
      ),
      home: HomeConstructo()));
}
