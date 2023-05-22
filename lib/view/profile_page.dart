import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horget/controller/render.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final system = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(system);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildCard(
                  'https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                  'Sachin Prajapati',
                  'sachin@gmail.com'),
              const SizedBox(height: 20),
              Container(
                height: 1,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.black54),
              ),
              const SizedBox(height: 15),
              _widgetCard('Profile', 'Account settings',
                  CupertinoIcons.person_fill, () {}),
              _widgetCard('History', 'Travel history',
                  CupertinoIcons.chevron_down_square_fill, () {}),
              _widgetCard('Review', 'Your feedback',
                  CupertinoIcons.staroflife_fill, () {}),
              _widgetCard("Term's", 'Privacy terms',
                  CupertinoIcons.personalhotspot, () {}),
              _widgetCard('Conditions', 'Our conditions',
                  CupertinoIcons.doc_checkmark_fill, () {}),
              _widgetCard('Copyright', 'Copyright action',
                  CupertinoIcons.info_circle_fill, () {}),
              _widgetCard('Help', 'Customer care',
                  CupertinoIcons.graph_circle_fill, () {}),
              _widgetCard(
                  'Logout', 'Account signout', CupertinoIcons.escape, () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String url, String name, String email) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(url),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontFamily: "Product Sans",
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              email,
              style: const TextStyle(
                  fontFamily: "Product Sans",
                  color: Colors.black54,
                  fontSize: 13,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ],
    );
  }

  Widget _widgetCard(
      String title, String subTitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      trailing: Icon(CupertinoIcons.chevron_forward, size: 20),
      title: Text(title, style: styleB15),
      subtitle: Text(subTitle, style: styleB13),
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
        child: Center(
          child: Icon(icon, size: 20),
        ),
      ),
    );
  }
}
