import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.black87,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.5),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black87, Colors.black54],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  );
                }

                final userData = snapshot.data?.data() as Map<String, dynamic>?;
                final profileImage = userData?['profileImage'] as String?;

                return CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  backgroundImage: profileImage != null
                      ? NetworkImage(profileImage) as ImageProvider
                      : null,
                  child: profileImage == null
                      ? const Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                );
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildAccountSettings(context),
                  _buildSettingsItem(
                    context,
                    icon: Icons.security,
                    title: 'Privacy & Security',
                    onTap: () => _showPrivacySecurity(context),
                  ),
                  _buildSettingsItem(
                    context,
                    icon: Icons.help,
                    title: 'Help & Support',
                    onTap: () => _showHelpSupport(context),
                  ),
                  _buildSettingsItem(
                    context,
                    icon: Icons.info,
                    title: 'About App',
                    onTap: () => _showAboutApp(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSettings(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return ExpansionTile(
      leading: const Icon(Icons.account_circle, color: Colors.green),
      title: const Text(
        'Account Information',
        style: TextStyle(color: Colors.white),
      ),
      children: [
        StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final userData = snapshot.data?.data() as Map<String, dynamic>?;
            final licenceData = userData?['licence'] as Map<String, dynamic>?;
            final idData = userData?['identification'] as Map<String, dynamic>?;

            return Padding(
              padding: const EdgeInsets.all(16.0),
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
                    const SizedBox(height: 16),
                    const Text(
                      'Licence Information',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
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
                    _buildInfoRow(context, 'Duration', licenceData['duration']),
                    _buildInfoRow(
                      context,
                      'Issued By',
                      licenceData['issuedBy'],
                    ),
                  ],

                  // Identification
                  if (idData != null) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Identification',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String? value, {
    bool isEditable = false,
    String? fieldName,
  }) {
    if (value == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: const TextStyle(color: Colors.white)),
          ),
          if (isEditable)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.green, size: 20),
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

  Future<void> _showEditDialog(
    BuildContext context,
    String fieldLabel,
    String currentValue,
    String fieldName,
  ) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final TextEditingController controller = TextEditingController(
      text: currentValue,
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update $fieldLabel'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter new $fieldLabel'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (controller.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$fieldLabel cannot be empty')),
                );
                return;
              }

              try {
                // Update in Firestore
                if (fieldName == 'email') {
                  // Special case for email - requires Firebase Auth update
                  await currentUser?.verifyBeforeUpdateEmail(
                    controller.text.trim(),
                  );
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUser?.uid)
                      .update({'email': controller.text.trim()});
                } else if (fieldName == 'passport' || fieldName == 'ic') {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUser?.uid)
                      .update({
                        'identification.$fieldName': controller.text.trim(),
                      });
                } else {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUser?.uid)
                      .update({fieldName: controller.text.trim()});
                }

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$fieldLabel updated successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Error updating $fieldLabel: ${e.toString()}',
                    ),
                  ),
                );
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _showPrivacySecurity(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Privacy & Security',
          style: TextStyle(color: Colors.green),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPrivacySecurityItem(
                title: 'Data Collection',
                content:
                    'We collect minimal data required for app functionality. All data is encrypted and stored securely.',
              ),
              _buildPrivacySecurityItem(
                title: 'Permissions',
                content:
                    'The app requires location permissions for forestry-related features. Camera access is needed for document scanning.',
              ),
              _buildPrivacySecurityItem(
                title: 'Security Measures',
                content:
                    'Two-factor authentication is available for enhanced security. Regular security audits are performed.',
              ),
              _buildPrivacySecurityItem(
                title: 'Data Sharing',
                content:
                    'Your data is only shared with authorized government agencies as required by law.',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySecurityItem({
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(content, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  void _showHelpSupport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Help & Support',
          style: TextStyle(color: Colors.green),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHelpSupportItem(
                icon: Icons.help_outline,
                title: 'FAQs',
                content:
                    'Visit our FAQ section for answers to common questions.',
              ),
              _buildHelpSupportItem(
                icon: Icons.email,
                title: 'Contact Us',
                content:
                    'Email: support@forestryapp.gov.my\nPhone: +60 3-1234 5678',
              ),
              _buildHelpSupportItem(
                icon: Icons.report_problem,
                title: 'Report Issues',
                content:
                    'Use the in-app reporting tool to submit any problems you encounter.',
              ),
              _buildHelpSupportItem(
                icon: Icons.feedback,
                title: 'Feedback',
                content: 'We welcome your suggestions for improving the app.',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpSupportItem({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(content, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About App', style: TextStyle(color: Colors.green)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: FlutterLogo(size: 80)),
              const SizedBox(height: 16),
              const Text(
                'Forestry Department Permit App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildAboutAppItem('Version', '1.2.3'),
              _buildAboutAppItem(
                'Developed By',
                'Peninsular Government of Malaysia',
              ),
              _buildAboutAppItem('Last Updated', 'August 2023'),
              const SizedBox(height: 16),
              const Text(
                'This official app allows forestry permit holders to manage their permits and access government services.',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutAppItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(value, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
