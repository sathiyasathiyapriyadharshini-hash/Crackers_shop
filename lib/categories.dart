import 'package:cracker_shop/arrival.dart';
import 'package:cracker_shop/atom_bombs.dart';
import 'package:cracker_shop/bijili.dart';
import 'package:cracker_shop/chakkaras.dart';
import 'package:cracker_shop/fancy.dart';
import 'package:cracker_shop/flower.dart';
import 'package:cracker_shop/garlands.dart';
import 'package:cracker_shop/gift_box.dart';
import 'package:cracker_shop/kids.dart';
import 'package:cracker_shop/peacock.dart';
import 'package:cracker_shop/pencils.dart';
import 'package:cracker_shop/rockets.dart';
import 'package:cracker_shop/sky_shot.dart';
import 'package:cracker_shop/smoker.dart';
import 'package:cracker_shop/sparkies.dart';
import 'package:flutter/material.dart';
import 'landing_page.dart';
import 'profile.dart';
import '99_store.dart'; // Import new product page with storeName

class Categories extends StatelessWidget {
  final int selectedIndex;
  const Categories({super.key, this.selectedIndex = 1});

  void _onCategoryTap(BuildContext context, String label) {
    switch (label) {
      case "99 store":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ProductPage(),
          )
        );
        case "New Arrivals":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => const arrivals(),
            )
          );
        case "Gift Box":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => const gift(),
            )
          );
        case "Peacock boxes":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => const peacock(),
            )
          );
        case "Sky shots":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => const sky(),
            )
          );
        case "Sparkles":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => const sparkies(),
            )
          );
        case "Chakkaras":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => const chakaras(),
            )
          );
        case "Flower Pot":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => const flower_pot(),
            )
          );
        case "Atom Bombs":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => const bombs(),
            )
          );
        case "Bijili":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => const bijili(),
            )
          );
        case "Garlands":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => const garlands(),
            )
          );
        case "Rockets":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => const rocket(),
            )
          );
        case "Pencils":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => const pencil(),
            )
          );
        case "Fancy":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => const fancy(),
            )
          );
        case "Smokers":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => const smoker(),
            )
          );
        case "Kids":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => const kids(),
            )
          );
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No page found for $label")),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 12, 11),
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        toolbarHeight: 50,
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            Image.asset("images/logo.png", height: 24, width: 24),
            const SizedBox(width: 8),
            const Text(
              "CATEGORIES",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.favorite_border, size: 20),
              onPressed: () {},
              padding: EdgeInsets.zero,
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, size: 20),
              onPressed: () {},
              padding: EdgeInsets.zero,
            ),
            IconButton(
              icon: const Icon(Icons.notifications_none, size: 20),
              onPressed: () {},
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          /// Left Vertical Categories List
          Flexible(
            flex: screenWidth > 800 ? 1 : 2,
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: _leftCategories(context),
                ),
              ),
            ),
          ),

          /// Right Main Content Area
          Flexible(
            flex: screenWidth > 800 ? 3 : 5,
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCrackerSection("Light Crackers", _lightCrackers),
                    const SizedBox(height: 20),
                    _buildCrackerSection("Sound Crackers", _soundCrackers),
                    const SizedBox(height: 20),
                    _buildCrackerSection("Aerial Crackers", _aerialCrackers),
                    const SizedBox(height: 20),
                    _buildCrackerSection("Combo Packs", _comboPacks),
                    const SizedBox(height: 20),
                    _buildCrackerSection("Safe for Kids", _kidsCrackers),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottnavbar(currentIndex: 1),
    );
  }

  Widget _buildCrackerSection(String title, List<Widget> items) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 250,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 20, 20, 20),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.orange, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = (constraints.maxWidth ~/ 150).clamp(2, 4);
              return GridView.count(
                shrinkWrap: true,
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
                physics: const NeverScrollableScrollPhysics(),
                children: items,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String imagePath, String label) {
    return GestureDetector(
      onTap: () => _onCategoryTap(context, label),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            ClipOval(
              child: Image.asset(
                imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCrackerItem(String imagePath, String label) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagePath,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  List<Widget> _leftCategories(BuildContext context) => [
        _buildItem(context, "images/99.jpg", "99 store"),
        _buildItem(context, "images/new.jpg", "New Arrivals"),
        _buildItem(context, "images/box.jpg", "Gift Box"),
        _buildItem(context, "images/peacock.jpg", "Peacock boxes"),
        _buildItem(context, "images/sky.jpg", "Sky shots"),
        _buildItem(context, "images/sparkles.jpg", "Sparkles"),
        _buildItem(context, "images/chakkars.jpg", "Chakkaras"),
        _buildItem(context, "images/flowerpot.jpg", "Flower Pot"),
        _buildItem(context, "images/atombombs.jpg", "Atom Bombs"),
        _buildItem(context, "images/bijili.jpg", "Bijili"),
        _buildItem(context, "images/garlands.jpg", "Garlands"),
        _buildItem(context, "images/rockets.jpg", "Rockets"),
        _buildItem(context, "images/pencils.jpg", "Pencils"),
        _buildItem(context, "images/fancy.jpg", "Fancy"),
        _buildItem(context, "images/smokers.jpg", "Smokers"),
        _buildItem(context, "images/kids.jpg", "Kids"),
      ];

  List<Widget> get _lightCrackers => [
        _buildCrackerItem("images/sparkles.jpg", "Sparklers"),
        _buildCrackerItem("images/flowerpot.jpg", "Flower Pots"),
        _buildCrackerItem("images/fancy.jpg", "Matches"),
        _buildCrackerItem("images/chakkars.jpg", "Chakkars"),
      ];

  List<Widget> get _soundCrackers => [
        _buildCrackerItem("images/atombombs.jpg", "Atom Bombs"),
        _buildCrackerItem("images/bijili.jpg", "Bijili"),
        _buildCrackerItem("images/garlands.jpg", "Garlands"),
        _buildCrackerItem("images/garlands.jpg", "Garlands"),
      ];

  List<Widget> get _aerialCrackers => [
        _buildCrackerItem("images/sky.jpg", "Sky Shots"),
        _buildCrackerItem("images/rockets.jpg", "Rockets"),
        _buildCrackerItem("images/rockets.jpg", "Rockets"),
        _buildCrackerItem("images/rockets.jpg", "Rockets"),
      ];

  List<Widget> get _comboPacks => [
        _buildCrackerItem("images/box.jpg", "Gift Box"),
        _buildCrackerItem("images/peacock.jpg", "Peacock Box"),
        _buildCrackerItem("images/peacock.jpg", "Peacock Box"),
        _buildCrackerItem("images/peacock.jpg", "Peacock Box"),
      ];

  List<Widget> get _kidsCrackers => [
        _buildCrackerItem("images/pencils.jpg", "Pencils"),
        _buildCrackerItem("images/kids.jpg", "Kids Combo"),
        _buildCrackerItem("images/kids.jpg", "Kids Combo"),
        _buildCrackerItem("images/kids.jpg", "Kids Combo"),
      ];
}

class bottnavbar extends StatelessWidget {
  final int currentIndex;
  const bottnavbar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.white54,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
      onTap: (index) {
        if (index == currentIndex) return;
        if (index == 0) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const landing()));
        } else if (index == 1) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Categories()));
        } else if (index == 2) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Profile()));
        }
      },
    );
  }
}
