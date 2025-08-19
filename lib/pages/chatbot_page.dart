import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  final List<String> _commonQuestions = [
    'How do I apply for a logging license?',
    'What documents do I need for Form 1 license?',
    'How to check my application status?',
    'What are the payment methods available?',
    'How to contact the forestry department?',
  ];

  // Color scheme
  final Color _primaryColor = const Color(0xFF004687);
  final Color _secondaryColor = const Color(0xFFC09A5B);
  final Color _backgroundColor = const Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textColor = const Color(0xFF333333);
  final Color _hintColor = const Color(0xFF6C757D);

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forestry Assistant',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [_backgroundColor.withOpacity(0.8), _backgroundColor],
                ),
              ),
              child: _messages.isEmpty
                  ? _buildWelcomeSection(isSmallScreen)
                  : _buildChatSection(),
            ),
          ),
          _buildInputSection(isSmallScreen),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(bool isSmallScreen) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.forest, size: 48, color: _primaryColor),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Hello! I\'m your Forestry Assistant',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 20 : 24,
                      fontWeight: FontWeight.bold,
                      color: _textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'How can I help you today? Here are some common questions:',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      color: _hintColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Common Questions',
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: _textColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ..._commonQuestions.map((question) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: _buildQuestionCard(question, isSmallScreen),
            );
          }).toList(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(String question, bool isSmallScreen) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _handleQuestionSelected(question),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
          child: Row(
            children: [
              Icon(
                Icons.help_outline,
                color: _primaryColor,
                size: isSmallScreen ? 20 : 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  question,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    color: _textColor,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.withOpacity(0.6)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatSection() {
    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: const EdgeInsets.only(top: 16, bottom: 80),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        return _messages[index];
      },
    );
  }

  Widget _buildInputSection(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12.0 : 16.0,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        color: _cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Icon(
                    Icons.message,
                    color: _hintColor,
                    size: isSmallScreen ? 20 : 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      focusNode: _focusNode,
                      onSubmitted: _handleSubmitted,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type your question...',
                        hintStyle: TextStyle(color: _hintColor),
                      ),
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        color: _textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_primaryColor, _secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    if (text.trim().isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(
      text: text,
      isUser: true,
      primaryColor: _primaryColor,
      secondaryColor: _secondaryColor,
      cardColor: _cardColor,
      textColor: _textColor,
    );

    setState(() {
      _messages.insert(0, userMessage);
    });

    // Auto-scroll to bottom
    _scrollToBottom();

    // Simulate bot response after a delay
    Future.delayed(const Duration(milliseconds: 800), () {
      final response = _getBotResponse(text);
      final botMessage = ChatMessage(
        text: response,
        isUser: false,
        primaryColor: _primaryColor,
        secondaryColor: _secondaryColor,
        cardColor: _cardColor,
        textColor: _textColor,
      );

      setState(() {
        _messages.insert(0, botMessage);
      });

      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleQuestionSelected(String question) {
    _textController.text = question;
    _handleSubmitted(question);
    _focusNode.unfocus();
  }

  String _getBotResponse(String userInput) {
    userInput = userInput.toLowerCase();

    if (userInput.contains('license') || userInput.contains('apply')) {
      return 'To apply for a logging license:\n\n'
          '1. Go to "Apply for License" in the app\n'
          '2. Select license type (Form 1, 3, or 5)\n'
          '3. Upload required documents\n'
          '4. Submit application\n\n'
          'Processing time: 7-10 working days';
    } else if (userInput.contains('document') || userInput.contains('form 1')) {
      return 'For Form 1 License, you need:\n\n'
          '• Company registration documents\n'
          '• Approved Forest Harvesting Plan\n'
          '• EIA Report (if applicable)\n'
          '• Proof of RM 5,000 deposit payment\n'
          '• Detailed map (scale 1:10,000)\n\n'
          'All documents must be in PDF format.';
    } else if (userInput.contains('status')) {
      return 'Check your application status:\n\n'
          '1. Open "My Applications"\n'
          '2. View current status:\n'
          '   - Submitted\n'
          '   - Under Review\n'
          '   - Approved/Rejected\n\n'
          'Contact support@forestry.gov.my for help.';
    } else if (userInput.contains('payment')) {
      return 'Accepted payment methods:\n\n'
          '• Online Banking (FPX)\n'
          '• Credit/Debit Cards\n'
          '• Bank Transfer\n'
          '• e-Wallets (Boost, TNG)\n\n'
          'Receipts are emailed automatically.';
    } else if (userInput.contains('contact')) {
      return 'Forestry Department Contacts:\n\n'
          '📞 +603-1234 5678 (8:30AM-5:30PM)\n'
          '📧 support@forestry.gov.my\n'
          '📍 Jalan Sultan Salahuddin, KL\n\n'
          'State offices available nationwide.';
    } else {
      return 'I can help with:\n\n'
          '• License applications\n'
          '• Document requirements\n'
          '• Application status\n'
          '• Payments\n'
          '• Contact information\n\n'
          'Could you please rephrase your question?';
    }
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;
  final Color primaryColor;
  final Color secondaryColor;
  final Color cardColor;
  final Color textColor;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isUser,
    required this.primaryColor,
    required this.secondaryColor,
    required this.cardColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: primaryColor.withOpacity(0.1),
              child: Icon(Icons.forest, size: 18, color: primaryColor),
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUser ? primaryColor : cardColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: Radius.circular(isUser ? 12 : 0),
                      bottomRight: Radius.circular(isUser ? 0 : 12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isUser ? Colors.white : textColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isUser ? 'You' : 'Forestry Assistant',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 16,
              backgroundColor: primaryColor.withOpacity(0.1),
              child: Icon(Icons.person, size: 18, color: primaryColor),
            ),
          ],
        ],
      ),
    );
  }
}
