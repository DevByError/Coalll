import 'package:flutter/material.dart';
import 'package:coalll/pages/license_info_page.dart'; // You'll need to create this
import 'package:coalll/pages/license_application_page.dart'; // You'll need to create this
import 'package:coalll/pages/payment_page.dart'; // You'll need to create this
import 'package:coalll/pages/feedback_page.dart'; // You'll need to create this
import 'package:coalll/pages/contact_page.dart'; // You'll need to create this
import 'package:coalll/pages/chatbot_page.dart'; // You'll need to create this
import 'package:coalll/pages/marketplace_page.dart'; // You'll need to create this
import 'package:coalll/pages/about_page.dart'; // You'll need to create this
import 'package:coalll/pages/profile_page.dart'; // You'll need to create this

class MenuGridCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final int index;

  const MenuGridCard({
    super.key,
    required this.title,
    required this.icon,
    required this.index,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _handleCardTap(context, index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _handleCardTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Profile/MyKad
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
      case 1:
        // License Info
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LicenseInfoPage()),
        );
        break;
      case 2:
        // Apply for License
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LicenseApplicationPage(),
          ),
        );
        break;
      case 3:
        // Payments
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PaymentPage()),
        );
        break;
      case 4:
        // Feedback
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FeedbackPage()),
        );
        break;
      case 5:
        // Contact Us
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ContactPage()),
        );
        break;
      case 6:
        // AI Chatbot
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatbotPage()),
        );
        break;
      case 7:
        // Marketplace
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MarketplacePage()),
        );
        break;
      case 8:
        // About Us
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AboutPage()),
        );
        break;
    }
  }
}
