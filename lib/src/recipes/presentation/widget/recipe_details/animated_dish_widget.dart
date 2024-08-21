// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class AnimatedDishWidget extends StatelessWidget {
  final BoxConstraints constraints;
  final String imageUrl;
  final Duration dishPlayTime;
  final String name;
  const AnimatedDishWidget({
    Key? key,
    required this.constraints,
    required this.imageUrl,
    required this.dishPlayTime,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: constraints.maxHeight * 0.31,
      width: constraints.maxWidth * 0.8,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), // กำหนดขอบโค้งที่ต้องการ
      ),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child:_buildImage())
          .animate()
          .scaleXY(
          begin: 0.0,
          end: 1.0,
          duration: dishPlayTime,
          curve: Curves.decelerate)
          .fadeIn()
          .blurXY(begin: 10, end: 0),
    );
  }
  Widget _buildImage() {
    if (name == 'แกงจืดเต้าหู้หมูสับ') {
      return Image.asset(
        'assets/z.png', // กำหนด path ของรูปภาพที่ต้องการ
        fit: BoxFit.contain,
      );
    }
    else if (name == 'ไข่ตุ๋น') {
      return Image.asset(
        'assets/a.jfif', // กำหนด path ของรูปภาพที่ต้องการ
        fit: BoxFit.contain,
      );
    }
    else if (name == 'ปลาหมึกผัดไข่เค็ม') {
      return Image.asset(
        'assets/d.jfif', // กำหนด path ของรูปภาพที่ต้องการ
        fit: BoxFit.contain,
      );
    } else if (name == 'กุ้งชุบแป้งทอด') {
      return Image.asset(
        'assets/g.jfif', // กำหนด path ของรูปภาพที่ต้องการ
        fit: BoxFit.contain,
      );
    } else if (name == 'ตำไหลบัว') {
      return Image.asset(
        'assets/e.jfif', // กำหนด path ของรูปภาพที่ต้องการ
        fit: BoxFit.contain,
      );
    }else if (name == 'สุกี้โรล') {
      return Image.asset(
        'assets/h.jfif', // กำหนด path ของรูปภาพที่ต้องการ
        fit: BoxFit.contain,
      );
    }else if (name == 'กุ้งแช่น้ำปลา') {
      return Image.asset(
        'assets/f.jfif', // กำหนด path ของรูปภาพที่ต้องการ
        fit: BoxFit.contain,
      );
    }else if (name == 'ผัดแขนงหมูสามชั้น') {
      return Image.asset(
        'assets/asd.jfif', // กำหนด path ของรูปภาพที่ต้องการ
        fit: BoxFit.contain,
      );
    }else if (name == 'ปลาดอลลี่ต้มจืด') {
      return Image.asset(
        'assets/c.jfif', // กำหนด path ของรูปภาพที่ต้องการ
        fit: BoxFit.contain,
      );
    }else if (name == 'ปลากะพงทอดน้ำปลา') {
      return Image.asset(
        'assets/i.jfif', // กำหนด path ของรูปภาพที่ต้องการ
        fit: BoxFit.contain,
      );
    }else if (name == 'กุ้งทอดซอสมะขาม') {
      return Image.asset(
        'assets/o.png', // กำหนด path ของรูปภาพที่ต้องการ
        fit: BoxFit.contain,
      );
    }else if (name == 'ยำไข่ดาว') {
      return Image.asset(
        'assets/w.jfif', // กำหนด path ของรูปภาพที่ต้องการ
        fit: BoxFit.contain,
      );
    }else if (name == 'ต้มแซ่บกระดูกหมูอ่อน') {
      return Image.asset(
        'assets/p.jfif', // กำหนด path ของรูปภาพที่ต้องการ
        fit: BoxFit.contain,
      );
    }
    else {
      return Image.memory(
        base64Decode(imageUrl.split(',').last),
        fit: BoxFit.contain,
      );
    }
  }
}
