import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/menu_grid_card.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisCount: 3,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: const [
        MenuGridCard(
          title: 'My Profile',
          icon: Icons.badge,
          index: 0,
          color: Colors.blue,
        ),
        MenuGridCard(
          title: 'License Info',
          icon: Icons.info,
          index: 1,
          color: Colors.green,
        ),
        MenuGridCard(
          title: 'Apply License',
          icon: Icons.app_registration,
          index: 2,
          color: Colors.orange,
        ),
        MenuGridCard(
          title: 'Payments',
          icon: Icons.payment,
          index: 3,
          color: Colors.purple,
        ),
        MenuGridCard(
          title: 'Feedback',
          icon: Icons.feedback,
          index: 4,
          color: Colors.red,
        ),
        MenuGridCard(
          title: 'Contact Us',
          icon: Icons.support_agent,
          index: 5,
          color: Colors.teal,
        ),
        MenuGridCard(
          title: 'Chat Bot',
          icon: FontAwesomeIcons.robot, // Futuristic robot
          index: 6,
          color: Colors.indigo,
        ),
        MenuGridCard(
          title: 'Marketplace',
          icon: Icons.store,
          index: 7,
          color: Colors.brown,
        ),
        MenuGridCard(
          title: 'About Us',
          icon: Icons.group,
          index: 8,
          color: Colors.pink,
        ),
      ],
    );
  }
}
