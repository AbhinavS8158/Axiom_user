import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/login_controller.dart';
import 'package:user/controller/profile_controller.dart';
import 'package:user/screens/aboutus/about_us.dart';
import 'package:user/screens/editprofile/editprofile.dart';
import 'package:user/screens/help&support/help_support_screen.dart';
import 'package:user/screens/policy&privacy/policy_privacy_screen.dart';
import 'package:user/screens/property/property_list.dart';
import 'package:user/screens/transctionhistory/transaction_history_screen.dart';
import 'package:user/screens/utils/app_color.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColor.grey1,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColor.bg, AppColor.bg.withOpacity(0.8)],
                  ),
                ),
                child: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: EdgeInsets.only(left: 20, bottom: 16),
                  title: Text(
                    'My Profile',
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     _buildProfileHeader(profileController),



                    
                      SizedBox(height: 32),

                      Text(
                        'Quick Actions',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.black,
                        ),
                      ),

                      SizedBox(height: 16),

                      _buildDashboardGrid(controller),

                      SizedBox(height: 32),

                      _buildAdditionalOptions(controller),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
Widget _buildProfileHeader(ProfileController controller) {
  return Obx(() {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    final firestoreUser = controller.user.value;
    final authUser = FirebaseAuth.instance.currentUser;

    final String name =
        firestoreUser?.name.isNotEmpty == true
            ? firestoreUser!.name
            : 'Welcome Guest';

    final String email =
        firestoreUser?.email.isNotEmpty == true
            ? firestoreUser!.email
            : '';

    final String phone =
        firestoreUser?.phone.isNotEmpty == true
            ? firestoreUser!.phone
            : (authUser?.phoneNumber ?? '');

    final String photoUrl =
        firestoreUser?.photoUrl.isNotEmpty == true
            ? firestoreUser!.photoUrl
            : '';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage:
                photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
            child: photoUrl.isEmpty
                ? const Icon(Icons.person, size: 35)
                : null,
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                if (email.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    email,
                    style: TextStyle(color: AppColor.grey6),
                  ),
                ],

                if (phone.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    phone,
                    style: TextStyle(color: AppColor.grey6),
                  ),
                ],
              ],
            ),
          ),

          InkWell(
            onTap: () {
              Get.to(
                () => EditProfile(phoneNumber: phone),
              );
            },
            child: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  });
}


  Widget _buildDashboardGrid(LoginController controller) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        _buildActionCard(
          title: 'Properties',
          icon: Icons.business,
          gradient: [AppColor.yellow, AppColor.amber],
          onTap: () => Get.to(() => PropertyList()),
        ),
        _buildActionCard(
          title: 'Transaction History',
          icon: Icons.account_balance_wallet,
          gradient: [AppColor.lightblue, AppColor.blue],
          onTap: () => Get.to(() => TransactionHistoryScreen()),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradient[1].withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColor.white, size: 28),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.white,
                  height: 1.2,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalOptions(LoginController controller) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildOptionTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'Get assistance anytime',
            onTap: () => Get.to(() => const HelpSupportScreen()),
          ),
          Divider(height: 1, color: AppColor.grey3),
          _buildOptionTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            subtitle: 'Learn about your privacy',
            onTap: () => Get.to(() => const PrivacyPolicyScreen()),
          ),
          Divider(height: 1, color: AppColor.grey3),
           _buildOptionTile(
            icon: Icons.help_outline,
            title: 'About Us',
            subtitle: 'Who We Are and What We Stand For ',
            onTap: () => Get.to(() => const AboutUs()),
          ),
          Divider(height: 1, color: AppColor.grey3),
          _buildOptionTile(
            icon: Icons.logout,
            title: 'Logout',
            subtitle: 'Sign out of your account',
            onTap: () => controller.logout(),
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDestructive ? Colors.red.withOpacity(0.1) : AppColor.grey3,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isDestructive ? Colors.red : AppColor.black,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDestructive ? Colors.red : AppColor.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 13, color: AppColor.grey6),
      ),
      trailing: Icon(Icons.chevron_right, color: AppColor.grey6),
    );
  }
}
