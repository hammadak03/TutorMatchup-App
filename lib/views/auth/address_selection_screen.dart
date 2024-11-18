import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
  final List<String> _provinces = ['Province 1', 'Province 2', 'Province 3'];
  final List<String> _cities = ['City 1', 'City 2', 'City 3'];
  final List<String> _regions = ['Region 1', 'Region 2', 'Region 3'];

  // Selected Location
  String? _selectedProvince;
  String? _selectedCity;
  String? _selectedRegion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address'),
      ),
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onTap: (LatLng latLng) {
              // Handle map tap to update selected address
              _updateSelectedAddress(latLng);
            },
          ),

          // Sliding Panel
          SlidingUpPanel(
            controller: _panelController,
            minHeight: 0,
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

          // Province Dropdown
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Province'),
            value: _selectedProvince,
            items: _provinces.map((province) {
              return DropdownMenuItem(
                value: province,
                child: Text(province),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedProvince = value;
              });
            },
          ),

          // City Dropdown
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'City'),
            value: _selectedCity,
            items: _cities.map((city) {
              return DropdownMenuItem(
                value: city,
                child: Text(city),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCity = value;
              });
            },
          ),

          // Region Dropdown
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Region'),
            value: _selectedRegion,
            items: _regions.map((region) {
              return DropdownMenuItem(
                value: region,
                child: Text(region),
              );
            }).toList(),
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
    Navigator.pop(context, _selectedAddress);
  }
}