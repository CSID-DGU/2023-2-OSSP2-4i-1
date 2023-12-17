import 'package:flutter/material.dart';
import 'package:yakmoya/common/const/colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? name;
  final int? textFieldMinLine;
  final bool? enable;
  final int? maxLines; // 추가
  final bool? expands; // 추가
  final TextAlign textAlign;  // 추가
  final TextAlignVertical textAlignVertical;  // 추가

  const CustomTextFormField({
    this.textAlign = TextAlign.start,  // 기본값을 왼쪽으로 설정
    this.textAlignVertical = TextAlignVertical.top,  // 기본값을 상단으로 설정
    this.enable,
    required this.onChanged,
    this.textFieldMinLine = 1,
    this.autofocus = false,
    this.obscureText = false,
    this.errorText,
    this.hintText,
    this.controller,
    this.name,
    this.maxLines, // 추가
    this.expands, // 추가
    super.key,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool showErrorText = false;

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: BORDER_COLOR,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(6.0),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 14, 6),
      child: TextFormField(
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        enabled: widget.enable ?? true,
        onTap: () {
          setState(() {
            showErrorText = false;
          });
        },
        controller: widget.controller,
        cursorColor: CURSOR_COLOR,
        obscureText: widget.obscureText,
        obscuringCharacter: '●',
        minLines: widget.expands == true ? null : widget.textFieldMinLine, // 수정된 부분
        maxLines: widget.expands == true ? null : (widget.maxLines ?? 1),
        expands: widget.expands ?? false, // 연결
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          fillColor: Colors.white, // 내부 색상을 흰색으로 설정
          filled: true, // 내부 색상을 적용하려면 true로 설정
          contentPadding: EdgeInsets.fromLTRB(14, 12, 14, 12),
          hintText: widget.hintText,
          errorText: widget.errorText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17.0,
            color: Colors.grey[700],
          ),
          border: baseBorder,
          focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(
              color: PRIMARY_BLUE_COLOR,
            ),
          ),
          enabledBorder: baseBorder,
        ),
      ),
    );
  }
}
