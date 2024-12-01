import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> _countries = ['us', 'gb', 'ca', 'au', 'in'];
  String? _selectedCountry;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _loadCountry();
  }

  void _loadCountry() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCountry = _prefs?.getString('country') ?? 'us';
    });
  }

  void _saveCountry(String country) {
    _prefs?.setString('country', country);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Select Country'),
            trailing: DropdownButton<String>(
              value: _selectedCountry,
              items: _countries
                  .map((country) => DropdownMenuItem(
                        value: country,
                        child: Text(country.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                  _saveCountry(value!);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}