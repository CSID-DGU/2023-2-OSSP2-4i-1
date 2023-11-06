import 'package:flutter/material.dart';
import 'package:yakmoya/common/const/colors.dart';

// 여기서 Dashboard, Chat, Profile, Settings 위젯을 정의해야 합니다.
// 예를 들어 간단한 컨테이너로 대체할 수 있습니다.
class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Dashboard'));
  }
}

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Chat'));
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Profile'));
  }
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Settings'));
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageStorageBucket bucket = PageStorageBucket();

  void _showDialog(String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('이곳에서 $title 기능을 설정할 수 있습니다.'),
          actions: <Widget>[
            TextButton(
              child: Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_BLUE_COLOR,
        title: const Text(
          '도형님',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        // Use a Row widget to have better control over the alignment of the children.
        leading: GestureDetector(
          onTap: () {
            // TODO: Navigate to notifications screen
          },
          child: Image.asset('assets/img/alarm.png', width: 24, height: 24,),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // TODO: Navigate to settings screen
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset('assets/img/setting.png', width: 44, height: 44),
            ),
          ),
        ],
      ),
      backgroundColor: PRIMARY_BLUE_COLOR,
      body: Column(
        children: [
          Expanded(
            // PageStorage를 사용하여 GridView.builder의 상태를 저장합니다.
            child: PageStorage(
              bucket: bucket,
              child: GridView.builder(
                key: PageStorageKey<String>('gridView'),
                padding: const EdgeInsets.fromLTRB(
                    10, 100, 10, 10), // You can increase padding if needed
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) =>
                    _buildProductItem(context, products[index]),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 100.0, // 원하는 높이 설정
        width: 100.0, // 원하는 너비 설정
        child: FittedBox(
          child: FloatingActionButton(
            child: Text(
              '검사\n하기',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16), // 텍스트 크기를 조정하여 적절하게 맞춤
            ),
            onPressed: () {
              // 버튼을 눌렀을 때의 액션
            },
            backgroundColor: Colors.red[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () => _showDialog('Dashboard'),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.blue, size: 30),
                    Text(
                      '복용중',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => _showDialog('Settings'),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.search, color: Colors.grey, size: 30),
                    Text(
                      '검색하기',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Pill {
  final String imagePath;
  final String name; // 이름을 저장할 필드를 추가합니다.

  const Pill(this.imagePath, this.name);

  Widget get imageWidget {
    return Image.asset(imagePath);
  }
}

final List<Pill> products = [
  Pill('assets/img/p1.png', '알약1'),
  Pill('assets/img/p2.png', '알약2'),
  Pill('assets/img/plus.png', '추가하기'),
  Pill('assets/img/warning.png', ''),
];

Widget _buildProductItem(BuildContext context, Pill pill) {
  // '추가하기' 선택 시 표시될 대화상자
  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: SUB_BLUE_COLOR,
          title: const Text('추가하기'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 대화상자 닫기
                  // TODO: 이름으로 선택 화면으로 이동
                },
                child: const Text('이름으로 선택'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 대화상자 닫기
                  // TODO: 사진으로 선택 화면으로 이동
                },
                child: const Text('사진으로 선택'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 대화상자 닫기
                  // TODO: 복용중에서 선택 화면으로 이동
                },
                child: const Text('복용중에서 선택'),
              ),
            ],
          ),
        );
      },
    );
  }
  return InkWell(
    onTap: () {
      // '추가하기'를 위한 대화상자 표시
      if (pill.name == '추가하기') {
        _showAddDialog();
      } else {
        // TODO: Navigate to detail screen
      }
    },
    child: Column(
      // Stretch the items to fill the Card
      children: [
        Expanded(
          child: ClipRRect(
            // Clip the image with rounded corners
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            child: pill.imageWidget, // Pill image
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            pill.name,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Add more info here if needed
      ],
    ),
  );
}
