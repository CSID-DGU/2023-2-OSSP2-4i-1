import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:yakmoya/common/component/custom_appbar.dart';
import 'package:yakmoya/common/component/custom_dropdown_button.dart';
import 'package:yakmoya/common/component/custom_text_form_field.dart';
import 'package:yakmoya/common/component/login_next_button.dart';
import 'package:yakmoya/common/component/normal_appbar.dart';
import 'package:yakmoya/common/const/text.dart';
import 'package:yakmoya/common/const/type_data.dart';
import 'package:yakmoya/common/view/default_layout.dart';
import 'package:yakmoya/pill/pill_picture/model/pill_search_model.dart';
import 'package:yakmoya/pill/pill_picture/provider/pill_search_provider.dart';
import 'package:yakmoya/pill/pill_picture/view/image_search_results_screen.dart';

import '../../common/const/colors.dart';

class FilteringScreen extends ConsumerStatefulWidget {
  final String form;
  final String shape;
  final String color1;
  final String color2;
  final String text;
  final File image;

  const FilteringScreen({
    Key? key,
    required this.form,
    required this.shape,
    required this.color1,
    required this.color2,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  ConsumerState<FilteringScreen> createState() => _FilteringScreenState();
}

class _FilteringScreenState extends ConsumerState<FilteringScreen> {
  late String selectedFormType;
  late String selectedShapeType;
  late String selectedColorType1;
  late String selectedColorType2;
  late String ocrText;
  late String formExcText;

  TextEditingController ocrTextController = TextEditingController();
  TextEditingController formExcTextController = TextEditingController();

  final formType = formTypes;
  final shapeType = shapeTypes;
  final colorType = colorTypes;

  void checkButtonEnabled() {}

  @override
  void initState() {
    super.initState();
    selectedFormType = widget.form; // 여기에서 widget 프로퍼티에 접근
    selectedShapeType = widget.shape;
    selectedColorType1 = widget.color1;
    selectedColorType2 = widget.color2;
    ocrTextController.text = widget.text;
  }

  // 사용자가 선택한 옵션으로 PillSearchModel 객체를 생성하고 검색을 수행하는 메서드
  void searchPill() async {
    print('검색 시작');

    String finalSelectedFormType = selectedFormType;
    if (selectedFormType == '기타') {
      finalSelectedFormType = formExcTextController.text.trim();
    }

    if (selectedFormType == '알수없음') {
      selectedFormType = "";
    }

    if (selectedShapeType == '알수없음') {
      selectedShapeType = "";
    }

    final PillSearchModel searchModel = PillSearchModel(
      labelForms: selectedFormType,
      labelShapes: selectedShapeType,
      labelColor1: selectedColorType1,
      labelColor2: selectedColorType2, // 필요에 따라 수정
      labelLineBack: "",
      labelLineFront: "",
      labelPrintBack: "",
      labelPrintFront: ocrTextController.text.trim(),
    );

    print(searchModel.labelPrintFront);
    print(searchModel.labelPrintBack);
    ref.read(pillSearchProvider.notifier).searchImage(searchModel);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pillSearchState = ref.watch(pillSearchProvider);
    final searchStatus = pillSearchState.status;
    final searchResponse = pillSearchState.results; // 검색 결과 가져오기

    // 여기에 위젯 구성
    return DefaultLayout(
      backgroundColor: Colors.white,
      title: '알약 필터링',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Image.file(
                    widget.image,
                    height: 155, // 높이 지정 (원하는 대로 조절 가능)
                    width: 155, // 너비 지정 (원하는 대로 조절 가능)
                  ),
                ),
              ),
              Column(
                children: [
                  FilteringAskLabel(text: '올바른 제형을 선택해 주세요!'),
                  CustomDropdownButton(
                    dropdownWidth: 120,
                    items: formTypes,
                    hintText: selectedFormType,
                    onItemSelected: (value) {
                      setState(
                        () {
                          selectedFormType = value;
                        },
                      );
                      checkButtonEnabled();
                    },
                  ),
                ],
              ),
              FilteringAskLabel(text: '제형이 기타일 경우'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: CustomTextFormField(
                  controller: formExcTextController,
                  onChanged: (value) {},
                ),
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 0.5,
              ),
              FilteringAskLabel(text: '올바른 모양을 선택해 주세요!'),
              CustomDropdownButton(
                dropdownWidth: 120,
                items: shapeType,
                hintText: selectedShapeType,
                onItemSelected: (value) {
                  setState(
                    () {
                      selectedShapeType = value;
                    },
                  );
                  checkButtonEnabled();
                },
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 0.5,
              ),
              FilteringAskLabel(text: '올바른 색상들을 선택해 주세요!'),
              CustomDropdownButton(
                dropdownWidth: 120,
                items: colorTypes,
                hintText: selectedColorType1,
                onItemSelected: (value) {
                  setState(
                    () {
                      selectedColorType1 = value;
                    },
                  );
                  checkButtonEnabled();
                },
              ),
              FilteringAskLabel(text: '(경질 캡슐일 경우 색상이 2개입니다)'),
              CustomDropdownButton(
                dropdownWidth: 120,
                items: colorTypes,
                hintText: selectedColorType2,
                onItemSelected: (value) {
                  setState(
                    () {
                      selectedColorType2 = value;
                    },
                  );
                  checkButtonEnabled();
                },
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 0.5,
              ),
              FilteringAskLabel(text: '식별된 문자를 정확히 입력해 주세요!'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: CustomTextFormField(
                  controller: ocrTextController,
                  onChanged: (value) {},
                ),
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 0.5,
              ),
              SizedBox(
                height: 100,
              ),
              LoginNextButton(
                onPressed: searchPill, // searchPill 메서드 호출
                buttonName: '검색 시작',
                isButtonEnabled: true,
                color: SUB_BLUE_COLOR,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilteringAskLabel extends StatelessWidget {
  final String text;
  const FilteringAskLabel({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 30,
      child: Center(
        child: Text(
          text,
          style: customTextStyle,
          maxLines: 2,
        ),
      ),
    );
  }
}
