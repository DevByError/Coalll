import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class LicenseApplicationPage extends StatefulWidget {
  const LicenseApplicationPage({super.key});

  @override
  State<LicenseApplicationPage> createState() => _LicenseApplicationPageState();
}

class _LicenseApplicationPageState extends State<LicenseApplicationPage> {
  String? _selectedLicenseType;
  final Map<String, List<String>> _requirements = {
    'Form 1 – Major License': [
      'Registered Logging Contractor',
      'Approved Forest Harvesting Plan',
      'Environmental Impact Assessment (EIA)',
      'Deposit & Royalty Payment',
      'Marking Trees',
      'Compliance with RIL (Reduced Impact Logging)',
      'Log Transit Documentation',
      'Regular Inspections',
    ],
    'Form 3 – Minor License': [
      'Area size limitation',
      'Registered individual or company',
      'Basic Harvesting Plan',
      'Payment of Royalty and Deposit',
      'No major machinery',
      'Shorter Duration',
      'Subject to Field Checks',
    ],
    'Form 5 – Removal License': [
      'Proof of Land Ownership or Land Lease Agreement',
      'Timber List (Inventory)',
      'Application to District Forest Office',
      'Royalty Payment',
      'Inspection by Forest Officers',
      'Transit Passes for Transport',
    ],
  };

  final List<Map<String, dynamic>> _documentStatus = [];
  bool _isSubmitting = false;

  // Color scheme with shades of orange
  final Color primaryOrange = const Color(0xFFE65100);
  final Color mediumOrange = const Color(0xFFEF6C00);
  final Color lightOrange = const Color(0xFFF57C00);
  final Color backgroundOrange = const Color(0xFFFFF3E0);
  final Color darkOrange = const Color(0xFFBF360C);

  Color _getCardColor(String licenseType) {
    switch (licenseType) {
      case 'Form 1 – Major License':
        return primaryOrange;
      case 'Form 3 – Minor License':
        return mediumOrange;
      case 'Form 5 – Removal License':
        return lightOrange;
      default:
        return primaryOrange;
    }
  }

