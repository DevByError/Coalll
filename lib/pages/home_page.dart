import 'package:coalll/pages/SettingsPage.dart';
import 'package:coalll/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../auth/auth_service.dart';
import 'main_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'notifications_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 400;

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Confirm Logout',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 18 : 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 16 : 24),
                  Text(
                    'Are you sure you want to logout?',
                    style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isSmallScreen ? 24 : 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 10 : 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: isSmallScreen ? 12 : 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 10 : 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => _performLogout(context),
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showQRScanner(BuildContext context) async {
    // Check camera permission status
    final cameraStatus = await Permission.camera.status;

    if (!cameraStatus.isGranted) {
      // Request permission if not granted
      final result = await Permission.camera.request();

      if (result != PermissionStatus.granted) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Camera permission is required to scan QR codes'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }
    }

    final scannedValue = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => const QRScannerPage(),
        fullscreenDialog: true,
      ),
    );

    if (scannedValue != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Scanned: $scannedValue'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _performLogout(BuildContext context) async {
    try {
      // Perform logout first
      await Provider.of<AuthService>(context, listen: false).signOut();

      // Then close the dialog and navigate to login page
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        // Only pop the dialog if there's an error (to show the error message)
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        final iconSize = isTablet ? 32.0 : 28.0;
        final fontSize = isTablet ? 14.0 : 12.0;
        final appBarIconSize = isTablet ? 28.0 : 24.0;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black87,
            elevation: 4,
            title: Text(
              'Home Page',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: isTablet ? 24 : 20,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.red,
                size: appBarIconSize,
              ),
              onPressed: () => _showLogoutConfirmation(context),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: isTablet ? 20.0 : 12.0),
                child: IconButton(
                  icon: Stack(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: appBarIconSize,
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: isTablet ? 14 : 12,
                            minHeight: isTablet ? 14 : 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationsPage(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: const MainPage(),
          bottomNavigationBar: _buildBottomAppBar(
            context,
            isTablet,
            iconSize,
            fontSize,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green[700],
            elevation: 8,
            onPressed: () => _showQRScanner(context),
            child: Icon(
              Icons.qr_code_scanner,
              size: isTablet ? 36 : 30,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }

  Widget _buildBottomAppBar(
    BuildContext context,
    bool isTablet,
    double iconSize,
    double fontSize,
  ) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomAppBar(
            color: Colors.black87,
            padding: EdgeInsets.zero,
            shape: const CircularNotchedRectangle(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: isTablet ? 8.0 : 6.0,
                horizontal: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.home, color: Colors.white, size: iconSize),
                        SizedBox(height: isTablet ? 4 : 2),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(width: isTablet ? 60 : 40),
                  IconButton(
                    icon: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: iconSize,
                        ),
                        SizedBox(height: isTablet ? 4 : 2),
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isScanning = true;
  bool _isTorchOn = false;
  bool _isBackCamera = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (!_isScanning || !mounted) return;

    final barcode = barcodes.barcodes.firstOrNull;
    if (barcode == null) return;

    setState(() => _isScanning = false);

    Navigator.of(context).pop(barcode.rawValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            icon: Icon(
              _isTorchOn ? Icons.flash_on : Icons.flash_off,
              color: _isTorchOn ? Colors.yellow : Colors.white,
            ),
            onPressed: () {
              setState(() => _isTorchOn = !_isTorchOn);
              _controller.toggleTorch();
            },
          ),
          IconButton(
            icon: Icon(
              _isBackCamera ? Icons.camera_rear : Icons.camera_front,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() => _isBackCamera = !_isBackCamera);
              _controller.switchCamera();
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(controller: _controller, onDetect: _handleBarcode),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: Text(
                  'Align QR code within the frame',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
