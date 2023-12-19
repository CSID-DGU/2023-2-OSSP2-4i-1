import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:yakmoya/common/const/colors.dart';


class CustomDropdownButton extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final Function(String) onItemSelected;
  final EdgeInsets padding;
  // 새로운 속성들
  final bool enabled;
  final String? errorText;
  final double? dropdownWidth;

  const CustomDropdownButton({
    this.dropdownWidth,
    Key? key,
    this.enabled = true,
    this.errorText,
    required this.items,
    required this.hintText,
    required this.onItemSelected,
    this.padding = const EdgeInsets.only(top: 2, right: 14),
  }) : super(key: key);

  @override
  CustomDropdownButtonState createState() => CustomDropdownButtonState();
}

class CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? selectedItem;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  late double _dropdownWidth;
  static const double _dropdownHeight = 48;

  @override
  void initState() {
    super.initState();
    _dropdownWidth = widget.dropdownWidth ?? 360;
    selectedItem = widget.hintText;
  }

  // 드롭다운을 닫는 public 메서드
  void closeDropdown() {
    _removeOverlay();
  }

  @override
  void dispose() {
    _overlayEntry?.dispose();
    super.dispose();
  }

  OverlayEntry _customDropdown() {
    return OverlayEntry(
      maintainState: true,
      builder: (context) {
        return Stack(
          children: [
            // 전체 화면을 커버하는 GestureDetector
            Positioned.fill(
              child: GestureDetector(
                onTap: _removeOverlay,
                behavior: HitTestBehavior.translucent,
              ),
            ),
            // 드롭다운 메뉴
            CompositedTransformFollower(
              link: _layerLink,
              offset: const Offset(0, _dropdownHeight),
              child: Material(
                color: Colors.white,
                child: Container(
                  // width: _dropdownWidth,
                  width: _dropdownWidth,
                  height: min(240.0, (22.0 * widget.items.length) + (21 * (widget.items.length - 1)) + 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: BORDER_COLOR),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: widget.items.length,
                    itemBuilder: (context, index) {
                      return CupertinoButton(
                        padding: const EdgeInsets.symmetric(horizontal: 14,),
                        pressedOpacity: 1,
                        minSize: 0,
                        onPressed: () {
                          setState(() {
                            selectedItem = widget.items.elementAt(index);
                            widget.onItemSelected(selectedItem!);
                          });
                          _removeOverlay();
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.items.elementAt(index),
                            style: const TextStyle(
                              fontSize: 16,
                              height: 22 / 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(
                          color: Colors.grey,
                          height: 20,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _createOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _customDropdown();
      Overlay.of(context)?.insert(_overlayEntry!);
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _removeOverlay(),
      child: InkWell(
        onTap: () => _createOverlay(),
        child: CompositedTransformTarget(
          link: _layerLink,
          child: Padding(
            padding: widget.padding,
            child: Container(
              width: _dropdownWidth,
              height: _dropdownHeight,
              padding: EdgeInsets.only(left: 6),
              decoration: BoxDecoration(
                border: Border.all(color: BORDER_COLOR),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 선택값.
                  Text(
                    selectedItem!,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 22 / 16,
                      color: Colors.black,
                    ),
                  ),
                  // 아이콘.
                  const Icon(
                    Icons.arrow_drop_down,
                    size: 36,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



