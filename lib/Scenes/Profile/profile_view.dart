import 'package:develop_design_system/DesignSystem/Components/BottomTabBar/bottom_tab_bar.dart';
import 'package:develop_design_system/DesignSystem/Components/BottomTabBar/bottom_tab_bar_view_model.dart';
import 'package:develop_design_system/DesignSystem/shared/styles.dart';
import 'package:develop_design_system/Scenes/Profile/profile_router.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData;
  ProfilePage({super.key, required this.userData});

  final List functions = [
    'Edit Name',
    'Shipping Info',
    'Notification',
    'Terms & Conditions',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        titleTextStyle: const TextStyle(
          fontFamily: 'Inter',
          color: Colors.black,
          fontSize: 34,
          fontWeight: FontWeight.bold,
        ),
        titleSpacing: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      'AvatarProfile.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userData['name'] ?? 'No Name',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userData['email'] ?? 'No Email',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            ...functions
                .map((name) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name, style: paragraph1Regular),
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
              ],
            ))
                .toList(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  ProfilePageRouter.logout(context);
                },
                child: Text(
                  'Logout',
                  style: paragraph1Regular.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomTabBar.instantiate(
          currentIndex: 3,
          viewModel: BottomTabBarViewModel(
            bottomTabs: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: "Messages",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.label),
                label: "Label",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              )
            ],
          )),
    );
  }
}