import 'package:flutter/material.dart';
import 'package:yakmoya/pill/pill_model.dart';

class DetailScreen extends StatelessWidget {
  final Pill pill;

  const DetailScreen({Key? key, required this.pill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 화면 크기를 얻습니다.
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(pill.name),
      ),
      body: Image.asset(
        pill.assetName.toString(),
        width: screenSize.width * 1, // 화면 너비
        height: screenSize.height * 0.24,
        fit: BoxFit.cover,
      ),
    );
  }
}
