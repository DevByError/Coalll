import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String? _selectedPaymentMethod;
  String? _selectedBank;
  File? _receiptImage;
  bool _isSubmitting = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> _banks = [
    'Maybank (Most popular - 60% of users)',
    'CIMB Bank (25% of transactions)',
    'Public Bank (Trusted by 15% of applicants)',
    'RHB Bank (Fast processing)',
    'Hong Leong Bank (Recommended)',
    'AmBank',
    'Bank Islam (Shariah-compliant)',
    'Bank Rakyat (Popular for government services)',
    'BSN (Basic banking)',
    'Affin Bank',
  ];

  final Map<String, String> _paymentMethodStats = {
    'Bank Transfer':
        'Used by 72% of applicants\nAverage processing: 1-2 business days',
    'Credit Card':
        'Used by 23% of applicants\nInstant approval\nVisa/Mastercard accepted',
    'E-Wallet':
        'Used by 5% of applicants\nFastest option\nSupported: Touch \'n Go, GrabPay, Boost',
  };

  final Map<String, Color> _paymentMethodColors = {
    'Bank Transfer': Colors.blue,
    'Credit Card': Colors.green,
    'E-Wallet': Colors.orange,
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickReceiptImage() async {
    // Simulate image picker functionality
    setState(() {
      _receiptImage = File('dummy_path');
    });
  }

  Future<void> _submitPayment() async {
    if (_receiptImage == null) return;

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Payment submitted successfully'),
        backgroundColor: Colors.purple[800],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    setState(() => _isSubmitting = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.purple[800]!;
    final Color backgroundColor = Colors.grey[50]!;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Define percentage-based dimensions
    final double paddingHorizontal = screenWidth * 0.04;
    final double paddingVertical = screenHeight * 0.02;
    final double titleFontSize = screenHeight * 0.025;
    final double amountFontSize = screenHeight * 0.03;
    final double buttonHeight = screenHeight * 0.065;
    final double receiptContainerHeight = screenHeight * 0.2;
    final double spacingSmall = screenHeight * 0.01;
    final double spacingMedium = screenHeight * 0.02;
    final double spacingLarge = screenHeight * 0.03;
    final double chipSpacing = screenWidth * 0.02;
    final double iconSize = screenHeight * 0.03;
    final double cardPadding = screenWidth * 0.04;
    final double dropdownItemHeight = screenHeight * 0.06;
    final double backButtonSize = screenHeight * 0.05;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(
          'Payment',
          style: TextStyle(
            color: Colors.white,
            fontSize: titleFontSize * 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(screenWidth * 0.02),
          width: backButtonSize,
          height: backButtonSize,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.arrow_back, size: iconSize, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Container(
        color: backgroundColor,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal,
              vertical: paddingVertical,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Payment method section
                _buildSectionHeader('Select Payment Method', titleFontSize),
                SizedBox(height: spacingMedium),

                // Payment method chips
                Wrap(
                  spacing: chipSpacing,
                  runSpacing: chipSpacing,
                  children: [
                    _buildPaymentOption(
                      'Bank Transfer',
                      Icons.account_balance,
                      primaryColor,
                      iconSize,
                    ),
                    _buildPaymentOption(
                      'Credit Card',
                      Icons.credit_card,
                      primaryColor,
                      iconSize,
                    ),
                    _buildPaymentOption(
                      'E-Wallet',
                      Icons.wallet,
                      primaryColor,
                      iconSize,
                    ),
                  ],
                ),

                // Payment method stats
                if (_selectedPaymentMethod != null) ...[
                  SizedBox(height: spacingMedium),
                  _buildStatsCard(
                    _paymentMethodStats[_selectedPaymentMethod]!,
                    _paymentMethodColors[_selectedPaymentMethod]!,
                    titleFontSize,
                    cardPadding,
                    screenWidth,
                  ),
                ],

                // Bank transfer section
                if (_selectedPaymentMethod == 'Bank Transfer') ...[
                  SizedBox(height: spacingLarge),
                  _buildBankTransferSection(
                    titleFontSize,
                    spacingSmall,
                    spacingMedium,
                    dropdownItemHeight,
                    cardPadding,
                    primaryColor,
                    iconSize,
                    screenWidth,
                  ),
                ],

                // Credit card section
                if (_selectedPaymentMethod == 'Credit Card') ...[
                  SizedBox(height: spacingMedium),
                  _buildCreditCardSection(
                    titleFontSize,
                    spacingMedium,
                    spacingSmall,
                    cardPadding,
                    primaryColor,
                    screenWidth,
                  ),
                ],

                // E-wallet section
                if (_selectedPaymentMethod == 'E-Wallet') ...[
                  SizedBox(height: spacingMedium),
                  _buildEWalletSection(
                    titleFontSize,
                    spacingMedium,
                    cardPadding,
                    screenWidth,
                  ),
                ],

                // Amount and receipt section
                if (_selectedPaymentMethod != null) ...[
                  SizedBox(height: spacingLarge),
                  _buildAmountCard(
                    titleFontSize,
                    amountFontSize,
                    spacingSmall,
                    cardPadding,
                    primaryColor,
                  ),

                  SizedBox(height: spacingLarge),
                  _buildReceiptUploadSection(
                    titleFontSize,
                    spacingSmall,
                    receiptContainerHeight,
                    iconSize,
                    primaryColor,
                    screenWidth,
                  ),

                  SizedBox(height: spacingLarge * 1.5),
                  _buildSubmitButton(
                    buttonHeight,
                    titleFontSize,
                    primaryColor,
                    screenWidth,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildStatsCard(
    String text,
    Color color,
    double fontSize,
    double padding,
    double screenWidth,
  ) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: fontSize * 0.8),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPaymentOption(
    String title,
    IconData icon,
    Color primaryColor,
    double iconSize,
  ) {
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: _selectedPaymentMethod == title
                ? Colors.white
                : _paymentMethodColors[title],
          ),
          SizedBox(width: iconSize * 0.25),
          Text(
            title,
            style: TextStyle(
              color: _selectedPaymentMethod == title
                  ? Colors.white
                  : _paymentMethodColors[title],
              fontSize: iconSize * 0.8,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      selected: _selectedPaymentMethod == title,
      selectedColor: _paymentMethodColors[title],
      backgroundColor: Colors.white,
      side: BorderSide(color: _paymentMethodColors[title]!),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(iconSize * 1.5),
      ),
      onSelected: (selected) {
        setState(() {
          _selectedPaymentMethod = selected ? title : null;
          _selectedBank = null;
          _receiptImage = null;
        });
        _animationController.reset();
        _animationController.forward();
      },
    );
  }

  Widget _buildBankTransferSection(
    double titleFontSize,
    double spacingSmall,
    double spacingMedium,
    double dropdownItemHeight,
    double cardPadding,
    Color primaryColor,
    double iconSize,
    double screenWidth,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader('Select Bank:', titleFontSize),
        SizedBox(height: spacingSmall),

        Container(
          height: dropdownItemHeight * 1.5,
          padding: EdgeInsets.symmetric(horizontal: cardPadding * 0.5),
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            color: Colors.white,
          ),
          child: DropdownButton<String>(
            value: _selectedBank,
            isExpanded: true,
            underline: const SizedBox(),
            icon: Icon(
              Icons.arrow_drop_down,
              size: iconSize,
              color: primaryColor,
            ),
            style: TextStyle(
              color: Colors.black87,
              fontSize: titleFontSize * 0.8,
            ),
            hint: Text(
              'Choose your bank',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: titleFontSize * 0.8,
              ),
            ),
            items: _banks.map((String bank) {
              return DropdownMenuItem<String>(
                value: bank,
                child: Text(bank, overflow: TextOverflow.ellipsis, maxLines: 1),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedBank = newValue;
              });
            },
          ),
        ),

        SizedBox(height: spacingMedium),
        _buildSectionHeader('Bank Account Details:', titleFontSize),
        SizedBox(height: spacingSmall),

        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            side: BorderSide(color: primaryColor.withOpacity(0.1)),
          ),
          child: Padding(
            padding: EdgeInsets.all(cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(
                  'Account Name:',
                  'Forestry Department of Malaysia',
                  titleFontSize,
                ),
                SizedBox(height: spacingSmall),
                _buildDetailRow(
                  'Account Number:',
                  '1234 5678 9012 3456',
                  titleFontSize,
                ),
                SizedBox(height: spacingSmall),
                _buildDetailRow('Bank:', 'Maybank', titleFontSize),
                SizedBox(height: spacingSmall),
                _buildDetailRow(
                  'Reference:',
                  'Your Application ID',
                  titleFontSize,
                ),
                SizedBox(height: spacingSmall * 0.5),
                Divider(color: Colors.grey[300]),
                SizedBox(height: spacingSmall * 0.5),
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: iconSize * 0.8,
                      color: Colors.blue,
                    ),
                    SizedBox(width: spacingSmall * 0.5),
                    Flexible(
                      child: Text(
                        'Please include your application ID in the payment reference',
                        style: TextStyle(
                          fontSize: titleFontSize * 0.7,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, double fontSize) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: fontSize * 0.8, color: Colors.black87),
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: ' $value'),
        ],
      ),
    );
  }

  Widget _buildCreditCardSection(
    double titleFontSize,
    double spacingMedium,
    double spacingSmall,
    double cardPadding,
    Color primaryColor,
    double screenWidth,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
      ),
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Credit Card Payment',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: titleFontSize,
              ),
            ),
            SizedBox(height: spacingMedium),

            TextFormField(
              decoration: InputDecoration(
                labelText: 'Card Number',
                hintText: '1234 5678 9012 3456',
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: cardPadding,
                  vertical: spacingSmall,
                ),
                prefixIcon: Icon(Icons.credit_card, size: titleFontSize),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
                CardNumberInputFormatter(),
              ],
            ),

            SizedBox(height: spacingMedium),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      hintText: 'MM/YY',
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: cardPadding,
                        vertical: spacingSmall,
                      ),
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        size: titleFontSize,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      CardExpiryInputFormatter(),
                    ],
                  ),
                ),
                SizedBox(width: spacingSmall),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      hintText: '123',
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: cardPadding,
                        vertical: spacingSmall,
                      ),
                      prefixIcon: Icon(Icons.lock, size: titleFontSize),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    obscureText: true,
                  ),
                ),
              ],
            ),

            SizedBox(height: spacingMedium),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Cardholder Name',
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: cardPadding,
                  vertical: spacingSmall,
                ),
                prefixIcon: Icon(Icons.person, size: titleFontSize),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEWalletSection(
    double titleFontSize,
    double spacingMedium,
    double cardPadding,
    double screenWidth,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
      ),
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'E-Wallet Options',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: titleFontSize,
              ),
            ),
            SizedBox(height: spacingMedium),

            _buildEWalletOption(
              'Touch \'n Go',
              Icons.account_balance_wallet,
              titleFontSize,
              Colors.blue,
            ),
            _buildEWalletOption(
              'GrabPay',
              Icons.local_taxi,
              titleFontSize,
              Colors.green,
            ),
            _buildEWalletOption(
              'Boost',
              Icons.rocket_launch,
              titleFontSize,
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEWalletOption(
    String title,
    IconData icon,
    double fontSize,
    Color color,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: fontSize * 0.5),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(fontSize),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: ListTile(
        leading: Container(
          width: fontSize * 2,
          height: fontSize * 2,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(fontSize * 0.5),
          ),
          child: Icon(icon, color: color, size: fontSize * 1.2),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: fontSize * 0.9,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: fontSize * 0.8,
          color: Colors.grey,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: fontSize * 0.5,
          vertical: fontSize * 0.3,
        ),
        onTap: () {
          // Handle e-wallet selection
        },
      ),
    );
  }

  Widget _buildAmountCard(
    double titleFontSize,
    double amountFontSize,
    double spacingSmall,
    double cardPadding,
    Color primaryColor,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardPadding),
      ),
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          children: [
            Text(
              'Amount to Pay',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spacingSmall),
            Text(
              'RM 250.00',
              style: TextStyle(
                fontSize: amountFontSize * 1.2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spacingSmall),
            Text(
              'Forestry License Application Fee',
              style: TextStyle(
                fontSize: titleFontSize * 0.8,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: spacingSmall),
            Divider(color: Colors.grey[300]),
            SizedBox(height: spacingSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Method:',
                  style: TextStyle(
                    fontSize: titleFontSize * 0.8,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  _selectedPaymentMethod ?? '',
                  style: TextStyle(
                    fontSize: titleFontSize * 0.8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptUploadSection(
    double titleFontSize,
    double spacingSmall,
    double receiptContainerHeight,
    double iconSize,
    Color primaryColor,
    double screenWidth,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader('Upload Payment Receipt:', titleFontSize),
        SizedBox(height: spacingSmall),
        Text(
          'Please upload a clear photo or screenshot of your payment receipt',
          style: TextStyle(
            fontSize: titleFontSize * 0.8,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: spacingSmall),

        GestureDetector(
          onTap: _pickReceiptImage,
          child: Container(
            height: receiptContainerHeight,
            decoration: BoxDecoration(
              border: Border.all(
                color: _receiptImage == null
                    ? Colors.grey
                    : primaryColor.withOpacity(0.3),
                width: _receiptImage == null ? 1 : 2,
              ),
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
              color: _receiptImage == null ? Colors.grey[100] : Colors.white,
            ),
            child: _receiptImage == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        size: iconSize * 1.5,
                        color: primaryColor,
                      ),
                      SizedBox(height: spacingSmall),
                      Text(
                        'Tap to upload receipt',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: titleFontSize * 0.8,
                        ),
                      ),
                      SizedBox(height: spacingSmall / 2),
                      Text(
                        '(JPG, PNG, PDF up to 5MB)',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: titleFontSize * 0.6,
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        child: Image.asset(
                          'assets/receipt_placeholder.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: spacingSmall,
                        right: spacingSmall,
                        child: Container(
                          padding: EdgeInsets.all(spacingSmall * 0.5),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            size: iconSize * 0.8,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(spacingSmall),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(screenWidth * 0.02),
                              bottomRight: Radius.circular(screenWidth * 0.02),
                            ),
                          ),
                          child: Text(
                            'Receipt uploaded',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: titleFontSize * 0.8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(
    double buttonHeight,
    double titleFontSize,
    Color primaryColor,
    double screenWidth,
  ) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: buttonHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            elevation: 2,
          ),
          onPressed: _receiptImage != null && !_isSubmitting
              ? _submitPayment
              : null,
          child: _isSubmitting
              ? SizedBox(
                  width: titleFontSize,
                  height: titleFontSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
              : Text(
                  'Submit Payment',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);
      int index = i + 1;
      if (index % 4 == 0 && inputData.length != index) {
        buffer.write("  "); // Add double spaces for formatting
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.toString().length),
    );
  }
}

class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
