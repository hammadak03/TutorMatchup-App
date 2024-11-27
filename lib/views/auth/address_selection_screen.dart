import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../routes/routes.dart';

class AddressSelectionScreen extends StatefulWidget {
  const AddressSelectionScreen({Key? key}) : super(key: key);

  @override
  State<AddressSelectionScreen> createState() =>
      _AddressSelectionScreenState();
}

class _AddressSelectionScreenState extends State<AddressSelectionScreen> {
  // Google Map Controller
  late GoogleMapController _mapController;

  // Initial Camera Position
  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962), // Default location
    zoom: 14.0,
  );

  // Selected Address
  String _selectedAddress = '';

  // Sliding Panel Controller
  final PanelController _panelController = PanelController();

  // Sample Data for Provinces, Cities, and Regions
  Map<String, dynamic> _provincesData = {};
  Map<String, dynamic> _citiesData = {};
  Map<String, dynamic> _regionsData = {};

  // Selected Location
  String? _selectedProvince;
  String? _selectedCity;
  String? _selectedRegion;

  @override
  void initState() {
    super.initState();
    _loadLocationData();
  }

  // Load Location Data from JSON Files
  Future<void> _loadLocationData() async {
    // Load provinces data
    final provincesJson =
    await rootBundle.loadString('assets/pakistan_provinces.json');
    _provincesData = json.decode(provincesJson);

    // Load cities data
    final citiesJson = await rootBundle.loadString('assets/pakistan_cities.json');
    _citiesData = json.decode(citiesJson);

    // Load regions data
    final regionsJson =
    await rootBundle.loadString('assets/pakistan_regions.json');
    _regionsData = json.decode(regionsJson);

    setState(() {}); // Update UI after loading data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address'),
      ),
      body: Stack(
        children: [
          // Google Map
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[300], // Light gray background
            child: const Center(
              child: Text('Map will be here. Select Address'),
            ),
          ),

          // Sliding Panel
          SlidingUpPanel(
            controller: _panelController,
            minHeight: 100,
            maxHeight: MediaQuery.of(context).size.height * 0.5, // Adjust as needed
            panel: _buildSlidingPanelContent(),
          ),
        ],
      ),
    );
  }

  // Build Sliding Panel Content
  Widget _buildSlidingPanelContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Location',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Province Dropdown (Normal)
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Province'),
            value: _selectedProvince,
            items: _provincesData.keys.map((province) {
              return DropdownMenuItem(
                value: province,
                child: Text(province),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedProvince = value;
                _selectedCity = null; // Reset city and region when province changes
                _selectedRegion = null;
              });
            },
          ),

          // City Dropdown (filtered by province)
          if (_selectedProvince != null)
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'City'),
              value: _selectedCity,
              items: (_citiesData[_selectedProvince] as List<dynamic>?)
                  ?.map((city) => DropdownMenuItem(
                value: city.toString(),
                child: Text(city.toString()),
              ))
                  .toList() ??
                  [],
              onChanged: (value) {
                setState(() {
                  _selectedCity = value;
                  _selectedRegion = null; // Reset region when city changes
                });
              },
            ),

          // Region Dropdown (filtered by city)
          if (_selectedCity != null)
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Region'),
              value: _selectedRegion,
              items: (_regionsData[_selectedCity] as List<dynamic>?)
                  ?.map((region) => DropdownMenuItem(
                value: region.toString(),
                child: Text(region.toString()),
              ))
                  .toList() ??
                  [],
              onChanged: (value) {
                setState(() {
                  _selectedRegion = value;
                });
              },
            ),

          const SizedBox(height: 24),

          // Confirm Button
          ElevatedButton(
            onPressed: () {
              // Handle address confirmation
              _confirmAddress();
            },
            child: const Text('Confirm Address'),
          ),
        ],
      ),
    );
  }

  // Update Selected Address
  Future<void> _updateSelectedAddress(LatLng latLng) async {
    // Use Geocoding or other methods to get address from LatLng
    // For this example, we'll just display the LatLng
    setState(() {
      _selectedAddress = 'LatLng: ${latLng.latitude}, ${latLng.longitude}';
    });
  }

  // Confirm Address
  void _confirmAddress() {
    // Handle address confirmation, e.g., navigate back with selected address
    Navigator.pushNamed(context, Routes.studentHome);
  }
}