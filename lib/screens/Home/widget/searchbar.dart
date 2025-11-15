import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/screens/search/search_screen.dart';
import 'package:user/screens/utils/app_color.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(()=>SearchScreen()),
      child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.grey50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.search, color: AppColor.white),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Search cities, area...',
                    style: TextStyle(color: AppColor.grey6),
                  ),
                  Spacer(),
                  IconButton(onPressed: (){
                    
                  }, icon: Icon(Icons.tune,color: AppColor.grey8,),),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
    );
  }
}