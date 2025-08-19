import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(screenWidth * 0.02),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.5),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
            iconSize: screenWidth * 0.06,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black87, Colors.black54],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),
              // Profile Avatar
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircleAvatar(
                      radius: screenWidth * 0.15,
                      backgroundColor: Colors.grey[800],
                      child: Icon(
                        Icons.person,
                        size: screenWidth * 0.15,
                        color: Colors.white70,
                      ),
                    );
                  }

                  final userData =
                      snapshot.data?.data() as Map<String, dynamic>?;
                  final profileImage = userData?['profileImage'] as String?;

                  return CircleAvatar(
                    radius: screenWidth * 0.15,
                    backgroundColor: Colors.grey[800],
                    backgroundImage: profileImage != null
                        ? NetworkImage(profileImage) as ImageProvider
                        : null,
                    child: profileImage == null
                        ? Icon(
                            Icons.person,
                            size: screenWidth * 0.15,
                            color: Colors.white70,
                          )
                        : null,
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.03),
              // Settings List
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenWidth * 0.08),
                      topRight: Radius.circular(screenWidth * 0.08),
                    ),
                  ),
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.02,
                    ),
                    children: [
                      _buildAccountSettings(context),
                      SizedBox(height: screenHeight * 0.01),
                      _buildExpandableSettingsItem(
                        context,
                        icon: Icons.security,
                        title: 'Privacy & Security',
                        content: _buildPrivacySecurityContent(context),
                      ),
                      _buildExpandableSettingsItem(
                        context,
                        icon: Icons.help,
                        title: 'Help & Support',
                        content: _buildHelpSupportContent(context),
                      ),
                      _buildExpandableSettingsItem(
                        context,
                        icon: Icons.info,
                        title: 'About App',
                        content: _buildAboutAppContent(context),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSettings(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.01,
      ),
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
      ),
      child: ExpansionTile(
        leading: Icon(
          Icons.account_circle,
          color: Colors.green,
          size: screenWidth * 0.06,
        ),
        title: Text(
          'Account Information',
          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04),
        ),
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.green),
                );
              }

              final userData = snapshot.data?.data() as Map<String, dynamic>?;
              final licenceData = userData?['licence'] as Map<String, dynamic>?;
              final idData =
                  userData?['identification'] as Map<String, dynamic>?;

              return Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Basic Info
                    _buildInfoRow(context, 'Name', userData?['name']),
                    _buildInfoRow(
                      context,
                      'Email',
                      userData?['email'],
                      isEditable: true,
                      fieldName: 'email',
                    ),

                    // Licence Information
                    if (licenceData != null) ...[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        'Licence Information',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      _buildInfoRow(context, 'Type', licenceData['type']),
                      _buildInfoRow(
                        context,
                        'Issuing Department',
                        licenceData['issuingDepartment'],
                      ),
                      _buildInfoRow(
                        context,
                        'Expiry Date',
                        licenceData['expiryDate'],
                      ),
                      _buildInfoRow(
                        context,
                        'Duration',
                        licenceData['duration'],
                      ),
                      _buildInfoRow(
                        context,
                        'Issued By',
                        licenceData['issuedBy'],
                      ),
                    ],

                    // Identification
                    if (idData != null) ...[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        'Identification',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      if (idData['passport'] != null)
                        _buildInfoRow(
                          context,
                          'Passport',
                          idData['passport'],
                          isEditable: true,
                          fieldName: 'passport',
                        ),
                      if (idData['ic'] != null)
                        _buildInfoRow(
                          context,
                          'IC Number',
                          idData['ic'],
                          isEditable: true,
                          fieldName: 'ic',
                        ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget content,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.01,
      ),
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
      ),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.green, size: screenWidth * 0.06),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04),
        ),
        children: [content],
      ),
    );
  }

  Widget _buildPrivacySecurityContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        children: [
          _buildPrivacySecurityItem(
            context,
            title: 'Data Collection',
            content:
                'We collect minimal data required for app functionality. All data is encrypted and stored securely.',
          ),
          _buildPrivacySecurityItem(
            context,
            title: 'Permissions',
            content:
                'The app requires location permissions for forestry-related features. Camera access is needed for document scanning.',
          ),
          _buildPrivacySecurityItem(
            context,
            title: 'Security Measures',
            content:
                'Two-factor authentication is available for enhanced security. Regular security audits are performed.',
          ),
          _buildPrivacySecurityItem(
            context,
            title: 'Data Sharing',
            content:
                'Your data is only shared with authorized government agencies as required by law.',
          ),
        ],
      ),
    );
  }

  Widget _buildHelpSupportContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        children: [
          _buildHelpSupportItem(
            context,
            icon: Icons.help_outline,
            title: 'FAQs',
            content: 'Visit our FAQ section for answers to common questions.',
          ),
          _buildHelpSupportItem(
            context,
            icon: Icons.email,
            title: 'Contact Us',
            content:
                'Email: support@forestryapp.gov.my\nPhone: +60 3-1234 5678',
          ),
          _buildHelpSupportItem(
            context,
            icon: Icons.report_problem,
            title: 'Report Issues',
            content:
                'Use the in-app reporting tool to submit any problems you encounter.',
          ),
          _buildHelpSupportItem(
            context,
            icon: Icons.feedback,
            title: 'Feedback',
            content: 'We welcome your suggestions for improving the app.',
          ),
        ],
      ),
    );
  }

  Widget _buildAboutAppContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        children: [
          // Replace with your custom image
          Container(
            child: Image.asset(
              'assets/sss.png',
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
              fit: BoxFit.contain,
            ),
          ),

          SizedBox(height: screenHeight * 0.02),
          Text(
            'Forestry Department Permit App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.045,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.03),
          _buildAboutAppItem(context, 'Version', '1.2.3'),
          _buildAboutAppItem(
            context,
            'Developed By',
            'Peninsular Government\nof Malaysia',
          ),
          _buildAboutAppItem(context, 'Last Updated', 'August 2023'),
          SizedBox(height: screenHeight * 0.03),
          Text(
            'This official app allows forestry permit holders to manage their permits and access government services.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: screenWidth * 0.035,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String? value, {
    bool isEditable = false,
    String? fieldName,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (value == null) return const SizedBox();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey,
                fontSize: screenWidth * 0.035,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.035,
              ),
            ),
          ),
          if (isEditable)
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.green,
                size: screenWidth * 0.05,
              ),
              onPressed: () => _showEditDialog(
                context,
                label.toLowerCase(),
                value,
                fieldName!,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPrivacySecurityItem(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: screenWidth * 0.04,
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Text(
            content,
            style: TextStyle(
              color: Colors.white70,
              fontSize: screenWidth * 0.035,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpSupportItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green, size: screenWidth * 0.06),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  content,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: screenWidth * 0.035,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutAppItem(BuildContext context, String label, String value) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: screenWidth * 0.04,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white70,
              fontSize: screenWidth * 0.04,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(
    BuildContext context,
    String fieldLabel,
    String currentValue,
    String fieldName,
  ) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController controller = TextEditingController(
      text: currentValue,
    );

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        backgroundColor: Colors.grey[900],
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Update $fieldLabel',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenWidth * 0.05),
              TextField(
                controller: controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter new $fieldLabel',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                    ),
                    onPressed: () async {
                      if (controller.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$fieldLabel cannot be empty'),
                          ),
                        );
                        return;
                      }

                      try {
                        if (fieldName == 'email') {
                          await currentUser?.verifyBeforeUpdateEmail(
                            controller.text.trim(),
                          );
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(currentUser?.uid)
                              .update({'email': controller.text.trim()});
                        } else if (fieldName == 'passport' ||
                            fieldName == 'ic') {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(currentUser?.uid)
                              .update({
                                'identification.$fieldName': controller.text
                                    .trim(),
                              });
                        } else {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(currentUser?.uid)
                              .update({fieldName: controller.text.trim()});
                        }

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$fieldLabel updated successfully'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Error updating $fieldLabel: ${e.toString()}',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final screenWidth = MediaQuery.of(context).size.width;

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        title: Text(
          'Logout',
          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.05),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Colors.white70, fontSize: screenWidth * 0.04),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey,
                fontSize: screenWidth * 0.04,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.04,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
