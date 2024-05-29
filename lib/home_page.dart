import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:krishi_vikas/features/app_services/Equipment/add_equipment_record.dart';
import 'package:krishi_vikas/features/app_services/Equipment/equipment.dart';
import 'package:krishi_vikas/features/app_services/animal_husbandry/add_animal_record.dart';
import 'package:krishi_vikas/features/app_services/animal_husbandry/animal_husbandry.dart';
import 'package:krishi_vikas/features/app_services/chatbot/gemini.dart';
import 'package:krishi_vikas/features/app_services/farm_labours/add_farm_labours.dart';
import 'package:krishi_vikas/features/app_services/farm_labours/farm_labours.dart';
import 'package:krishi_vikas/features/app_services/fertilizer/add_fertilizer_record.dart';
import 'package:krishi_vikas/features/app_services/fertilizer/fertilizer.dart';
import 'package:krishi_vikas/features/app_services/grains/add_grains_records.dart';
import 'package:krishi_vikas/features/app_services/grains/grains.dart';
import 'package:krishi_vikas/features/app_services/soil_analysis/add_soil_analysis_records.dart';
import 'package:krishi_vikas/features/app_services/soil_analysis/soil_analysis.dart';
import 'package:krishi_vikas/features/app_services/tourism/add_tourism_records.dart';
import 'package:krishi_vikas/features/app_services/tourism/tourism.dart';
import 'package:krishi_vikas/features/app_services/vehicle_rent/add_vehicle_rent_records.dart';
import 'package:krishi_vikas/features/app_services/vehicle_rent/vehicle_rent.dart';
import 'package:krishi_vikas/features/app_services/veterinarian/add_veterianarian_records.dart';
import 'package:krishi_vikas/features/app_services/veterinarian/viterinary.dart';
import 'package:krishi_vikas/features/auth/pages/login_or_register.dart';
import 'package:krishi_vikas/utils/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  List<String> services = [
    "Veterinarian",
    "Vehicle Rent",
    "Equipment",
    "Farm Labours",
    "Animal Husbandry",
    "Grains",
    "Fertilizer",
    "Soil Analysis",
    "Tourism",
    "Chat Bot",
  ];

  List servicesList = [
    const Veterianarian(),
    const VehicleRent(),
    const Equipment(),
    const FarmLabours(),
    const AnimalHusbandry(),
    const Grains(),
    const Fertilizer(),
    const SoilAnalysis(),
    const Tourism(),
    const GEMINI(),
  ];

  List<Widget> carouselItems = [
    Image.asset('assets/images/img1.jpg'),
    Image.asset('assets/images/img2.jpg'),
    Image.asset('assets/images/img3.jpg'),
    Image.asset('assets/images/img4.jpg'),
  ];

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    Navigator.push(
      context,
      PageTransition(
        child: LoginOrRegister(),
        type: PageTransitionType.rightToLeftWithFade,
        curve: Curves.easeInOutBack,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: primary_green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("FarmBuddy",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                  ],
                ),
              ),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddVeterianarianRecord()));
                  },
                  leading: const Icon(Icons.personal_injury_outlined),
                  title: const Text("Veterinarian"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddVehicleRecord()));
                  },
                  leading: const Icon(Icons.car_repair_outlined),
                  title: const Text("Vehical Rent"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddEquipmentRecord()));
                  },
                  leading: const Icon(Icons.production_quantity_limits),
                  title: const Text("Equipment"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddFarmLaoursRecords()));
                  },
                  leading: const Icon(Icons.equalizer_outlined),
                  title: const Text("Farm Labours"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddAnimalRecord()));
                  },
                  leading: const Icon(Icons.person_2_rounded),
                  title: const Text("Animal Husbandry"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddGrainsRecord()));
                  },
                  leading: const Icon(Icons.equalizer_outlined),
                  title: const Text("Grains"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddFertilizerRecord(),
                        ));
                  },
                  leading: const Icon(Icons.personal_injury_outlined),
                  title: const Text("Fertilizer"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddSoilAnalysisRecord()));
                  },
                  leading: const Icon(Icons.equalizer_outlined),
                  title: const Text("Soil Analysis"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddTourismRecord()));
                  },
                  leading: const Icon(Icons.equalizer_outlined),
                  title: const Text("Tourism"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GEMINI()));
                  },
                  leading: Icon(Icons.equalizer_outlined),
                  title: Text("Chat Bot"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove("token");
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: LoginOrRegister(),
                        type: PageTransitionType.rightToLeftWithFade,
                        curve: Curves.easeInOutBack,
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () => Scaffold.of(context).openDrawer(),
        //     icon: const Icon(Icons.menu, color: Colors.white)),
        backgroundColor: primary_green,
        centerTitle: true,
        title: Text("Kisan Guide",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primary_green,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CarouselSlider(
              items: carouselItems,
              options: CarouselOptions(
                height:
                    size.height * 0.3, // Customize the height of the carousel
                autoPlay: true, // Enable auto-play
                enlargeCenterPage: true, // Increase the size of the center item
                enableInfiniteScroll: true, // Enable infinite scroll
                onPageChanged: (index, reason) {
                  // Optional callback when the page changes
                  // You can use it to update any additional UI components
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => servicesList[index]));
                    },
                    child: customCard(
                        services[index], "assets/images/${index + 1}.png"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget customDrawerTile(String title, Icon icon) {
  return Card(
    child: ListTile(
      leading: icon,
      title: Text(title),
    ),
  );
}

Widget customCard(String cropName, String cropImage) {
  return Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey[400],
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
            offset: const Offset(2, 2),
            color: Colors.grey[100]!,
            spreadRadius: 1,
            blurRadius: 2),
        BoxShadow(
            offset: const Offset(-2, -2),
            color: Colors.grey[100]!,
            spreadRadius: 1,
            blurRadius: 2),
      ],
    ),
    child: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (cropImage != "")
          SizedBox(height: 100, child: Image.asset(cropImage)),
        const SizedBox(height: 10),
        Text(cropName,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
      ],
    )),
  );
}
