
import 'package:flutter/material.dart';

void main() {
  runApp(const BikeShowroomApp());
}

class BikeShowroomApp extends StatelessWidget {
  const BikeShowroomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bike Showroom',
      theme: ThemeData(
        colorSchemeSeed: Colors.red,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// Bike model
class Bike {
  final String name;
  final String brand;
  final String category;
  final String price;
  final String city;

  Bike(this.name, this.brand, this.category, this.price, this.city);
}

// Showroom model
class Showroom {
  final String name;
  final String brand;
  final String city;
  final String address;

  Showroom(this.name, this.brand, this.city, this.address);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCity = 'All';
  String selectedCategory = 'All';
  String searchText = '';

  final TextEditingController searchController =
      TextEditingController();

  final List<String> cities = [
    'All',
    'Namakkal',
    'Salem',
  ];

  final List<String> categories = [
    'All',
    'Sports',
    'Commuter',
    'Cruiser',
    'Scooter',
    'Electric',
  ];

  // Sample bike inventory. Update prices with dealer quotes.
  final List<Bike> bikes = [
    Bike('R15 V4', 'Yamaha', 'Sports', '₹1,85,000', 'Salem'),
    Bike('MT-15', 'Yamaha', 'Sports', '₹1,70,000', 'Namakkal'),
    Bike('Classic 350', 'Royal Enfield', 'Cruiser',
        '₹1,95,000', 'Salem'),
    Bike('Hunter 350', 'Royal Enfield', 'Cruiser',
        '₹1,50,000', 'Namakkal'),
    Bike('Pulsar N160', 'Bajaj', 'Sports',
        '₹1,25,000', 'Salem'),
    Bike('Apache RTR 160', 'TVS', 'Sports',
        '₹1,20,000', 'Namakkal'),
    Bike('Splendor Plus', 'Hero', 'Commuter',
        '₹80,000', 'Salem'),
    Bike('Shine 125', 'Honda', 'Commuter',
        '₹85,000', 'Namakkal'),
    Bike('Activa 125', 'Honda', 'Scooter',
        '₹95,000', 'Salem'),
    Bike('Jupiter 125', 'TVS', 'Scooter',
        '₹90,000', 'Namakkal'),
    Bike('Ather 450X', 'Ather', 'Electric',
        '₹1,50,000', 'Salem'),
    Bike('Chetak', 'Bajaj', 'Electric',
        '₹1,20,000', 'Namakkal'),
  ];

  // Sample local showroom directory
  final List<Showroom> showrooms = [
    Showroom('SS Agencies', 'Yamaha', 'Namakkal',
        'R.P. Pudur, Tiruchengode Road'),
    Showroom('Royal Annanmar', 'Royal Enfield', 'Namakkal',
        'Salem Road'),
    Showroom('SPM Honda', 'Honda', 'Namakkal',
        'Swamy Nagar, Salem Road'),
    Showroom('Chamundi Enfield', 'Royal Enfield', 'Salem',
        'Four Roads, Salem'),
    Showroom('Sowdeswari Motors', 'TVS', 'Salem',
        'Hasthampatti, Salem'),
    Showroom('Triummph Honda', 'Honda', 'Salem',
        'Swarnapuri, Omalur Main Road'),
    Showroom('KTM Husqvarna Salem', 'KTM', 'Salem',
        'Meyyanur Main Road'),
    Showroom('Swarnambigai Bajaj', 'Bajaj', 'Salem',
        'Trichy Main Road'),
    Showroom('VR Suzuki', 'Suzuki', 'Salem',
        'Cherry Road, Hasthampatti'),
  ];

  List<Bike> get filteredBikes {
    return bikes.where((bike) {
      final cityMatch = selectedCity == 'All' ||
          bike.city == selectedCity;

      final categoryMatch = selectedCategory == 'All' ||
          bike.category == selectedCategory;

      final searchMatch =
          bike.name.toLowerCase().contains(
                searchText.toLowerCase(),
              ) ||
          bike.brand.toLowerCase().contains(
                searchText.toLowerCase(),
              );

      return cityMatch && categoryMatch && searchMatch;
    }).toList();
  }

  List<Showroom> get filteredShowrooms {
    return showrooms.where((shop) {
      final cityMatch = selectedCity == 'All' ||
          shop.city == selectedCity;

      final searchMatch =
          shop.name.toLowerCase().contains(
                searchText.toLowerCase(),
              ) ||
          shop.brand.toLowerCase().contains(
                searchText.toLowerCase(),
              );

      return cityMatch && searchMatch;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: const Text(
          'BIKE SHOWROOM',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: const Icon(Icons.two_wheeler),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // Banner
          Container(
            height: 150,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'FIND YOUR DREAM BIKE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'All Brands | All Models | Best Collection',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Search
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search bike or brand...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
          ),

          const SizedBox(height: 15),

          // City selection
          const Text(
            'Select City',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            value: selectedCity,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
            ),
            items: cities.map((city) {
              return DropdownMenuItem(
                value: city,
                child: Text(city),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCity = value!;
              });
            },
          ),

          const SizedBox(height: 20),

          // Categories
          const Text(
            'Bike Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map((category) {
              return ChoiceChip(
                label: Text(category),
                selected: selectedCategory == category,
                onSelected: (selected) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 25),

          // Bike list
          const Text(
            'Available Bikes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          if (filteredBikes.isEmpty)
            const Text('No bikes found.')
          else
            ...filteredBikes.map((bike) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.two_wheeler,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    bike.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${bike.brand} • ${bike.category}\n${bike.city}',
                  ),
                  isThreeLine: true,
                  trailing: Text(
                    bike.price,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),

          const SizedBox(height: 25),

          // Showroom list
          const Text(
            'Bike Showrooms',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          if (filteredShowrooms.isEmpty)
            const Text('No showrooms found.')
          else
            ...filteredShowrooms.map((shop) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.store,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    shop.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${shop.brand}\n${shop.address}\n${shop.city}',
                  ),
                  isThreeLine: true,
                  trailing: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
