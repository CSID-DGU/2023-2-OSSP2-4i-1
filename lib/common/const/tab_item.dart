
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TabItem {
  final String label;
  final String iconPath;
  final String? selectedIconPath;

  const TabItem({
    required this.label,
    required this.iconPath,
    this.selectedIconPath,
  });

  Widget icon({bool isSelected = false}) {
    final path = isSelected && selectedIconPath != null ? selectedIconPath : iconPath;
    return SvgPicture.asset(
      path!,
      height: 30.0, // 또는 원하는 크기
    );
  }
}

const List<TabItem> tabItems = [
  TabItem(
    label: '홈',
    iconPath: 'assets/tab/home1.svg',
    selectedIconPath: 'assets/tab/home2.svg',
  ),
  TabItem(
    label: '검색',
    iconPath: 'assets/tab/search1.svg',
    selectedIconPath: 'assets/tab/search2.svg',
  ),
];