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
        'image':
            'https://www.fogocharcoal.com/cdn/shop/files/FP35-Lump_2048x2048.jpg?v=1715198582',
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
        'image':
            'https://wasatchtimber.com/cdn/shop/files/Wasatch-Timber-Products-raw-logs-4-scaled_32e3807b-f44c-433e-ae7b-a2f97afa7cbf.jpg?v=1718079213&width=900',
      },
      {
        'title': 'Bamboo Charcoal',
        'image':
            'https://www.chagrinvalleysoapandsalve.com/cdn/shop/articles/Stock-Bamboo-Charcoal-Skin-Care2.jpg?v=1668962594',
      },
      {
        'title': 'Wood Chips',
        'image':
            'https://madrivermulch.com/wp-content/uploads/2021/09/cedarmulch2aupdated.jpg',
      },
    ];

    return _buildGridList(context, suppliers, primaryBrown);
  }

  // ---------------- Buyers -----------------
  Widget _buildBuyers(BuildContext context, Color primaryBrown) {
    final buyers = [
      {
        'title': 'Compare Prices',
        'image':
            'https://static.tildacdn.com/tild3964-3631-4665-b332-633338363734/Price_Comparison_Sof.png',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ComparePricesPage()),
          );
        },
      },
      {
        'title': 'Wholesale',
        'image':
            'https://sellerengine.com/wp-content/uploads/2019/01/Wholesale.png',
      },
      {
        'title': 'Retail Sale',
        'image':
            'https://retailminded.com/wp-content/uploads/2017/12/RM_ShoppingCartComputerScreen_2017-1.jpg',
      },
      {
        'title': 'Export & Import',
        'image':
            'https://media.licdn.com/dms/image/v2/D4D12AQGV7IIaseYJjg/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1702463709082?e=2147483647&v=beta&t=dAPplGkGdaYMbThZ73KypU-o-1s7blw6Fn7pbzztnQU',
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
        'image':
            'https://mobileimages.lowes.com/productimages/bd947349-46e9-45fd-8a12-2871e24f3e12/08271378.jpg',
      },
      {
        'title': 'Harness',
        'subtitle': '\$159',
        'image':
            'https://beastandbuckle.com/cdn/shop/files/lumberjack-plaid-no-pull-harness-leash-bundle-4756202_720x.jpg?v=1754705073',
      },
      {
        'title': 'Calk Logger Boots',
        'subtitle': '\$699',
        'image':
            'https://cdn11.bigcommerce.com/s-11cqjpjngs/images/stencil/1280x1280/products/68019/84118/new_hoffmant_boot__32696.1663284731.jpg?c=1',
      },
      {
        'title': 'Two-Man Crosscut Saw',
        'subtitle': '\$239',
        'image':
            'https://woodworldtx.com/cdn/shop/products/New-Two-Man-v3-lg1_a67d9cff-3c28-4425-98e4-061112c6e351_720x540.jpg?v=1585415327',
      },
    ];

    return _buildGridList(context, equipment, primaryBrown);
  }

  // ---------------- Services -----------------
  Widget _buildServices(BuildContext context, Color primaryBrown) {
    final services = [
      {
        'title': 'Government Sector',
        'image':
            'https://media4.allnumis.com/74/kuala-lumpur-parliament-house_74_92638710b0db93291L.jpg',
      },
      {
        'title': 'Logistics & Transportation',
        'image':
            'https://media.licdn.com/dms/image/v2/D4D12AQEgnzq1IO_zAA/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1668335533645?e=2147483647&v=beta&t=fgCDjONzMYBmxqbGlMcjV2I1rCLumN2RYP28McjcsmY',
      },
      {
        'title': 'Maintenance',
        'image':
            'https://t3.ftcdn.net/jpg/02/79/67/00/360_F_279670083_6Q2SmbCUEYU3ucziI2trGspNIApgzB2v.jpg',
      },
      {
        'title': 'Consultation',
        'image': 'https://cdn-icons-png.freepik.com/512/7689/7689827.png',
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
            'https://companieslogo.com/img/orig/MAERSK-B.CO-cdb8c805.png?t=1720244492',
      },
      {
        'name': 'EVERGREEN',
        'logo':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Evergreen_Roundel.svg/1024px-Evergreen_Roundel.svg.png',
      },
      {
        'name': 'MSC',
        'logo':
            'https://www.clipartmax.com/png/middle/297-2979411_msc-mediterranean-shipping-company-logo-png.png',
      },
      {
        'name': 'Hapag-Lloyd',
        'logo':
            'https://i.pinimg.com/736x/e2/23/1a/e2231a086c84982b416f85b2421405b8.jpg',
      },
      {
        'name': 'WAN HAI',
        'logo':
            'https://thedeckmedia.com/wp-content/uploads/2023/02/2615.TW-91418757.png',
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
            'https://angusandoink.com/cdn/shop/files/big-k-restaurant-charcoal-briquettes.webp?crop=center&height=1000&v=1724170592&width=1000',
      },
      {
        'name': 'B',
        'subtitle': 'RM 7/kg',
        'logo':
            'https://5.imimg.com/data5/SELLER/Default/2021/2/CJ/AZ/PT/34272671/coconut-shell-charcoal-briquette-500x500.jpg',
      },
      {
        'name': 'C',
        'subtitle': 'RM 6/kg',
        'logo':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTL_luMpeSNZA0CdHU8mebcqkB5Jitzc7Ubv7eq8TSwh4uJTdbs3R-xrz9s780xoPFxJ6s&usqp=CAU',
      },
      {
        'name': 'D',
        'subtitle': 'RM 4/kg',
        'logo':
            'https://5.imimg.com/data5/SELLER/Default/2024/4/410710974/UF/YX/DB/9047234/grade-d-ramgarh-steam-coal.webp',
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
