import 'package:cracker_shop/99_store.dart';
import 'package:cracker_shop/arrival.dart';
import 'package:cracker_shop/categories.dart';
import 'package:cracker_shop/gift_box.dart';
import 'package:cracker_shop/peacock.dart';
import 'package:cracker_shop/profile.dart';
import 'package:cracker_shop/sky_shot.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
// ======================================
// Landing Page
// ======================================
class landing extends StatefulWidget {
  const landing({super.key});

  @override
  State<landing> createState() => _landingState();
}

class _landingState extends State<landing> {
  String? selectedDistrict;

  List<Widget> getShopsForDistrict(String? district) {
    if (district == "Chennai") {
      return [shopprofile1()];
    } else if (district == "Madurai") {
      return [shopprofile2()];
    } else if (district == "Coimbatore") {
      return [shopprofile1(), shopprofile2()];
    } else {
      return [shopprofile1(), shopprofile2()]; // default: all shops
    }
  }
  //  .....Navbar Content Start.....

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Image.asset("images/logo.png", height: 24, width: 24),
            const SizedBox(width: 4),
            const Text(
              "CRACKERS",
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          

        ],
      ),
      bottomNavigationBar: bottnavbar(currentIndex: 0),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LocationSelector(
              onDistrictSelected: (district) {
                setState(() {
                  selectedDistrict = district;
                });
              },
            ),
            search(
            onSearchChanged: (value) {
              setState(() {
                var searchQuery = value; // stzore user input
              });
              print("User typed: $value"); // debug
            },
          ),
            const rowscroll(),
            const offers(),
            ...getShopsForDistrict(selectedDistrict),
          ],
        ),
      ),
    );
  }
}

// .....Navbar Content End....

// ======================================
// Bottom Navigation Bar Start
// ======================================
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
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const landing()));
        } else if (index == 1) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const Categories()));
        } else if (index == 2) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const Profile()));
        }
      },
    );
  }
}

// .....Bottom Navigation Bar End....

// ======================================
// Location Selector Start
// ======================================
class LocationSelector extends StatefulWidget {
  final Function(String) onDistrictSelected;

  const LocationSelector({super.key, required this.onDistrictSelected});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  String? selectedDistrict;

  final List<String> districts = [
    "Ariyalur", "Chengalpattu", "Chennai", "Coimbatore", "Cuddalore",
    "Dharmapuri", "Dindigul", "Erode", "Kallakurichi", "Kanchipuram",
    "Kanyakumari", "Karur", "Krishnagiri", "Madurai", "Nagapattinam",
    "Namakkal", "Nilgiris", "Perambalur", "Pudukkottai", "Ramanathapuram",
    "Ranipet", "Salem", "Sivagangai", "Tenkasi", "Thanjavur", "Theni",
    "Thoothukudi", "Tiruchirappalli", "Tirunelveli", "Tirupathur", "Tiruppur",
    "Tiruvallur", "Tiruvannamalai", "Tiruvarur", "Vellore", "Viluppuram", "Virudhunagar",
  ];

  void _showDistrictPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return ListView.builder(
          itemCount: districts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(districts[index]),
              onTap: () {
                setState(() {
                  selectedDistrict = districts[index];
                });
                widget.onDistrictSelected(districts[index]);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on, color: Colors.white),
      title: Text(
        selectedDistrict ?? "Select a location",
        style: const TextStyle(fontSize: 15, color: Colors.white),
      ),
      onTap: _showDistrictPicker,
    );
  }
}

// ======================================
// Search Widget
// ======================================
class search extends StatelessWidget {
  final Function(String) onSearchChanged;

  const search({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search shops...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: const Color.fromARGB(255, 248, 248, 248),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: onSearchChanged, // 🔥 sends value to landing
      ),
    );
  }
}



// ======================================
// Horizontal Scroll
// ======================================
class rowscroll extends StatelessWidget {
  const rowscroll({super.key});

  void _onCategoryTap(BuildContext context, String label) {
    switch (label) {
      case "99 store":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(),
          ),
        );
        case "New Arrivals":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const arrivals(), 
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
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No page found for $label")),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Allow horizontal scrolling
        child: Row(
          children: [
            _buildItem(context, "images/99.jpg", "99 store"),
            _buildItem(context, "images/new.jpg", "New Arrivals"),
            _buildItem(context, "images/box.jpg", "Gift Box"),
            _buildItem(context, "images/peacock.jpg", "Peacock boxes"),
            _buildItem(context, "images/sky.jpg", "Sky shots"),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String imagePath, String label) {
    return GestureDetector(
      onTap: () => _onCategoryTap(context, label),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================
// Offers Slider
// ======================================
class offers extends StatefulWidget {
  const offers({super.key});

  @override
  State<offers> createState() => _OffersState();
}

class _OffersState extends State<offers> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  late Timer _timer;

  final List<String> images = [
    "images/offer2.jpg",
    "images/offer3.jpg",
    "images/offer1.png",
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 200,
        child: PageView.builder(
          controller: _controller,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Image.asset(images[index], fit: BoxFit.cover);
          },
        ),
      ),
    );
  }
}

// ======================================
// Shop Profiles
// ======================================
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class shopprofile1 extends StatelessWidget {
  const shopprofile1({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildShopCard("SHANTHI AGENCIES");
  }

  Widget _buildShopCard(String name) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, blurRadius: 8, spreadRadius: 2, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProduct("images/1.1crackers.JPG", "Flower Pot", "150", "100"),
              _buildProduct("images/1.2crackers.JPG", "Wala", "80", "60"),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildProduct(String img, String name, String oldPrice, String newPrice) {
    return Expanded(
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(img, height: 100, width: double.infinity, fit: BoxFit.cover)),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("₹$oldPrice",
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough, color: Colors.grey)),
              const SizedBox(width: 6),
              Text("₹$newPrice",
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
class shopprofile2 extends StatelessWidget {
  const shopprofile2({super.key});

  @override
  Widget build(BuildContext context) {
    return  _buildShopCard("TIRUNELVELI JILLA") ;
  }
  Widget _buildShopCard(String name) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, blurRadius: 8, spreadRadius: 2, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProduct("images/99.JPG", "99 gift", "150", "100"),
              _buildProduct("images/pencils.JPG", "pencil", "80", "60"),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildProduct(String img, String name, String oldPrice, String newPrice) {
    return Expanded(
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(img, height: 100, width: double.infinity, fit: BoxFit.cover)),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("₹$oldPrice",
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough, color: Colors.grey)),
              const SizedBox(width: 6),
              Text("₹$newPrice",
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}