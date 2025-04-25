import 'package:flutter/material.dart';
import 'package:user/model/propertycardmode.dart';
import 'package:user/screens/Home/widget/logo.dart';
import 'package:user/screens/Home/widget/propertycard.dart';
import 'package:user/screens/Home/widget/searchbar.dart';
import 'package:user/screens/Home/widget/tabview.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(child: PropertyListScreen()),
    );
  }
}

class PropertyListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Logo(),

        Searchbar(),

        TabView(),

        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              PropertyCard(
                property: Property(
                  imageUrl:
                      'https://images.unsplash.com/photo-1568605114967-8130f3a36994',
                  name: 'Lakeshore Blvd west',
                  bedrooms: '2 BHK',
                  area: '1493 m²',
                  rent: '₹2000',
                  forRent: true,
                ),
              ),
              SizedBox(height: 15),
              PropertyCard(
                property: Property(
                  imageUrl:
                      'https://images.unsplash.com/photo-1580587771525-78b9dba3b914',
                  name: 'Malabar villas',
                  bedrooms: '2 BHK',
                  area: '1453 m²',
                  rent: '₹1880',
                  forRent: false,
                ),
              ),
              SizedBox(height: 15),
              PropertyCard(
                property: Property(
                  imageUrl:
                      'https://images.unsplash.com/photo-1576941089067-2de3c901e126',
                  name: 'Sky villas',
                  bedrooms: '2 BHK',
                  area: '1453 m²',
                  rent: '₹1580',
                  forRent: false,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
