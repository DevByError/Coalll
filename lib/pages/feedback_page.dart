// feedback_page.dart
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int _overallSatisfaction = 5;
  int _easeOfUse = 3;
  String? _mostUsedFeature;
  String _featureSuggestions = '';
  String _painPoints = '';
  int _navigationRating = 3;
  int _recommendationLikelihood = 7;
  String _timeSaved = 'some';
  int _trustRating = 4;
  int _supportRating = 3;
  int _onboardingRating = 3;
  String _competitiveComparison = '';
  String _contextualReflection = '';
  String _retentionInsight = '';
  String _openFeedback = '';

  final List<String> _features = [
    'Permit Tracking',
    'Notifications',
    'Marketplace',
    'License Information',
    'Payments',
    'Chatbot',
  ];

  final Color _primaryColor = const Color(0xFF8B0000); // Dark red
  final Color _secondaryColor = const Color(0xFFDC143C); // Crimson
  final Color _tertiaryColor = const Color(0xFFFF6347); // Tomato
  final Color _lightRed = const Color(0xFFFFCCCB);
  final Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Feedback Form',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: _primaryColor, // Dark red app bar background
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white, // White circular background
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back,
              color: _primaryColor, // Dark red arrow
              size: 20,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ), // Fallback for other icons
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Introduction Card
              _buildIntroCard(),
              const SizedBox(height: 24),

              // Section 1: Core Experience
              _buildSectionHeader('Core Experience'),
              const SizedBox(height: 16),

              // Question 1: Overall Satisfaction
              _buildQuestion('1. Overall Satisfaction'),
              const Text(
                'On a scale of 1 to 10, how would you rate your overall experience with the app?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildRatingSlider(
                value: _overallSatisfaction.toDouble(),
                onChanged: (value) =>
                    setState(() => _overallSatisfaction = value.round()),
              ),
              const SizedBox(height: 24),

              // Question 2: Ease of Use
              _buildQuestion('2. Ease of Use'),
              const Text(
                'How easy was it to submit your permit application through the app?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildRatingChips(
                currentValue: _easeOfUse,
                onSelected: (value) => setState(() => _easeOfUse = value),
                labels: const ['1', '2', '3', '4', '5'],
                legend: '1 = Very Difficult, 5 = Very Easy',
              ),
              const SizedBox(height: 24),

              // Question 3: Feature Usage
              _buildQuestion('3. Feature Usage'),
              const Text(
                'Which feature do you use most often?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildFeatureChips(),
              const SizedBox(height: 24),

              // Question 4: Feature Suggestions
              _buildQuestion('4. Feature Suggestions'),
              const Text(
                'What additional features would you like to see in future updates?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                onChanged: (value) => _featureSuggestions = value,
                hintText: 'Your suggestions...',
              ),
              const SizedBox(height: 24),

              // Section 2: Usability & Performance
              _buildSectionHeader('Usability & Performance'),
              const SizedBox(height: 16),

              // Question 5: Pain Points
              _buildQuestion('5. Pain Points'),
              const Text(
                'Did you encounter any issues (bugs or confusion)? Please describe.',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                onChanged: (value) => _painPoints = value,
                hintText: 'Describe any issues you faced...',
              ),
              const SizedBox(height: 24),

              // Question 6: Navigation
              _buildQuestion('6. Navigation'),
              const Text(
                'How intuitive do you find the app navigation?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildRatingChips(
                currentValue: _navigationRating,
                onSelected: (value) =>
                    setState(() => _navigationRating = value),
                labels: const ['1', '2', '3', '4', '5'],
                legend: '1 = Not Intuitive, 5 = Very Intuitive',
              ),
              const SizedBox(height: 24),

              // Question 7: Likelihood to Recommend (NPS)
              _buildQuestion('7. Likelihood to Recommend'),
              const Text(
                'How likely are you to recommend this app to a friend or colleague?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildRatingSlider(
                value: _recommendationLikelihood.toDouble(),
                min: 0,
                max: 10,
                divisions: 10,
                onChanged: (value) =>
                    setState(() => _recommendationLikelihood = value.round()),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                  '0 = Not at all likely, 10 = Extremely likely',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 24),

              // Section 3: Advanced Feedback
              _buildSectionHeader('Advanced Feedback'),
              const SizedBox(height: 16),

              // Question 8: Time Savings & Efficiency
              _buildQuestion('8. Time Savings'),
              const Text(
                'Compared to traditional permit processes, how much time did you save using the app?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildOptionChips(
                options: ['a lot', 'some', 'none'],
                selectedOption: _timeSaved,
                onSelected: (value) => setState(() => _timeSaved = value),
              ),
              const SizedBox(height: 24),

              // Question 9: Trust & Transparency
              _buildQuestion('9. Trust & Transparency'),
              const Text(
                'Do you feel the app provides clear and transparent updates on permit status?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildRatingChips(
                currentValue: _trustRating,
                onSelected: (value) => setState(() => _trustRating = value),
                labels: const ['1', '2', '3', '4', '5'],
                legend: '1 = Not at all, 5 = Completely',
              ),
              const SizedBox(height: 24),

              // Question 10: User Support
              _buildQuestion('10. User Support'),
              const Text(
                'How easy was it to access help or support within the app?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildRatingChips(
                currentValue: _supportRating,
                onSelected: (value) => setState(() => _supportRating = value),
                labels: const ['1', '2', '3', '4', '5'],
                legend: '1 = Very Difficult, 5 = Very Easy',
              ),
              const SizedBox(height: 24),

              // Question 11: First-time User Experience
              _buildQuestion('11. Onboarding Experience'),
              const Text(
                'How helpful were the onboarding tutorials or guides?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildRatingChips(
                currentValue: _onboardingRating,
                onSelected: (value) =>
                    setState(() => _onboardingRating = value),
                labels: const ['1', '2', '3', '4', '5'],
                legend: '1 = Not Helpful, 5 = Very Helpful',
              ),
              const SizedBox(height: 24),

              // Question 12: Competitive Comparison
              _buildQuestion('12. Competitive Comparison'),
              const Text(
                'Do you use any similar systems or apps? If so, how does this compare?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                onChanged: (value) => _competitiveComparison = value,
                hintText: 'Your comparison...',
              ),
              const SizedBox(height: 24),

              // Question 13: Contextual Reflection
              _buildQuestion('13. Contextual Reflection'),
              const Text(
                'Can you tell me what you\'re thinking as you perform this task?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                onChanged: (value) => _contextualReflection = value,
                hintText: 'Your thoughts...',
              ),
              const SizedBox(height: 24),

              // Question 14: Retention Insight
              _buildQuestion('14. Retention Insight'),
              const Text(
                'How would you feel if you could no longer use this app?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                onChanged: (value) => _retentionInsight = value,
                hintText: 'Your feelings...',
              ),
              const SizedBox(height: 24),

              // Question 15: Open Feedback
              _buildQuestion('15. Open Feedback'),
              const Text(
                'Is there anything else we can improve or any other comments you\'d like to add?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                onChanged: (value) => _openFeedback = value,
                hintText: 'Your additional feedback...',
              ),
              const SizedBox(height: 32),

              // Submit Button
              Center(child: _buildSubmitButton(context)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroCard() {
    return Card(
      elevation: 0,
      color: _lightRed.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _lightRed, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(Icons.feedback, size: 36, color: _primaryColor),
            const SizedBox(height: 12),
            const Text(
              'We value your feedback!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please take a few minutes to share your experience and help us improve the app.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(String question) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        question,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: _primaryColor,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: _primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _primaryColor.withOpacity(0.2)),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: _primaryColor,
        ),
      ),
    );
  }

  Widget _buildRatingSlider({
    required double value,
    required ValueChanged<double> onChanged,
    double min = 1,
    double max = 10,
    int divisions = 9,
  }) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: _primaryColor,
        inactiveTrackColor: _lightRed,
        thumbColor: _primaryColor,
        overlayColor: _primaryColor.withOpacity(0.2),
        valueIndicatorColor: _primaryColor,
        showValueIndicator: ShowValueIndicator.always,
      ),
      child: Slider(
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        label: value.round().toString(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildRatingChips({
    required int currentValue,
    required ValueChanged<int> onSelected,
    required List<String> labels,
    String? legend,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          children: List.generate(labels.length, (index) {
            final rating = index + 1;
            return ChoiceChip(
              label: Text(labels[index]),
              selected: currentValue == rating,
              selectedColor: _primaryColor,
              labelStyle: TextStyle(
                color: currentValue == rating ? Colors.white : Colors.black87,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: _primaryColor.withOpacity(0.3)),
              ),
              onSelected: (selected) => onSelected(selected ? rating : 0),
            );
          }),
        ),
        if (legend != null)
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              legend,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
      ],
    );
  }

  Widget _buildFeatureChips() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: _features.map((feature) {
        return ChoiceChip(
          label: Text(feature),
          selected: _mostUsedFeature == feature,
          selectedColor: _secondaryColor,
          labelStyle: TextStyle(
            color: _mostUsedFeature == feature ? Colors.white : Colors.black87,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: _primaryColor.withOpacity(0.3)),
          ),
          onSelected: (selected) {
            setState(() {
              _mostUsedFeature = selected ? feature : null;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildOptionChips({
    required List<String> options,
    required String selectedOption,
    required ValueChanged<String> onSelected,
  }) {
    return Wrap(
      spacing: 8.0,
      children: options.map((option) {
        return ChoiceChip(
          label: Text(option),
          selected: selectedOption == option,
          selectedColor: _tertiaryColor,
          labelStyle: TextStyle(
            color: selectedOption == option ? Colors.white : Colors.black87,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: _primaryColor.withOpacity(0.3)),
          ),
          onSelected: (selected) => onSelected(selected ? option : ''),
        );
      }).toList(),
    );
  }

  Widget _buildTextField({
    required ValueChanged<String> onChanged,
    required String hintText,
    int maxLines = 3,
  }) {
    return TextField(
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[50],
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _primaryColor, width: 1.5),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      style: const TextStyle(fontSize: 15),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _submitFeedback();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Thank you for your feedback!'),
              backgroundColor: _primaryColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: const Text(
          'Submit Feedback',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _submitFeedback() {
    final feedbackData = {
      'overallSatisfaction': _overallSatisfaction,
      'easeOfUse': _easeOfUse,
      'mostUsedFeature': _mostUsedFeature,
      'featureSuggestions': _featureSuggestions,
      'painPoints': _painPoints,
      'navigationRating': _navigationRating,
      'recommendationLikelihood': _recommendationLikelihood,
      'timeSaved': _timeSaved,
      'trustRating': _trustRating,
      'supportRating': _supportRating,
      'onboardingRating': _onboardingRating,
      'competitiveComparison': _competitiveComparison,
      'contextualReflection': _contextualReflection,
      'retentionInsight': _retentionInsight,
      'openFeedback': _openFeedback,
      'timestamp': DateTime.now().toIso8601String(),
    };

    // In a real app, you would send this to your backend
    debugPrint('Feedback submitted: $feedbackData');
  }
}
