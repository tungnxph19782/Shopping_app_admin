import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmActionDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final Function onConfirm;

  const ConfirmActionDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Đóng hộp thoại
          },
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () {
            onConfirm(); // Gọi hàm xác nhận
            Get.back(); // Đóng hộp thoại
          },
          child: Text(confirmText),
        ),
      ],
    );
  }
}
