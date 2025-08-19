// contact_page.dart
import 'package:coalll/pages/feedback_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    // Percentage-based sizing
    final double paddingHorizontal = screenWidth * 0.04; // 4% of screen width
    final double paddingVertical = screenHeight * 0.02; // 2% of screen height

    // Font sizes
    final double titleFontSize = screenHeight * 0.025; // 2.5%
    final double headingFontSize = screenHeight * 0.022; // 2.2%
    final double contentFontSize = screenHeight * 0.018; // 1.8%
    final double smallFontSize = screenHeight * 0.016; // 1.6%

    // Spacing
    final double spacingXSmall = screenHeight * 0.008; // 0.8%
    final double spacingSmall = screenHeight * 0.012; // 1.2%
    final double spacingMedium = screenHeight * 0.02; // 2%
    final double spacingLarge = screenHeight * 0.03; // 3%
    final double spacingXLarge = screenHeight * 0.04; // 4%

    // Icon sizes
    final double iconSizeSmall = screenHeight * 0.022; // 2.2%
    final double iconSizeMedium = screenHeight * 0.028; // 2.8%
    final double iconSizeLarge = screenHeight * 0.035; // 3.5%

    // Button and card dimensions
    final double buttonHeight = screenHeight * 0.065; // 6.5%
    final double cardRadius = screenWidth * 0.02; // 2% of screen width
    final double logoSize = screenHeight * 0.15; // 15% of screen height

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: TextStyle(
            fontSize: titleFontSize * 1.1,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green[800],
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(screenWidth * 0.02), // 2% padding
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back,
              size: iconSizeMedium,
              color: Colors.white,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: screenHeight * 0.004, // 0.4%
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[50]!, Colors.green[100]!],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal,
              vertical: paddingVertical,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo Section
                Center(
                  child: Container(
                    height: logoSize,
                    width: logoSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: screenWidth * 0.01, // 1%
                          spreadRadius: screenWidth * 0.005, // 0.5%
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.nature,
                        size: logoSize * 0.6,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spacingMedium),

                // Title Section
                Center(
                  child: Text(
                    'Forestry Department of Malaysia',
                    style: TextStyle(
                      fontSize: titleFontSize * 1.2,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: spacingLarge),

                // Contact Information Section
                Text(
                  'Contact Information',
                  style: TextStyle(
                    fontSize: headingFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                SizedBox(height: spacingSmall),

                _buildContactCard(
                  icon: Icons.phone,
                  title: 'General Inquiry',
                  content: '+603-1234 5678',
                  onTap: () => _launchUrl('tel:+60312345678'),
                  iconSize: iconSizeMedium,
                  cardRadius: cardRadius,
                  cardPadding: paddingHorizontal,
                  fontSize: contentFontSize,
                  iconColor: Colors.blue,
                ),
                SizedBox(height: spacingMedium),

                _buildContactCard(
                  icon: Icons.email,
                  title: 'Email Support',
                  content: 'support@forestry.gov.my',
                  onTap: () => _launchUrl('mailto:support@forestry.gov.my'),
                  iconSize: iconSizeMedium,
                  cardRadius: cardRadius,
                  cardPadding: paddingHorizontal,
                  fontSize: contentFontSize,
                  iconColor: Colors.red,
                ),
                SizedBox(height: spacingMedium),

                _buildContactCard(
                  icon: Icons.location_on,
                  title: 'Headquarters Address',
                  content:
                      'Forestry Department Headquarters\n'
                      'Jalan Sultan Salahuddin\n'
                      '50660 Kuala Lumpur, Malaysia',
                  onTap: () => _launchUrl(
                    'https://maps.google.com/?q=Forestry+Department+Malaysia',
                  ),
                  iconSize: iconSizeMedium,
                  cardRadius: cardRadius,
                  cardPadding: paddingHorizontal,
                  fontSize: contentFontSize,
                  iconColor: Colors.green[500]!,
                ),
                SizedBox(height: spacingLarge),

                // Office Hours Section
                _buildInfoSection(
                  title: 'Office Hours',
                  items: [
                    'Monday - Friday: 8:30 AM - 5:30 PM',
                    'Saturday: 8:30 AM - 1:00 PM',
                    'Sunday & Public Holidays: Closed',
                  ],
                  icon: Icons.access_time,
                  iconColor: Colors.orange,
                  iconSize: iconSizeMedium,
                  fontSize: contentFontSize,
                  spacing: spacingSmall,
                ),
                SizedBox(height: spacingLarge),

                // Emergency Contacts Section
                _buildInfoSection(
                  title: 'Emergency Contacts',
                  items: [
                    '24/7 Hotline: +603-9876 5432',
                    'Wildlife Rescue: +603-9876 5433',
                    'Forest Fire: +603-9876 5434',
                  ],
                  icon: Icons.warning,
                  iconColor: Colors.red,
                  iconSize: iconSizeMedium,
                  fontSize: contentFontSize,
                  spacing: spacingSmall,
                ),
                SizedBox(height: spacingLarge),

                // Social Media Section
                _buildSocialMediaSection(
                  iconSize: iconSizeLarge,
                  spacing: spacingMedium,
                ),
                SizedBox(height: spacingLarge),

                // Feedback Button
                SizedBox(
                  height: buttonHeight,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(cardRadius * 2),
                      ),
                      elevation: screenHeight * 0.003, // 0.3%
                      shadowColor: Colors.green[900],
                      padding: EdgeInsets.symmetric(vertical: spacingSmall),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FeedbackPage(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.feedback,
                          color: Colors.white,
                          size: iconSizeMedium,
                        ),
                        SizedBox(width: spacingSmall),
                        Text(
                          'Submit Feedback',
                          style: TextStyle(
                            fontSize: contentFontSize * 1.1,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: spacingMedium),

                // Version Info
                Center(
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: smallFontSize,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(height: spacingMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String content,
    required VoidCallback onTap,
    required double iconSize,
    required double cardRadius,
    required double cardPadding,
    required double fontSize,
    required Color iconColor,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardRadius),
      ),
      elevation: cardRadius * 0.5,
      shadowColor: Colors.black.withOpacity(0.1),
      child: InkWell(
        borderRadius: BorderRadius.circular(cardRadius),
        onTap: onTap,
        splashColor: Colors.green[100],
        highlightColor: Colors.green[50],
        child: Container(
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cardRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.green[50]!],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(cardPadding * 0.5),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: iconSize, color: iconColor),
              ),
              SizedBox(width: cardPadding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize * 1.2,
                        color: Colors.green[900],
                      ),
                    ),
                    SizedBox(height: cardPadding * 0.3),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: iconSize,
                color: Colors.green[800],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<String> items,
    required IconData icon,
    required Color iconColor,
    required double iconSize,
    required double fontSize,
    required double spacing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: iconSize, color: iconColor),
            SizedBox(width: spacing),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize * 1.1,
                color: Colors.green[800],
              ),
            ),
          ],
        ),
        SizedBox(height: spacing),
        ...items
            .map(
              (item) => Padding(
                padding: EdgeInsets.only(
                  left: iconSize + spacing,
                  bottom: spacing * 0.5,
                ),
                child: Text(
                  item,
                  style: TextStyle(fontSize: fontSize, color: Colors.grey[800]),
                ),
              ),
            )
            .toList(),
      ],
    );
  }

  Widget _buildSocialMediaSection({
    required double iconSize,
    required double spacing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect With Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: iconSize * 0.6,
            color: Colors.green[800],
          ),
        ),
        SizedBox(height: spacing * 0.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSocialIcon(
              icon: Icons.facebook,
              color: Colors.blue[800]!,
              size: iconSize,
              onTap: () => _launchUrl('https://facebook.com/ForestryDeptMY'),
            ),
            _buildSocialIcon(
              icon: Icons.camera_alt,
              color: Colors.pink,
              size: iconSize,
              onTap: () => _launchUrl('https://instagram.com/ForestryDeptMY'),
            ),
            _buildSocialIcon(
              icon: Icons.travel_explore,
              color: Colors.blue,
              size: iconSize,
              onTap: () => _launchUrl('https://forestry.gov.my'),
            ),
            _buildSocialIcon(
              icon: Icons.video_library,
              color: Colors.red,
              size: iconSize,
              onTap: () => _launchUrl('https://youtube.com/ForestryDeptMY'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required Color color,
    required double size,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size),
      child: Container(
        padding: EdgeInsets.all(size * 0.2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.1),
        ),
        child: Icon(icon, size: size * 0.8, color: color),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
