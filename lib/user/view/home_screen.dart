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
        title: Text('이도형님'), // Replace with your app title
        centerTitle: true, // Center the title if required
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // TODO: Navigate to notifications screen
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings screen
            },
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
                padding: const EdgeInsets.fromLTRB(10, 100, 10, 10), // You can increase padding if needed
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) => _buildProductItem(context, products[index]),
              ),

            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 80.0, // 원하는 높이 설정
        width: 77.0, // 원하는 너비 설정
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
            backgroundColor: PRIMARY_BLUE_COLOR, // 이 색상은 앱의 기본 색상 코드여야 합니다.
            // 둥근 모양을 주기 위해 여기서 shape를 조정할 수 있습니다.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                minWidth: 40,
                onPressed: () => _showDialog('Dashboard'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.blue),
                    Text(
                      '복용중',
                      style: TextStyle(color: Colors.blue, fontSize: 13),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () => _showDialog('Settings'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.search, color: Colors.grey),
                    Text(
                      '검색하기',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Pill {
  final String imagePath;

  const Pill(this.imagePath);

  Widget get imageWidget {
    return Image.asset(
      imagePath,
    );
  }
}

final List<Pill> products = [
  Pill('assets/img/p1.png'),
  Pill('assets/img/p2.png'),
  Pill('assets/img/p1.png'),
  Pill('assets/img/p2.png'),
];


Widget _buildProductItem(BuildContext context, Pill pill) {
  return InkWell(
    onTap: () {
      // TODO: Navigate to detail screen
    },
    child: Column(// Stretch the items to fill the Card
      children: [
        Expanded(
          child: ClipRRect( // Clip the image with rounded corners
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)), // Top corners rounded
            child: pill.imageWidget, // Pill image
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0), // Add padding around the text
          child: Text(
            '약 넘버링', // Replace with actual pill name
            style: TextStyle(
              fontSize: 16.0, // Adjust the font size as needed
            ),
          ),
        ),
        // Add more info here if needed
      ],
    ),
  );
}