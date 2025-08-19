// marketplace_page.dart
import 'package:flutter/material.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryBrown = const Color(0xFF795548); // Primary brown color
    final Color lightBrown = const Color(0xFFD7CCC8); // Light brown
    final Color darkBrown = const Color(0xFF5D4037); // Dark brown
    final Color backgroundColor = const Color(0xFFEFEBE9); // Background color

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text(
            'Marketplace',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: primaryBrown,
          elevation: 0,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: primaryBrown),
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: lightBrown,
            tabs: const [
              Tab(text: 'Suppliers'),
              Tab(text: 'Buyers'),
              Tab(text: 'Equipment'),
              Tab(text: 'Services'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _buildCategoryList('Suppliers', primaryBrown, lightBrown),
              _buildCategoryList('Buyers', primaryBrown, lightBrown),
              _buildCategoryList('Equipment', primaryBrown, lightBrown),
              _buildCategoryList('Services', primaryBrown, lightBrown),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
          child: FloatingActionButton(
            backgroundColor: primaryBrown,
            onPressed: () {
              // Navigate to create listing page
              // Navigator.push(context, MaterialPageRoute(builder: (context) => CreateListingPage()));
            },
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList(
    String category,
    Color primaryBrown,
    Color lightBrown,
  ) {
    // This would come from your backend in a real app
    final List<Map<String, dynamic>> listings = [
      {
        'title': 'Premium Hardwood Charcoal',
        'seller': 'Green Forest Enterprise',
        'price': 'RM 1200/ton',
        'location': 'Pahang',
        'rating': 4.5,
      },
      {
        'title': 'Sustainable Timber Logs',
        'seller': 'Eco Timber Sdn Bhd',
        'price': 'RM 850/cubic meter',
        'location': 'Sarawak',
        'rating': 4.2,
      },
      {
        'title': 'Bamboo Charcoal',
        'seller': 'Bamboo Solutions',
        'price': 'RM 950/ton',
        'location': 'Selangor',
        'rating': 4.7,
      },
      {
        'title': 'Wood Chips Bulk Order',
        'seller': 'Timberland Resources',
        'price': 'RM 650/ton',
        'location': 'Johor',
        'rating': 3.9,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: listings.length,
      itemBuilder: (context, index) {
        final item = listings[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12.0),
            onTap: () {
              // Navigate to listing detail
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ListingDetailPage(item)));
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: lightBrown.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(Icons.forest, size: 36, color: primaryBrown),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: primaryBrown,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['seller'],
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: primaryBrown,
                            ),
                            const SizedBox(width: 4),
                            Text(item['location']),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item['price'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryBrown,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(' ${item['rating']}'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
