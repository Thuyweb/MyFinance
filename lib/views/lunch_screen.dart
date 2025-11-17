import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Lưu ý: Hàm main() này chỉ nên dùng để test màn hình này.
// Khi chạy app chính, hàm main() trong file 'main.dart' sẽ được dùng.
void main() {
  runApp(const lunchScreen());
}

class lunchScreen extends StatelessWidget {
  const lunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(body: ListView(children: [Launch()])),
    );
  }
}

class Launch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 430,
          height: 932,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFFF1FFF2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Stack(
            children: [
              // --- PHẦN LOGO ---
              Positioned(
                left: 115,
                top: 150,
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.red.withOpacity(0.1),
                        child: Center(
                          child: Text(
                            'Lỗi tải ảnh. Kiểm tra pubspec.yaml',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // --- Chữ My Finance ---
              Positioned(
                // Đặt left: 0 và right: 0 để nó tự động căng ra
                // và căn giữa text bên trong
                left: 0,
                right: 0,
                top: 401,
                child: Text(
                  'My Finance',
                  textAlign: TextAlign.center, // Căn giữa
                  style: TextStyle(
                    color: const Color(0xFF00D09E),
                    fontSize: 52.14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.10,
                  ),
                ),
              ),

              // --- Chữ mô tả ---
              Positioned(
                // Tương tự, left: 0 và right: 0
                left: 0,
                right: 0,
                top: 462,
                child: Padding(
                  // Thêm Padding để chữ không bị sát 2 bên lề
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    'Giúp bạn làm chủ tài chính cá nhân.',
                    textAlign: TextAlign.center, // Căn giữa
                    style: TextStyle(
                      color: const Color(0xFF4B4544),
                      fontSize: 14,
                      fontFamily: 'League Spartan',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              // (Code các nút bấm bên dưới được giữ nguyên...)
              Positioned(
                left: 112,
                top: 530,
                child: Container(
                  width: 207,
                  height: 45,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 207,
                          height: 45,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF00D09E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -7,
                        top: 11,
                        child: SizedBox(
                          width: 220,
                          child: Text(
                            'Đăng nhập',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF093030),
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 1.10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 112,
                top: 587,
                child: Container(
                  width: 207,
                  height: 45,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 207,
                          height: 45,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFDFF7E2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -1,
                        top: 11,
                        child: SizedBox(
                          width: 208,
                          child: Text(
                            'Đăng ký',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF0E3E3E),
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 1.10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0, // giúp tự căn giữa trong màn hình
                top: 644,
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // căn giữa
                    children: [
                      Text(
                        'Quên mật khẩu?',
                        style: TextStyle(
                          color: Color(0xFF093030),
                          fontSize: 14,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6),
                      FaIcon(
                        FontAwesomeIcons.lock,
                        size: 16,
                        color: Color(0xFF093030),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
