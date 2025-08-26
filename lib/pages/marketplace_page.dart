import 'package:flutter/material.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryBrown = const Color(0xFF795548);
    final Color lightBrown = const Color(0xFFD7CCC8);
    final Color backgroundColor = const Color(0xFFEFEBE9);

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
          centerTitle: true,
          elevation: 0,
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
              _buildSuppliers(context, primaryBrown),
              _buildBuyers(context, primaryBrown),
              _buildEquipment(context, primaryBrown),
              _buildServices(context, primaryBrown),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- Suppliers -----------------
  Widget _buildSuppliers(BuildContext context, Color primaryBrown) {
    final suppliers = [
      {
        'title': 'Premium Hardwood Charcoal',
        'image': 'https://images.unsplash.com/photo-1602524811334-67d8d10a2f64',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const premiumhardwoodcharcoalpage(),
            ),
          );
        },
      },
      {
        'title': 'Sustainable Timber Logs',
        'image': 'https://images.unsplash.com/photo-1606761568499-6d2451b23c1a',
      },
      {
        'title': 'Bamboo Charcoal',
        'image': 'https://images.unsplash.com/photo-1587731653466-04029a91a5e1',
      },
      {
        'title': 'Wood Chips',
        'image': 'https://images.unsplash.com/photo-1617196038532-5fcb35d861cb',
      },
    ];

    return _buildGridList(context, suppliers, primaryBrown);
  }

  // ---------------- Buyers -----------------
  Widget _buildBuyers(BuildContext context, Color primaryBrown) {
    final buyers = [
      {
        'title': 'Compare Prices',
        'image': 'https://via.placeholder.com/300x200?text=Compare',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ComparePricesPage()),
          );
        },
      },
      {
        'title': 'Wholesale',
        'image': 'https://via.placeholder.com/300x200?text=Wholesale',
      },
      {
        'title': 'Retail Sale',
        'image': 'https://via.placeholder.com/300x200?text=Retail',
      },
      {
        'title': 'Export & Import',
        'image': 'https://via.placeholder.com/300x200?text=Export',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ExportImportPage()),
          );
        },
      },
    ];

    return _buildGridList(context, buyers, primaryBrown);
  }

  // ---------------- Equipment -----------------
  Widget _buildEquipment(BuildContext context, Color primaryBrown) {
    final equipment = [
      {
        'title': 'Chainsaw',
        'subtitle': '\$189',
        'image': 'https://via.placeholder.com/300x200?text=Chainsaw',
      },
      {
        'title': 'Harness',
        'subtitle': '\$159',
        'image': 'https://via.placeholder.com/300x200?text=Harness',
      },
      {
        'title': 'Calk Logger Boots',
        'subtitle': '\$699',
        'image': 'https://via.placeholder.com/300x200?text=Boots',
      },
      {
        'title': 'Two-Man Crosscut Saw',
        'subtitle': '\$239',
        'image': 'https://via.placeholder.com/300x200?text=Saw',
      },
    ];

    return _buildGridList(context, equipment, primaryBrown);
  }

  // ---------------- Services -----------------
  Widget _buildServices(BuildContext context, Color primaryBrown) {
    final services = [
      {
        'title': 'Government Sector',
        'image': 'https://via.placeholder.com/300x200?text=Government',
      },
      {
        'title': 'Logistics & Transportation',
        'image': 'https://via.placeholder.com/300x200?text=Logistics',
      },
      {
        'title': 'Maintenance',
        'image': 'https://via.placeholder.com/300x200?text=Maintenance',
      },
      {
        'title': 'Consultation',
        'image': 'https://via.placeholder.com/300x200?text=Consultation',
      },
    ];

    return _buildGridList(context, services, primaryBrown);
  }

  // ---------------- Grid Builder -----------------
  Widget _buildGridList(
    BuildContext context,
    List<Map<String, dynamic>> items,
    Color primaryBrown,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildCard(
          context,
          title: item['title'] as String,
          imageUrl: item['image'] as String,
          subtitle: item['subtitle'] as String?,
          primaryBrown: primaryBrown,
          onTap: item['onTap'] as void Function()?,
        );
      },
    );
  }

  // ---------------- Card Builder -----------------
  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String imageUrl,
    String? subtitle,
    required Color primaryBrown,
    void Function()? onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.broken_image, size: 40)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryBrown,
                  fontSize: 14,
                ),
              ),
            ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Compare Prices Page -----------------
class ComparePricesPage extends StatelessWidget {
  const ComparePricesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController priceController = TextEditingController();
    final Color primaryBrown = const Color(0xFF795548);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Prices'),
        backgroundColor: primaryBrown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Standard Price: RM 5000 / ton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Enter your price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBrown,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final enteredPrice = priceController.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You entered: RM $enteredPrice')),
                );
              },
              child: const Center(
                child: Text(
                  'Submit Price',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Export & Import Page -----------------
class ExportImportPage extends StatelessWidget {
  const ExportImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryBrown = const Color(0xFF795548);

    final partners = [
      {
        'name': 'MAERSK',
        'logo':
            'https://upload.wikimedia.org/wikipedia/commons/4/47/Maersk_Group_Logo.svg',
      },
      {
        'name': 'EVERGREEN',
        'logo':
            'https://upload.wikimedia.org/wikipedia/commons/2/2d/Evergreen_Marine_Corporation_logo.svg',
      },
      {
        'name': 'MSC',
        'logo':
            'https://upload.wikimedia.org/wikipedia/commons/5/57/Mediterranean_Shipping_Company_logo.svg',
      },
      {
        'name': 'Hapag-Lloyd',
        'logo':
            'https://upload.wikimedia.org/wikipedia/commons/0/0c/Hapag-Lloyd_logo.svg',
      },
      {
        'name': 'WAN HAI',
        'logo':
            'https://upload.wikimedia.org/wikipedia/commons/2/25/Wan_Hai_logo.svg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Export & Import'),
        backgroundColor: primaryBrown,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Some of our trusted partners for shipping",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF795548),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemCount: partners.length,
              itemBuilder: (context, index) {
                final partner = partners[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.network(
                            partner['logo']!,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.local_shipping, size: 50),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          partner['name']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryBrown,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class premiumhardwoodcharcoalpage extends StatelessWidget {
  const premiumhardwoodcharcoalpage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryBrown = const Color(0xFF795548);

    final grades = [
      {
        'name': 'A',
        'subtitle': 'RM 9/kg',
        'logo':
            'https://upload.wikimedia.org/wikipedia/commons/4/47/Maersk_Group_Logo.svg',
      },
      {
        'name': 'B',
        'subtitle': 'RM 7/kg',
        'logo':
            'https://upload.wikimedia.org/wikipedia/commons/2/2d/Evergreen_Marine_Corporation_logo.svg',
      },
      {
        'name': 'C',
        'subtitle': 'RM 6/kg',
        'logo':
            'https://upload.wikimedia.org/wikipedia/commons/5/57/Mediterranean_Shipping_Company_logo.svg',
      },
      {
        'name': 'D',
        'subtitle': 'RM 4/kg',
        'logo':
            'https://upload.wikimedia.org/wikipedia/commons/0/0c/Hapag-Lloyd_logo.svg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Harwood charcoal'),
        backgroundColor: primaryBrown,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Premium Hardwood Charcoal Grades",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF795548),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemCount: grades.length,
              itemBuilder: (context, index) {
                final grade = grades[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.network(
                            grade['logo']!,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.local_shipping, size: 50),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          grade['name']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryBrown,
                          ),
                        ),
                      ),
                      Text(
                        grade['subtitle']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
