import 'package:flutter/material.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/common/view/default_layout.dart';
import 'package:yakmoya/pill/pill_data.dart';
import 'package:yakmoya/pill/pill_model.dart';
import 'package:yakmoya/user/view/home_screen.dart';
import 'package:yakmoya/user/view/search_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController editingController = TextEditingController();

  // final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  // var items = <String>[];

  late List<Pill> pills;

  String query = '';

  @override
  void initState() {
    super.initState();
    pills = allPills;
  }

  void searchPill(String query) {
    setState(() { // UI를 새로고침하기 위해 setState 호출
      this.query = query;
      pills = allPills.where((pill) {
        final titleLower = pill.name.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
      }).toList();
    });
  }


  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    query = query;
    pills = pills;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '이름으로 추가',
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                searchPill(value);
              },
              controller: editingController,
              cursorColor: PRIMARY_BLUE_COLOR, // 커서 색상 변경
              decoration: const InputDecoration(
                hintText: "약 이름을 입력해주세요!",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  // 포커스 됐을 때의 테두리 설정
                  borderSide: BorderSide(color: PRIMARY_BLUE_COLOR, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: PRIMARY_BLUE_COLOR,
            thickness: 2.0,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: pills.length,
            itemBuilder: (context, index) {
              final pill = pills[index];
              return buildPill(pill);
            },
          ),
        ],
      ),
    );
  }

  Widget buildPill(Pill pill) => ListTile(
        title: Text(pill.name),
        subtitle: Text('약 고유 아이디${pill.id}'),
        leading: Image.asset(
          pill.assetName.toString(),
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
      );

  ///
  Widget buildSearch() => SearchWidget(
        text: query,
        onChanged: searchPill,
        hintText: '해당 상황에 맞게',
      );

  // /// when url,
  // Widget buildPillUrl(Pill pill) => ListTile(
  //   title: Text(pill.name),
  //   subtitle: Text('약 고유 아이디${pill.id}'),
  //   leading: Image.network(
  //     pill.assetName.toString(),
  //     fit: BoxFit.cover,
  //     width: 50,
  //     height: 50,
  //   ),
  // );
}
