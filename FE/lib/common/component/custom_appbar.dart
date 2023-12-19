import 'package:flutter/material.dart';
import 'package:yakmoya/common/const/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
        backgroundColor: PRIMARY_BLUE_COLOR,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 20,),
          onPressed: () {
            Navigator.pop(context);
          },
        )
    );
  }
}
