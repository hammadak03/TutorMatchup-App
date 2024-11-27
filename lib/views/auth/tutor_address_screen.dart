import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TutorAddressScreen extends StatefulWidget {
  const TutorAddressScreen({Key? key}) : super(key: key);

  @override
  State<TutorAddressScreen> createState() => _TutorAddressScreenState();
}

class _TutorAddressScreenState extends State<TutorAddressScreen> {
  // Data for Provinces, Cities, and Regions
  Map<String, dynamic> _provincesData = {};
  Map<String, dynamic> _citiesData = {};
  Map<String, dynamic> _regionsData = {};

  // Selected values
  String? _selectedProvince;
  String? _selectedCity;
  String? _selectedRegion;
  String? _selectedAddressType;

  // Address Types
  final List<String> _addressTypes = ['Home', 'Academy'];

  @override
  void initState() {
    super.initState();
    _loadLocationData();
  }

  // Load Location Data from JSON Files
  Future<void> _loadLocationData() async {
    try {
      // Load provinces data
      final provincesJson =
      await rootBundle.loadString('assets/pakistan_provinces.json');
      _provincesData = json.decode(provincesJson);

      // Load cities data
      final citiesJson =
      await rootBundle.loadString('assets/pakistan_cities.json');
      _citiesData = json.decode(citiesJson);

      // Load regions data
      final regionsJson =
      await rootBundle.loadString('assets/pakistan_regions.json');
      _regionsData = json.decode(regionsJson);

      setState(() {});
    } catch (e) {
      print("Error loading JSON data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutor Address Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Province Dropdown
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

            const SizedBox(height: 16),

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

            const SizedBox(height: 16),

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

            const SizedBox(height: 16),

            // Address Type Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Address Type'),
              value: _selectedAddressType,
              items: _addressTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAddressType = value;
                });
              },
            ),

            const SizedBox(height: 24),

            // Confirm Button
            ElevatedButton(
              onPressed: () {
                _confirmAddress();
              },
              child: const Text('Confirm Address'),
            ),
          ],
        ),
      ),
    );
  }

  // Confirm Address
  void _confirmAddress() {
    if (_selectedProvince != null &&
        _selectedCity != null &&
        _selectedRegion != null &&
        _selectedAddressType != null) {
      // Print or use selected values
      print('Province: $_selectedProvince');
      print('City: $_selectedCity');
      print('Region: $_selectedRegion');
      print('Address Type: $_selectedAddressType');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Address confirmed: $_selectedProvince, $_selectedCity, $_selectedRegion ($_selectedAddressType)'),
        ),
      );
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select all fields'),
        ),
      );
    }
  }
}
