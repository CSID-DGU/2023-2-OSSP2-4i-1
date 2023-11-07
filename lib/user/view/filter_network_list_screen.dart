import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/common/view/default_layout.dart';
import 'package:yakmoya/pill/pill_api.dart';
import 'package:yakmoya/pill/pill_data.dart';
import 'package:yakmoya/pill/pill_model.dart';
import 'package:yakmoya/user/view/search_widget.dart';

class FilterNetworkListScreen extends StatefulWidget {
  const FilterNetworkListScreen({super.key});

  @override
  State<FilterNetworkListScreen> createState() => _FilterNetworkListScreenState();
}

class _FilterNetworkListScreenState extends State<FilterNetworkListScreen> {
  TextEditingController editingController = TextEditingController();
  List<Pill> pills = [];
  List<Pill> selectedPills = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
      VoidCallback callback, {
        Duration duration = const Duration(milliseconds: 1000),
      }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final pills = await PillsAPI.getPills(query);
    if (!mounted) return;
    setState(() => this.pills = pills);
  }

  Future searchPill(String query) async => debounce(() async {
    final pills = await PillsAPI.getPills(query);
    if (!mounted) return;
    setState(() {
      this.query = query;
      this.pills = pills;
    });
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '이름으로 추가',
      child: Column(
        children: <Widget>[
          buildSearch(),
          Expanded(
            child: ListView.builder(
              itemCount: pills.length,
              itemBuilder: (context, index) {
                final pill = pills[index];
                return ListTile(
                  title: Text(pill.name),
                  subtitle: Text('약 고유 아이디${pill.id}'),
                  leading: Image.asset(
                    pill.assetName.toString(),
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                  trailing: selectedPills.contains(pill)
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : Icon(Icons.check_circle_outline),
                  onTap: () => _toggleSelectedPill(pill),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
    text: query,
    onChanged: searchPill,
    hintText: '해당 상황에 맞게',
  );

  void _toggleSelectedPill(Pill pill) {
    setState(() {
      if (selectedPills.contains(pill)) {
        selectedPills.remove(pill);
      } else {
        selectedPills.add(pill);
      }
    });
  }

  void _doneAndReturnSelection() {
    Navigator.of(context).pop(selectedPills); // 선택된 약들의 리스트를 반환
  }
}
