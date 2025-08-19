import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        final isLandscape = constraints.maxWidth > constraints.maxHeight;
        final itemPadding = isTablet
            ? (isLandscape ? 12.0 : 16.0)
            : (isLandscape ? 8.0 : 12.0);

        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
            title: Text(
              'Notifications',
              style: TextStyle(color: Colors.green.shade700),
            ),
            backgroundColor: Colors.black87,
            elevation: 0,
            centerTitle: true,
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
              child: ListView.separated(
                padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
                itemCount: 10,
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.grey, height: isLandscape ? 12 : 16),
                itemBuilder: (context, index) {
                  return _buildNotificationItem(
                    context,
                    index: index,
                    isTablet: isTablet,
                    isLandscape: isLandscape,
                    padding: itemPadding,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem(
    BuildContext context, {
    required int index,
    required bool isTablet,
    required bool isLandscape,
    required double padding,
  }) {
    final avatarSize = isTablet
        ? (isLandscape ? 48.0 : 56.0)
        : (isLandscape ? 40.0 : 48.0);
    final titleSize = isTablet
        ? (isLandscape ? 16.0 : 18.0)
        : (isLandscape ? 14.0 : 16.0);
    final subtitleSize = isTablet
        ? (isLandscape ? 14.0 : 16.0)
        : (isLandscape ? 12.0 : 14.0);
    final timeSize = isTablet ? 14.0 : 12.0;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: isLandscape ? padding * 0.5 : padding,
      ),
      leading: CircleAvatar(
        radius: avatarSize / 2,
        backgroundColor: Colors.green,
        child: Icon(
          Icons.notifications,
          color: Colors.white,
          size: avatarSize * 0.6,
        ),
      ),
      title: Text(
        'Important Update ${index + 1}',
        style: TextStyle(
          color: Colors.white,
          fontSize: titleSize,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        'Your account has received an important update that requires your attention',
        style: TextStyle(color: Colors.grey[300], fontSize: subtitleSize),
        maxLines: isLandscape ? 1 : 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${index + 1}h ago',
            style: TextStyle(color: Colors.grey[400], fontSize: timeSize),
          ),
          if (index % 3 == 0)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Notification ${index + 1} tapped'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }
}
