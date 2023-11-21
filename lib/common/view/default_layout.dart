import 'package:flutter/material.dart';
import 'package:yakmoya/common/const/colors.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Action? actions;
  const DefaultLayout({
    this.actions,
    this.bottomNavigationBar,
    this.title,
    required this.child,
    this.backgroundColor,
    this.floatingActionButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(context),
      body: SingleChildScrollView(child: child,),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? renderAppBar(BuildContext context) {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: backgroundColor ?? Colors.white,
        elevation: 0,
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Image.asset('assets/icon/back_icon.png',width: 20,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }

}