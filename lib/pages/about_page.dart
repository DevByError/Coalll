import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  // Animation controllers
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  // Partners variables
  late final AnimationController _carouselController;
  int _currentIndex = 0;
  bool _showAllPartners = false;
  final List<String> _partnerImages = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
    'assets/6.png',
    'assets/7.png',
    'assets/8.png',
    'assets/9.png',
    'assets/10.png',
    'assets/11.png',
    'assets/12.png',
    'assets/13.png',
    'assets/13.gif',
    'assets/14.png',
    'assets/15.png',
    'assets/16.png',
    'assets/17.png',
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Initialize carousel controller
    _carouselController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Start animations after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
      _startCarousel();
    });
  }

  void _startCarousel() {
    _carouselController.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_showAllPartners) {
        setState(() {
          _currentIndex = (_currentIndex + 3) % _partnerImages.length;
        });
        _carouselController.reset();
        _carouselController.forward();
      }
    });
    _carouselController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _carouselController.dispose();
    super.dispose();
  }

  void _toggleShowAllPartners() {
    setState(() {
      _showAllPartners = !_showAllPartners;
      if (_showAllPartners) {
        _carouselController.stop();
      } else {
        _startCarousel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait = screenSize.height > screenSize.width;

    // Theme and colors
    final ThemeData theme = Theme.of(context);
    const Color primaryColor = Color(0xFFF64A8A);
    const Color secondaryColor = Color(0xFFC2185B);
    const Color lightBackground = Color(0xFFFEE5EC);
    final Color textColor =
        theme.textTheme.bodyLarge?.color ?? Colors.grey.shade800;

    // Responsive dimensions
    final EdgeInsets pagePadding = EdgeInsets.symmetric(
      horizontal: screenSize.width * 0.04,
      vertical: screenSize.height * 0.02,
    );

    final double titleFontSize = isPortrait
        ? screenSize.height * 0.028
        : screenSize.height * 0.04;

    final double bodyFontSize = isPortrait
        ? screenSize.height * 0.018
        : screenSize.height * 0.025;

    final double iconSize = screenSize.height * 0.03;
    final double borderRadius = 12.0;
    final double cardElevation = 4.0;

    return Scaffold(
      backgroundColor: lightBackground,
      appBar: _buildAppBar(
        titleFontSize: titleFontSize,
        iconSize: iconSize,
        padding: pagePadding,
        primaryColor: primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Section
              _buildHeroSection(
                titleFontSize: titleFontSize,
                bodyFontSize: bodyFontSize,
                primaryColor: primaryColor,
                textColor: textColor,
                borderRadius: borderRadius,
              ),
              const SizedBox(height: 24),

              // Mission Section
              _buildSectionCard(
                title: 'Our Mission',
                content:
                    'To modernize and streamline forestry operations in Malaysia through digital innovation, '
                    'ensuring sustainable practices while supporting the livelihoods of those in the forestry sector.',
                icon: Icons.flag,
                color: primaryColor,
                borderRadius: borderRadius,
                cardElevation: cardElevation,
                iconSize: iconSize,
                titleFontSize: titleFontSize,
                bodyFontSize: bodyFontSize,
              ),
              const SizedBox(height: 24),

              // Climate Section
              _buildSectionCard(
                title: 'The climate belongs\n to all of us',
                content:
                    'Climate change is a threat to life all over the world. '
                    'Heat waves or storms, droughts or floods, less biodiversity and food shortages, '
                    'it will affect us all. We are all in the same boat.\n\n'
                    'We are organisations from all over Dutch society, coming together for the climate. '
                    'Because climate change is not only an issue for nature and environmental organisations. '
                    'The climate belongs to all of us and is the responsibility of everyone.\n\n'
                    'Fortunately, it\'s not too late. Climate change can be stopped, the solutions already exist '
                    'and we know exactly what needs to be done. It requires enormous effort and difficult choices, '
                    'but there are also great opportunities for a greener and fairer world. The world our children '
                    'and grandchildren deserve. Citizens, local authorities and companies are already taking the '
                    'initiative towards fewer emissions and a more sustainable lifestyle, but not everyone can or '
                    'wants to join.\n\n'
                    'The government must therefore take the lead and make the necessary hard choices in which people '
                    'and nature are central and the polluter pays. This has never happened before. Although the Dutch '
                    'government has recently taken steps to help diminish climate change, those steps are not nearly '
                    'enough. This approach is not going to save our beautiful world.\n\n'
                    'Public action is therefore desperately needed to underline the urgency of the situation. School '
                    'strikes, protests, marches - everything that might motivate the government to take serious '
                    'measures against further climate change deserves our support.\n\n'
                    'That is why we support the global Climate Actions which, due to the current COVID-19 crisis, '
                    'will take place online instead of in the streets on Friday April 3rd, and ask everyone to '
                    'participate and share on social media. We call on the government to listen carefully to the '
                    'high school and university students, concerned grandfathers and grandmothers, strikers, '
                    'animal protectors, scientists and all those other people who unite for the .',
                icon: Icons.remove_red_eye,
                color: const Color.fromARGB(255, 212, 17, 95),
                borderRadius: borderRadius,
                cardElevation: cardElevation,
                iconSize: iconSize,
                titleFontSize: titleFontSize,
                bodyFontSize: bodyFontSize,
              ),
              const SizedBox(height: 24),

              _buildSectionCard(
                title: 'Our Vision',
                content:
                    'A future where Malaysia\'s forests are managed sustainably with full transparency, '
                    'where technology empowers both conservation efforts and the forestry industry.',
                icon: Icons.public,
                color: secondaryColor,
                borderRadius: borderRadius,
                cardElevation: cardElevation,
                iconSize: iconSize,
                titleFontSize: titleFontSize,
                bodyFontSize: bodyFontSize,
              ),

              // Partners Section
              _buildPartnersSection(
                titleFontSize: titleFontSize,
                bodyFontSize: bodyFontSize,
                primaryColor: primaryColor,
                textColor: textColor,
                iconSize: iconSize,
                borderRadius: borderRadius,
              ),
              const SizedBox(height: 24),

              // Contact Section
              _buildContactSection(
                titleFontSize: titleFontSize,
                bodyFontSize: bodyFontSize,
                primaryColor: primaryColor,
                iconSize: iconSize,
                borderRadius: borderRadius,
                cardElevation: cardElevation,
              ),
              const SizedBox(height: 24),

              // Footer
              Center(
                child: Text(
                  '© ${DateTime.now().year} Forestry Digital Solutions. All rights reserved.',
                  style: TextStyle(
                    fontSize: bodyFontSize * 0.8,
                    color: textColor.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar({
    required double titleFontSize,
    required double iconSize,
    required EdgeInsets padding,
    required Color primaryColor,
  }) {
    return AppBar(
      title: Center(
        child: Text(
          'About Us',
          style: TextStyle(
            fontSize: titleFontSize * 0.9,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      leading: Container(
        margin: EdgeInsets.only(left: padding.left),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back, size: iconSize),
          color: primaryColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  Widget _buildHeroSection({
    required double titleFontSize,
    required double bodyFontSize,
    required Color primaryColor,
    required Color textColor,
    required double borderRadius,
  }) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: primaryColor.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forestry Digital Solutions',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Transforming Malaysia\'s forestry sector through innovative technology',
                style: TextStyle(
                  fontSize: bodyFontSize,
                  color: textColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String content,
    required IconData icon,
    required Color color,
    required double borderRadius,
    required double cardElevation,
    required double iconSize,
    required double titleFontSize,
    required double bodyFontSize,
  }) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Card(
          elevation: cardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Padding(
            padding: EdgeInsets.all(borderRadius * 1.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: iconSize, color: color),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: bodyFontSize,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPartnersSection({
    required double titleFontSize,
    required double bodyFontSize,
    required Color primaryColor,
    required Color textColor,
    required double iconSize,
    required double borderRadius,
  }) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.handshake, size: iconSize, color: primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Our Partners',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'We collaborate with leading organizations in forestry and conservation:',
              style: TextStyle(fontSize: bodyFontSize, color: textColor),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _toggleShowAllPartners,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: _showAllPartners
                    ? _buildAllPartnersGrid()
                    : _buildAutoRotatingPartners(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoRotatingPartners() {
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Show 3 partners at a time
          for (int i = 0; i < 3; i++)
            if (_partnerImages.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: PartnerLogo(
                    imagePath:
                        _partnerImages[(_currentIndex + i) %
                            _partnerImages.length],
                    isSpecial: i == 1, // Make the middle one special
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildAllPartnersGrid() {
    return Column(
      children: [
        // Main partner (current index)
        if (_partnerImages.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Featured Partner',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
          ),
          PartnerLogo(
            imagePath: _partnerImages[_currentIndex % _partnerImages.length],
            isSpecial: true,
            isLarge: true,
          ),
          const SizedBox(height: 24),
        ],

        Text(
          'All Our Partners',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: _partnerImages.asMap().entries.map((entry) {
            if (entry.key == _currentIndex % _partnerImages.length) {
              return const SizedBox.shrink(); // Skip the featured one
            }
            return PartnerLogo(imagePath: entry.value);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildContactSection({
    required double titleFontSize,
    required double bodyFontSize,
    required Color primaryColor,
    required double iconSize,
    required double borderRadius,
    required double cardElevation,
  }) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.contact_mail, size: iconSize, color: primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Contact Information',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Card(
              elevation: cardElevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              color: Colors.white,
              child: Column(
                children: [
                  _buildContactTile(
                    icon: Icons.email,
                    title: 'General Inquiries',
                    subtitle: 'info@forestry.gov.my',
                    color: primaryColor,
                    iconSize: iconSize,
                    bodyFontSize: bodyFontSize,
                  ),
                  const Divider(height: 1, color: Colors.grey),
                  _buildContactTile(
                    icon: Icons.phone,
                    title: 'Support Hotline',
                    subtitle: '+603-1234 5678',
                    color: primaryColor,
                    iconSize: iconSize,
                    bodyFontSize: bodyFontSize,
                  ),
                  const Divider(height: 1, color: Colors.grey),
                  _buildContactTile(
                    icon: Icons.location_on,
                    title: 'Headquarters',
                    subtitle: 'Jalan Sultan Salahuddin\n50660 Kuala Lumpur',
                    color: primaryColor,
                    iconSize: iconSize,
                    bodyFontSize: bodyFontSize,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required double iconSize,
    required double bodyFontSize,
  }) {
    return ListTile(
      leading: Icon(icon, size: iconSize, color: color),
      title: Text(
        title,
        style: TextStyle(fontSize: bodyFontSize, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle, style: TextStyle(fontSize: bodyFontSize * 0.9)),
    );
  }
}

class PartnerLogo extends StatelessWidget {
  final String imagePath;
  final bool isSpecial;
  final bool isLarge;

  const PartnerLogo({
    super.key,
    required this.imagePath,
    this.isSpecial = false,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFF64A8A);
    const lightBackground = Color(0xFFFEE5EC);

    return Container(
      width: isLarge
          ? 150
          : isSpecial
          ? 100
          : 80,
      height: isLarge
          ? 150
          : isSpecial
          ? 100
          : 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSpecial ? primaryColor.withOpacity(0.1) : lightBackground,
        border: Border.all(
          color: isSpecial ? primaryColor : primaryColor.withOpacity(0.3),
          width: isSpecial ? 2 : 1,
        ),
        boxShadow: [
          if (isSpecial)
            BoxShadow(
              color: primaryColor.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: imagePath.endsWith('.gif')
            ? Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholder(),
              )
            : Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholder(),
              ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return const Center(
      child: Icon(Icons.business, size: 40, color: Colors.grey),
    );
  }
}
