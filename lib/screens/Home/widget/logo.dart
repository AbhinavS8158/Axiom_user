import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/screens/chat/chat.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'AXIOM',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              // InkWell(
              //   onTap: (){
              //     Get.to(Profile());
              //   },
              //   child: Icon(
              //     icons.message
              //     backgroundColor: Colors.black,
              //     child: Icon(Icons.person_outline, color: Colors.white),
              //   ),
              // ),
              IconButton(onPressed: (){
                Get.to(Chat());
              }, icon:Icon(Icons.chat_bubble_outline_rounded))
            ],
          ),
        );
  }
}