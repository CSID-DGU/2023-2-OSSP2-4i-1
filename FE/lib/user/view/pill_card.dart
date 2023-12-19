import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PillCard extends StatefulWidget {
  const PillCard({super.key});

  @override
  State<PillCard> createState() => _PillCardState();
}

class _PillCardState extends State<PillCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(11, 0, 21, 0),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Colors.grey.shade200,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                SvgPicture.asset('assets/img/pills/alarmPill.svg', width: 100, height: 100),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("타이레놀정", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("남은 복용 알약: 3개"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTimeContainer("아침", Colors.lightBlue, Colors.white),
                          _buildTimeContainer("점심", Colors.orange, Colors.white),
                          _buildTimeContainer("저녁", Colors.purple, Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeContainer(String displayText, Color backgroundColor, Color textColor) {
    return Container(
      width: 45,
      height: 21,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: backgroundColor,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          displayText,
          style: TextStyle(
            color: textColor,
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
