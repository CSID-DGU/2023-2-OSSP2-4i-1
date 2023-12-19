import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/user/view/home_screen.dart';
import 'package:yakmoya/user/view/search_screen.dart';

import '../../common/const/tab_item.dart';

class RootTab extends StatefulWidget {
  static String get routeName => '/';
  const RootTab({
    Key? key,
  }) : super(key: key);

  @override
  _RootTabState createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(
      length: tabItems.length,
      vsync: this,
      initialIndex: _currentIndex,
    );
    _tabController.addListener(tabListener);
    super.initState();
  }

  void tabListener() {
    if (_tabController.index != _currentIndex) {
      setState(() {
        _currentIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomeScreen(tabController: _tabController),
          SearchScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_BLUE_COLOR,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
            _tabController.animateTo(index);
          });
        },
        unselectedItemColor: Colors.grey[600], // Set unselected item color
        selectedLabelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        items: tabItems.map((tab) {
          bool isSelected = _currentIndex == tabItems.indexOf(tab);
          return BottomNavigationBarItem(
            icon: isSelected && tab.selectedIconPath != null
                ? SvgPicture.asset(
                    tab.selectedIconPath!,
                    width: 30,
                    height: 30,
                    color: PRIMARY_BLUE_COLOR, // 선택된 아이템의 색상
                  )
                : SvgPicture.asset(
                    tab.iconPath,
                    width: 30,
                    height: 30,
                    color: isSelected
                        ? PRIMARY_BLUE_COLOR
                        : Colors.grey[600], // 선택되지 않은 아이템의 색상
                  ),
            label: tab.label,
          );
        }).toList(),
      ),
    );
  }
}
