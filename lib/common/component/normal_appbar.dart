import 'package:flutter/material.dart';

class NormalAppbar extends StatelessWidget implements PreferredSizeWidget{
  final Color? color;
  final String? title;
  final bool? automaticallyImplyLeading;
  const NormalAppbar({this.color, this.automaticallyImplyLeading, this.title, super.key});

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: this.automaticallyImplyLeading ?? false,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title!,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      foregroundColor: Colors.black,
    );
  }
}
