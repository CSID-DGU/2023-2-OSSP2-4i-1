import 'package:flutter/material.dart';
import 'package:yakmoya/common/const/colors.dart';
import 'package:yakmoya/user/view/filter_network_list_screen.dart';
import 'package:yakmoya/user/view/search_screen.dart';

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
          child: Image.asset(
            'assets/img/alarm.png',
            width: 24,
            height: 24,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // TODO: Navigate to settings screen
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child:
                  Image.asset('assets/img/setting.png', width: 44, height: 44),
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

class HomePill {
  final String imagePath;
  final String name; // 이름을 저장할 필드를 추가합니다.

  const HomePill(this.imagePath, this.name);

  Widget get imageWidget {
    return Image.asset(imagePath);
  }
}

final List<HomePill> products = [
  HomePill('assets/img/p1.png', '알약1'),
  HomePill('assets/img/p2.png', '알약2'),
  HomePill('assets/img/plus.png', '추가하기'),
  HomePill('assets/img/warning.png', ''),
];

Widget _buildProductItem(BuildContext context, HomePill pill) {
  /*void show() {
    showDialog<String>(
      context: context,

      /// 다이얼로그 배경 컬러
      // barrierColor: Colors.cyan.withOpacity(0.4),

      /// 다이얼로그 배경을 터치했을 때 다이얼로그를 닫을지 말지 결정
      /// true = 닫을 수 있음, false = 닫을 수 없음
      barrierDismissible: true,

      builder: (context) {
        return Dialog(
          /// 배경 컬러
          backgroundColor: Colors.grey.shade100,

          /// 그림자 컬러
          shadowColor: Colors.blue,

          /// 다이얼로그의 모양 설정
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          /// z축 높이, elevation의 값이 높을 수록 그림자가 아래 위치하게 됩니다.
          elevation: 10,

          /// 다이얼로그의 위치 설정, 기본값은 center
          alignment: Alignment.bottomCenter,

          /// Dialog의 padding 값입니다..
          /// sizedBox의 가로세로 값읠 infinity로 설정해놓고
          /// 가로패딩 50, 세로 패딩 200을 줬습니다.
          /// 이렇게 하면 좌우 50, 위아래 200만큼의 패딩이 생기고 배경이 나오게 됩니다.
          /// 여기서 vertical의 값을 많이 주면,
          /// 키보드가 올라왔을 때 공간이 부족해서 overflow가 발생할 수 있습니다.
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 100,
          ),

          /// Material 3 에서만 사용됨
          // surfaceTintColor: Colors.green,

          /// 소프트키보드가 올라왔을 때 다이얼로그의 사이즈가 조절되는 시간
          insetAnimationDuration: const Duration(milliseconds: 1000),

          /// 소프트키보드가 올라왔을 때 다이얼로그 사이즈 변경 애니메이션
          insetAnimationCurve: Curves.bounceOut,

          child: SizedBox(
              width: 100,
              height: 200,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "다이얼로그",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "검색어를 입력해주세요",
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          /// Navigator.pop에서 result값을 넣어주면
                          /// showDialog의 return 값이 됩니다.
                          Navigator.pop(context, "return value");
                        },
                        child: const Text("확인")),
                  ),
                ],
              )),
        );
      },
    ).then((value) {
      /// Navigator.pop 의 return 값이 들어옵니다.
    }).whenComplete(() {
      /// 다이얼로그가 종료됐을 때 호출됩니다.
    });
  }*/

  // '추가하기' 선택 시 표시될 대화상자
  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // 모서리를 둥글게
            side: BorderSide(
              color: PRIMARY_BLUE_COLOR,
              width: 2,
            ), // 테두리 색과 두께
          ),
          backgroundColor: Colors.white,
          title: Center(
            child: const Text('약 추가하기'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(
                color: Colors.grey[300],
                thickness: 2,
              ),
              buildElevatedButton('이름으로 추가📝', () {
                Navigator.of(context).pop(); // 대화상자 닫기
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                );
              }),
              buildElevatedButton('사진으로 추가📷', () {
                Navigator.of(context).pop(); // 대화상자 닫기
                // TODO: 사진으로 선택 화면으로 이동
              }),
              buildElevatedButton('복용중에서 추가💊', () {
                Navigator.of(context).pop(); // 대화상자 닫기
                // TODO: 복용중에서 선택 화면으로 이동
              }),
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

Widget buildElevatedButton(String buttonName, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, // 글자 색상
        backgroundColor: Colors.white, // 배경 색상
        side: const BorderSide(
          color: PRIMARY_BLUE_COLOR, // 여기에 실제 사용할 색상 코드를 입력하세요.
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 테두리 둥글기
        ),
        minimumSize: const Size(
          double.infinity, // 버튼 너비 최대로
          50, // 버튼 높이
        ),
      ),
      child: Text(
        buttonName,
        style: const TextStyle(
            fontWeight: FontWeight.w900, fontSize: 22, color: BLUE_COLOR),
      ),
    ),
  );
}
