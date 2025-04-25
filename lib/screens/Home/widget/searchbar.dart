import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.search, color: Colors.white),
                ),
                SizedBox(width: 10),
                Text(
                  'Search cities, area...',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Spacer(),
                IconButton(onPressed: (){
                  
                }, icon: Icon(Icons.tune,color: Colors.grey[800],),),
                SizedBox(width: 10),
              ],
            ),
          ),
        );
  }
}