import 'package:coalll/pages/license_application_page.dart';
import 'package:flutter/material.dart';

class LicenseInfoPage extends StatelessWidget {
  const LicenseInfoPage({super.key});

  // Green color scheme
  final Color primaryGreen = const Color(0xFF2E7D32);
  final Color mediumGreen = const Color(0xFF43A047);
  final Color lightGreen = const Color.fromARGB(255, 102, 206, 107);
  final Color backgroundColor = const Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizing calculations
    final smallSpacing = screenHeight * 0.015;
    final titleFontSize = screenHeight * 0.028;
    final iconSize = screenHeight * 0.035;
    final borderRadius = screenWidth * 0.025;
    final tabFontSize = screenHeight * 0.02;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'License Information',
            style: TextStyle(
              color: Colors.white,
              fontSize: titleFontSize * 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: primaryGreen,
          leading: Container(
            margin: EdgeInsets.all(smallSpacing * 0.8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: iconSize),
              onPressed: () => Navigator.of(context).pop(),
              padding: EdgeInsets.zero,
              splashRadius: iconSize * 0.8,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight * 0.08),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(borderRadius * 0.8),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white.withOpacity(0.8),
                    labelStyle: TextStyle(
                      fontSize: tabFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: TextStyle(fontSize: tabFontSize),
                    tabs: const [
                      Tab(text: 'Form 1'),
                      Tab(text: 'Form 3'),
                      Tab(text: 'Form 5'),
                    ],
                  ),
                ),
                SizedBox(height: smallSpacing * 0.5),
              ],
            ),
          ),
          elevation: 0,
          shadowColor: primaryGreen.withOpacity(0.3),
        ),
        body: Container(
          decoration: BoxDecoration(color: backgroundColor),
          child: SafeArea(
            bottom: true,
            child: TabBarView(
              children: [
                _LicenseInfoTab(
                  title: 'Major License (Lesen Utama)',
                  description:
                      'Issued for large-scale timber harvesting operations, especially on Permanent Reserved Forest (PRF) land.',
                  requirements: [
                    'Registered Logging Contractor – must be approved by the State Forestry Department.',
                    'Approved Forest Harvesting Plan – includes coupe boundaries, estimated volume, species, and logging method.',
                    'Environmental Impact Assessment (EIA) – required if the area exceeds 500 hectares or if it\'s in a sensitive area.',
                    'Deposit & Royalty Payment – upfront deposit and timber royalties must be paid based on volume.',
                    'Marking Trees – trees to be felled must be marked and approved.',
                    'Compliance with RIL (Reduced Impact Logging) techniques in many states.',
                    'Log Transit Documentation – logs must carry serial tags and removal passes.',
                    'Regular Inspections – subject to compliance audits by the District Forest Office.',
                  ],
                  cardColor: primaryGreen,
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  icon: Icons.forest,
                ),
                _LicenseInfoTab(
                  title: 'Minor License (Lesen Kecil)',
                  description:
                      'For small-scale harvesting, typically on state land or for special purposes like community use or infrastructure development.',
                  requirements: [
                    'Area size limitation – typically under 100 hectares.',
                    'Registered individual or company – must still be approved for harvesting.',
                    'Basic Harvesting Plan – shorter and less comprehensive than for Form 1.',
                    'Payment of Royalty and Deposit – based on projected yield.',
                    'No major machinery – often limited to manual or semi-mechanized logging.',
                    'Shorter Duration – usually valid for under 1 year.',
                    'Subject to Field Checks – especially at entry/exit points of the forest.',
                  ],
                  cardColor: mediumGreen,
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  icon: Icons.agriculture,
                ),
                _LicenseInfoTab(
                  title: 'Removal License (Lesen Pemindahan)',
                  description:
                      'Used when removing timber or charcoal from private land or land not under PRF. This is the most common license used by landowners or private charcoal producers.',
                  requirements: [
                    'Proof of Land Ownership or Land Lease Agreement – required to show legal right to the land.',
                    'Timber List (Inventory) – estimation of quantity and species of trees to be removed.',
                    'Application to District Forest Office – including GPS boundaries of the land.',
                    'Royalty Payment – may still apply depending on species and volume.',
                    'Inspection by Forest Officers – before removal begins.',
                    'Transit Passes for Transport – to legally move timber or charcoal on roads.',
                  ],
                  cardColor: lightGreen,
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  icon: Icons.local_shipping,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LicenseInfoTab extends StatelessWidget {
  final String title;
  final String description;
  final List<String> requirements;
  final Color cardColor;
  final double screenHeight;
  final double screenWidth;
  final IconData icon;

  const _LicenseInfoTab({
    required this.title,
    required this.description,
    required this.requirements,
    required this.cardColor,
    required this.screenHeight,
    required this.screenWidth,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive sizing calculations
    final smallSpacing = screenHeight * 0.015;
    final mediumSpacing = screenHeight * 0.025;
    final largeSpacing = screenHeight * 0.035;
    final horizontalPadding = screenWidth * 0.05;
    final verticalPadding = screenHeight * 0.025;
    final titleFontSize = screenHeight * 0.028;
    final bodyFontSize = screenHeight * 0.02;
    final buttonHeight = screenHeight * 0.07;
    final borderRadius = screenWidth * 0.025;
    final cardPadding = screenWidth * 0.05;
    final iconSize = screenHeight * 0.04;

    return Padding(
      padding: EdgeInsets.only(bottom: verticalPadding),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card with Icon
            Card(
              color: cardColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Padding(
                padding: EdgeInsets.all(cardPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(smallSpacing),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, size: iconSize, color: Colors.white),
                    ),
                    SizedBox(width: smallSpacing * 1.5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: titleFontSize * 1.1,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: smallSpacing * 0.5),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: bodyFontSize,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: mediumSpacing),

            // Requirements Section
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: smallSpacing,
                vertical: smallSpacing * 0.5,
              ),
              decoration: BoxDecoration(
                color: cardColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(borderRadius * 0.5),
              ),
              child: Text(
                'REQUIREMENTS',
                style: TextStyle(
                  fontSize: bodyFontSize * 0.9,
                  fontWeight: FontWeight.w600,
                  color: cardColor,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(height: smallSpacing),

            // Requirements List
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Padding(
                padding: EdgeInsets.all(cardPadding * 0.8),
                child: Column(
                  children: [
                    ...requirements.map(
                      (requirement) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: smallSpacing * 0.8,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: smallSpacing * 0.3),
                              width: screenWidth * 0.04,
                              height: screenWidth * 0.04,
                              decoration: BoxDecoration(
                                color: cardColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: smallSpacing * 1.2),
                            Expanded(
                              child: Text(
                                requirement,
                                style: TextStyle(
                                  fontSize: bodyFontSize,
                                  height: 1.5,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: largeSpacing),

            // Application Button
            Center(
              child: SizedBox(
                width: double.infinity,
                height: buttonHeight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LicenseApplicationPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cardColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding * 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    elevation: 3,
                    shadowColor: cardColor.withOpacity(0.4),
                  ),
                  icon: Icon(
                    Icons.edit_document,
                    size: iconSize * 0.8,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Apply for this License',
                    style: TextStyle(
                      fontSize: bodyFontSize * 1.1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Additional Info Section
            SizedBox(height: largeSpacing),
            Container(
              padding: EdgeInsets.all(cardPadding * 0.8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: iconSize * 0.8,
                        color: cardColor,
                      ),
                      SizedBox(width: smallSpacing),
                      Text(
                        'Need Help?',
                        style: TextStyle(
                          fontSize: bodyFontSize * 1.1,
                          fontWeight: FontWeight.w600,
                          color: cardColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: smallSpacing),
                  Text(
                    'For more information about license requirements and application process, please contact your local forestry department office.',
                    style: TextStyle(
                      fontSize: bodyFontSize,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: smallSpacing * 0.5),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement contact functionality
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Contact Support →',
                      style: TextStyle(
                        fontSize: bodyFontSize,
                        fontWeight: FontWeight.w600,
                        color: cardColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
