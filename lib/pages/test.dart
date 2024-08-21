import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  final url = Uri.parse('https://4b46-2001-44c8-4180-513b-ce-defe-f9f-693b.ngrok-free.app/');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // ดึงข้อมูล JSON จาก response.body
      final jsonData = json.decode(response.body);

      // ทำอะไรกับข้อมูลต่อไปนี้
      print(jsonData);
    } else {
      // แสดงข้อความเมื่อมีปัญหาในการเรียก API
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    // แสดงข้อความเมื่อมีข้อผิดพลาดในการเชื่อมต่อ
    print('Error: $e');
  }
}

void main() {
  fetchData();
}
