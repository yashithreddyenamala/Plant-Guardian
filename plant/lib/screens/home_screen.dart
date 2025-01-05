import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant/screens/plant_identification_screen.dart';
import 'dart:io';
import '../services/weather_service.dart';
import '../services/location_service.dart';
import '../services/fetch_plants_service.dart';
import '../widgets/alert_title.dart';
import '../widgets/app_bar.dart';
import '../widgets/custom_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map<String, dynamic>> _weatherFuture;
  late Future<List<Map<String, dynamic>>> _plantsFuture;
  late Future<List<Map<String, dynamic>>> _remaindersFuture;

  final ImagePicker _picker = ImagePicker();

  Future<void> _captureImage(BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlantIdentificationScreen(imageFile: File(pickedFile.path)),
        ),
      );
    }
  }


  @override
  void initState() {
    super.initState();
    _weatherFuture = _fetchWeather();
    _plantsFuture = FetchPlantsService.fetchPlants();
  }

  Future<Map<String, dynamic>> _fetchWeather() async {
    try {
      final position = await LocationService.getCurrentLocation();
      return await WeatherService.fetchWeather(position.latitude, position.longitude);
    } catch (e) {
      return {
        "location": "Unknown Location",
        "temperature": "N/A",
        "humidity": "N/A",
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Exit the app when the back button is pressed
        exit(0); // This will close the app
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF6EE),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _weatherFuture,
          builder: (context, weatherSnapshot) {
            if (weatherSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (weatherSnapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${weatherSnapshot.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (!weatherSnapshot.hasData) {
              return const Center(
                child: Text("Unable to fetch weather data."),
              );
            }

            final weather = weatherSnapshot.data!;

            return Column(
              children: [
                CustomHomeAppBar(
                  location: weather["location"],
                  temperature: weather["temperature"].toString(),
                  humidity: weather["humidity"].toString(),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Plants',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 150,
                          child: FutureBuilder<List<Map<String, dynamic>>>(
                            future: _plantsFuture,
                            builder: (context, plantsSnapshot) {
                              if (plantsSnapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (plantsSnapshot.hasError) {
                                return Center(
                                  child: Text(
                                    "Error: ${plantsSnapshot.error}",
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                );
                              } else if (!plantsSnapshot.hasData || plantsSnapshot.data!.isEmpty) {
                                return const Center(
                                  child: Text("No plants available."),
                                );
                              }

                              final plants = plantsSnapshot.data!;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: plants.length,
                                itemBuilder: (context, index) {
                                  final plant = plants[index];
                                  return HomePlantCard(
                                    name: plant["name"] ?? "Unknown",
                                    type: plant["type"] ?? "Unknown",
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/add-plant');
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Add new plant'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _captureImage(context);
                              },
                              icon: const Icon(Icons.camera_alt),
                              label: const Text('Identify Plant!'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[300],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Alerts for today',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: const [
                              AlertTile(
                                  title: 'Water your Succulent',
                                  subtitle: 'It’s 2 weeks old, water it twice a week.'),
                              AlertTile(
                                  title: 'Place your Fern in Sunlight',
                                  subtitle: 'It’s been 2–3 weeks since you placed it away.'),
                              AlertTile(
                                  title: 'Place your Orchid in Shade',
                                  subtitle: 'It’s been a month since you placed it in sunlight.'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: const CustomBottomNavBar(),
      ),
    );
  }
}

class HomePlantCard extends StatelessWidget {
  final String? name;
  final String? type;

  const HomePlantCard({
    Key? key,
    this.name,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150, // Constrain the width of each card
      height: 150, // Set a fixed height for the card
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.local_florist, // Plant icon
                size: 40,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name ?? "Unknown Plant",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              type ?? "Type not available",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
