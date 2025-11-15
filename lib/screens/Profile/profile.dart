
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/login_controller.dart';
import 'package:user/model/dashboad_model.dart';
import 'package:user/screens/profile/widget/dashbord.dart';
import 'package:user/screens/property/property_list.dart';
import 'package:user/screens/utils/app_color.dart';



class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: AppColor.grey1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // Profile Image
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColor.black,
                        shape: BoxShape.circle,
                      ),
                      child:
                          user != null && user.photoURL != null
                              ? CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(user.photoURL!),
                              )
                              : CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColor.black,
                                child: Icon(
                                  Icons.person,
                                  color: AppColor.white,
                                  size: 30,
                                ),
                              ),
                    ),
                    SizedBox(width: 16),
                    // User Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello ${(user != null && user.displayName != null ? '${user.displayName}' : 'Welcome Guest')}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            (user != null && user.email != null)
                                ? user.email!
                                : 'No email',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColor.grey6,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            (user != null && user.phoneNumber != null)
                                ? user.phoneNumber!
                                : 'no number ',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColor.grey6,
                            ),
                          ),
                          SizedBox(height: 4),

                          TextButton(
                            onPressed: () => controller.logout(),
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    ),
                    // Edit Button
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.grey3,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),              // Dashboard Grid
              Expanded(
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.0,
                  children: [
                    // Properties Tile
                    Dashbord(
                      model: DashboadModel(
                        title: 'Properties',
                        icon: Icons.business,
                        color: AppColor.yellow,
                        borderColor: AppColor.amber,
                        onTap: () =>Get.to(()=>PropertyList()),
                      ),
                    ),

                    // Transaction History Tile
                    Dashbord(
                      model: DashboadModel(
                        title: 'Transaction\nHistory',
                        icon: Icons.account_balance_wallet,
                        color: AppColor.lightblue,
                        borderColor: AppColor.blue,
                        onTap: () {},
                      ),
                    ),
                    // Settings Tile
                    Dashbord(
                      model: DashboadModel(
                        title: 'Settings',
                        icon: Icons.settings,
                        color: AppColor.lightpruple,
                        borderColor: AppColor.purple,
                        onTap: () {},
                      ),
                    ),
                    Dashbord(
                      model: DashboadModel(
                        title: "Logout",
                        icon: Icons.logout,
                        color: AppColor.lightgreen,
                        borderColor: AppColor.checkcircle,
                        onTap: () => controller.logout(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
