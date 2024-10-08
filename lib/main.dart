import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Biến lưu trạng thái đăng ký
  bool isRegistered = false;

  // Thêm biến để theo dõi chỉ số của PageView
  PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'English Quiz',
      style: TextStyle(fontSize: 24),
    ),
    Text(
      'Progress',
      style: TextStyle(fontSize: 24),
    ),
    Text(
      'Profile',
      style: TextStyle(fontSize: 24),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/Logo.png', // Thay bằng đường dẫn tới logo của bạn
              height: 60, // Độ cao logo
            ),
          ],
        ),
        actions: [
          // Nếu người dùng chưa đăng ký, hiển thị cả hai nút
          if (!isRegistered)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý logic đăng ký
                  setState(() {
                    isRegistered = true; // Giả lập trạng thái đã đăng ký
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Màu nền của nút Đăng ký
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text('Đăng ký', style: TextStyle(color: Colors.white)),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                // Xử lý logic đăng nhập
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Màu nền của nút Đăng nhập
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text('Đăng nhập', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner với các hình ảnh tự lướt
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3), // Tự lướt sau 3 giây
                enlargeCenterPage: true,
                height: 180,
              ),
              items: [
                'assets/images/banner1.jpg', // Đường dẫn hình ảnh trong banner
                'assets/images/banner2.jpg',
                'assets/images/banner3.jpg',
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Image.asset(
                        i,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            // Khoảng cách giữa banner và các section
            SizedBox(height: 20),
            // Tiêu đề cho phần "Các bài test"
            Text(
              'Các bài test', // Văn bản tiêu đề
              style: TextStyle(
                fontSize: 24, // Kích thước chữ
                fontWeight: FontWeight.bold, // Đậm
                color: Colors.black, // Màu chữ
              ),
            ),
            SizedBox(height: 10), // Khoảng cách giữa tiêu đề và các section
            // Các section cho các dạng bài test
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Container(
                    height: 120, // Chiều cao của PageView
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: [
                        _buildTestContainer('A1', 'assets/images/a1.jpg'),
                        _buildTestContainer('A2', 'assets/images/a2.jpg'),
                        _buildTestContainer('B1', 'assets/images/b1.jpg'),
                        _buildTestContainer('B2', 'assets/images/b2.jpg'),
                        _buildTestContainer('TOEIC', 'assets/images/toeic.jpg'),
                        _buildTestContainer('IELTS', 'assets/images/ielts.jpg'),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  // Các nút lướt qua
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          if (_currentPage > 0) {
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          if (_currentPage < 5) {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Nội dung chính của trang
            SizedBox(height: 20), // Khoảng cách cho phần nội dung
            Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  // Hàm xây dựng Container cho các dạng bài test
  Widget _buildTestContainer(String label, String imagePath) {
    return Container(
      width: 100, // Chiều rộng của từng container
      height: 120, // Chiều cao của từng container
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Bo tròn góc
        image: DecorationImage(
          image: AssetImage(imagePath), // Thay đổi hình ảnh ở đây
          fit: BoxFit.cover, // Đảm bảo hình ảnh phủ kín
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
        children: [
          // Hiển thị văn bản
          Text(
            label, // Văn bản hiển thị
            style: TextStyle(
              color: Colors.white, // Màu chữ
              fontSize: 20, // Kích thước chữ
              fontWeight: FontWeight.bold, // Đậm
              backgroundColor: Colors.black54, // Nền chữ
            ),
            textAlign: TextAlign.center, // Căn giữa
          ),
          SizedBox(height: 8), // Khoảng cách giữa văn bản và nút
          ElevatedButton(
            onPressed: () {
              // Xử lý logic khi nhấn nút "Làm bài"
              print('Bắt đầu làm bài $label');
            },
            child: Text('Làm bài'), // Nội dung nút
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Màu nền của nút
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