  Future<void> _uploadDocument(int index) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
      );

      if (result != null) {
        setState(() {
          _documentStatus[index]['uploaded'] = true;
          _documentStatus[index]['file'] = result.files.single;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading file: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showSubmissionDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 16),
              Text(
                'Application Submitted!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Your license application has been submitted successfully. '
                'You will receive a notification when it is processed.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _getCardColor(_selectedLicenseType!),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'DONE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizing
    final double horizontalPadding = screenWidth * 0.04;
    final double verticalPadding = screenHeight * 0.02;
    final double titleFontSize = screenHeight * 0.025;
    final double cardTitleFontSize = screenHeight * 0.022;
    final double bodyFontSize = screenHeight * 0.018;
    final double buttonHeight = screenHeight * 0.065;
    final double smallSpacing = screenHeight * 0.01;
    final double mediumSpacing = screenHeight * 0.02;
    final double largeSpacing = screenHeight * 0.03;
    final double borderRadius = screenWidth * 0.02;
    final double iconSize = screenHeight * 0.03;
    final double cardElevation = screenWidth * 0.005;
    final double listTileIconSize = screenHeight * 0.022;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'License Application',
          style: TextStyle(
            color: Colors.white,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryOrange,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: iconSize),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(borderRadius),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [backgroundOrange, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              verticalPadding,
              horizontalPadding,
              verticalPadding * 1.5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // License Type Selection Card
                Card(
                  elevation: cardElevation * 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  shadowColor: primaryOrange.withOpacity(0.3),
                  child: Padding(
                    padding: EdgeInsets.all(horizontalPadding * 1.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'License Type',
                          style: TextStyle(
                            fontSize: cardTitleFontSize,
                            fontWeight: FontWeight.bold,
                            color: darkOrange,
                          ),
                        ),
                        SizedBox(height: smallSpacing),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(
                              borderRadius / 2,
                            ),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: _selectedLicenseType,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: bodyFontSize,
                              color: Colors.grey[800],
                            ),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: primaryOrange,
                            ),
                            items:
                                [
                                  'Form 1 – Major License',
                                  'Form 3 – Minor License',
                                  'Form 5 – Removal License',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        color: _getCardColor(value),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedLicenseType = newValue;
                                _documentStatus.clear();
                                if (newValue != null) {
                                  for (var doc in _requirements[newValue]!) {
                                    _documentStatus.add({
                                      'name': doc,
                                      'uploaded': false,
                                      'file': null,
                                    });
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: mediumSpacing),

                if (_selectedLicenseType != null) ...[
                  // Requirements Section
                  Card(
                    elevation: cardElevation * 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: EdgeInsets.all(horizontalPadding),
                            color: _getCardColor(_selectedLicenseType!),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.list_alt,
                                  color: Colors.white,
                                  size: iconSize * 0.9,
                                ),
                                SizedBox(width: smallSpacing),
                                Expanded(
                                  // Added Expanded to prevent overflow
                                  child: Text(
                                    'Requirements for $_selectedLicenseType',
                                    style: TextStyle(
                                      fontSize: cardTitleFontSize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(horizontalPadding),
                            child: Column(
                              children: [
                                ..._documentStatus.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final doc = entry.value;
                                  return Column(
                                    children: [
                                      if (index > 0) Divider(height: 1),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          doc['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: bodyFontSize,
                                          ),
                                        ),
                                        trailing: doc['uploaded']
                                            ? IconButton(
                                                icon: Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                  size: listTileIconSize * 1.2,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    doc['uploaded'] = false;
                                                    doc['file'] = null;
                                                  });
                                                },
                                              )
                                            : ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      _getCardColor(
                                                        _selectedLicenseType!,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          borderRadius * 2,
                                                        ),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        horizontalPadding * 0.8,
                                                  ),
                                                ),
                                                onPressed: () =>
                                                    _uploadDocument(index),
                                                child: Text(
                                                  'Upload',
                                                  style: TextStyle(
                                                    fontSize:
                                                        bodyFontSize * 0.9,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: largeSpacing),

                  // Uploaded Documents Section
                  if (_documentStatus.any((doc) => doc['uploaded'])) ...[
                    Card(
                      elevation: cardElevation * 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(horizontalPadding * 1.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.cloud_done,
                                  color: _getCardColor(_selectedLicenseType!),
                                  size: iconSize * 0.9,
                                ),
                                SizedBox(width: smallSpacing),
                                Text(
                                  'Uploaded Documents',
                                  style: TextStyle(
                                    fontSize: cardTitleFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: darkOrange,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: smallSpacing),
                            ..._documentStatus
                                .where((doc) => doc['uploaded'])
                                .map((doc) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: smallSpacing / 2,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: listTileIconSize,
                                        ),
                                        SizedBox(width: smallSpacing),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                doc['name'],
                                                style: TextStyle(
                                                  fontSize: bodyFontSize,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                doc['file']?.name ?? 'Document',
                                                style: TextStyle(
                                                  fontSize: bodyFontSize * 0.85,
                                                  color: Colors.grey,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.visibility,
                                            color: _getCardColor(
                                              _selectedLicenseType!,
                                            ),
                                            size: listTileIconSize,
                                          ),
                                          onPressed: () {
                                            // TODO: Implement document preview
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                })
                                .toList(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: largeSpacing),
                  ],

                  // Progress Indicator
                  LinearProgressIndicator(
                    value: _selectedLicenseType == null
                        ? 0
                        : _documentStatus
                                  .where((doc) => doc['uploaded'])
                                  .length /
                              _documentStatus.length,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getCardColor(_selectedLicenseType!),
                    ),
                    minHeight: 6,
                  ),
                  SizedBox(height: mediumSpacing),
                  Text(
                    'Completion: ${((_selectedLicenseType == null ? 0 : _documentStatus.where((doc) => doc['uploaded']).length / _documentStatus.length) * 100).toStringAsFixed(0)}%',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: bodyFontSize,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: largeSpacing),

                  // Submit Button
                  SizedBox(
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed:
                          _documentStatus.isNotEmpty &&
                              _documentStatus.every((doc) => doc['uploaded']) &&
                              !_isSubmitting
                          ? () async {
                              setState(() => _isSubmitting = true);
                              await Future.delayed(const Duration(seconds: 2));
                              setState(() => _isSubmitting = false);
                              _showSubmissionDialog();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getCardColor(_selectedLicenseType!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius * 2),
                        ),
                        elevation: cardElevation * 3,
                        shadowColor: _getCardColor(
                          _selectedLicenseType!,
                        ).withOpacity(0.5),
                      ),
                      child: _isSubmitting
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'SUBMIT APPLICATION',
                              style: TextStyle(
                                fontSize: bodyFontSize * 1.1,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ] else ...[
                  // Empty State when no license is selected
                  Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.1),
                    child: Column(
                      children: [
                        Icon(
                          Icons.description,
                          size: screenWidth * 0.2,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        SizedBox(height: mediumSpacing),
                        Text(
                          'Select a License Type to Begin',
                          style: TextStyle(
                            fontSize: bodyFontSize * 1.2,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
