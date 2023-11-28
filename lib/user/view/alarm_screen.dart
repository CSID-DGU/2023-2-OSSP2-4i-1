import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/common/view/default_layout.dart';
import 'package:yakmoya/user/view/pill_card.dart';

class AlarmScreen extends ConsumerStatefulWidget {
  const AlarmScreen({super.key});

  @override
  ConsumerState<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends ConsumerState<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: Colors.white,
      title: '약 알림 목록',
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: samplePills.length,
              itemBuilder: (context, index) {
                return PillCard(samplePills[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

final samplePills = [
  SamplePill(
      name: '타이레놀정500mg',
      num: 1,
      morning: true,
      lunch: true,
      dinner: true,
      imgUrl: 'assets/img/pills/alarmPill.svg'),
  SamplePill(
      name: '아스피린정500mg',
      num: 2,
      morning: true,
      lunch: true,
      dinner: true,
      imgUrl: 'assets/img/pills/alarmPill.svg'),
  SamplePill(
      name: '가스피린정 500mg',
      num: 3,
      morning: true,
      lunch: true,
      dinner: true,
      imgUrl: 'assets/img/pills/alarmPill.svg'),
];

class SamplePill {
  final String name;
  final int num;
  final bool morning;
  final bool lunch;
  final bool dinner;
  final String imgUrl;

  SamplePill({
    required this.name,
    required this.num,
    required this.morning,
    required this.lunch,
    required this.dinner,
    required this.imgUrl,
  });
}

Widget PillCard(SamplePill pill) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Card(
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 335,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Colors.white,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/pills/alarmPill.png'),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Text(
                      pill.name!,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Text(
                      '남은 복용 알약 ${pill.num}',
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 45,
                          height: 21,
                          decoration: BoxDecoration(
                            color: PRIMARY_BLUE_COLOR,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: PRIMARY_BLUE_COLOR,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '아침',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 45,
                          height: 21,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: PRIMARY_BLUE_COLOR,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '점심',
                              style: TextStyle(
                                color: PRIMARY_BLUE_COLOR,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 45,
                          height: 21,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: PRIMARY_BLUE_COLOR,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '저녁',
                              style: TextStyle(
                                color: PRIMARY_BLUE_COLOR,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: SvgPicture.asset('assets/img/pencil.svg',height: 30),
                      ),
                      InkWell(
                        child: SvgPicture.asset('assets/img/trash.svg',height: 30,),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
