import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chats_controller.dart';
class ChatsPage extends GetView<ChatsController>{
  const ChatsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Chats Page",style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

}