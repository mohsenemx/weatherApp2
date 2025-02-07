import 'package:flutter/material.dart';
import 'package:weatherapp22/data/classes.dart';
import 'package:weatherapp22/data/api.dart';

class SearchWidget extends StatefulWidget {
  final Function(City) onCitySelected; // Callback when a city is selected
  const SearchWidget({super.key, required this.onCitySelected});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = TextEditingController();
  List<City> _searchResults = [];
  bool _isLoading = false;

  void _onTextChanged(String text) async {
    if (text.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    setState(() => _isLoading = true);
    List<City> results = await searchCity(text: text, count: 3);
    setState(() {
      _searchResults = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        TextField(
          controller: _controller,
          onChanged: _onTextChanged,
          decoration: InputDecoration(
            labelText: "Search for a city",
            border: OutlineInputBorder(),
            suffixIcon: _isLoading
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 10),

        // Search Results
        if (_searchResults.isNotEmpty)
          SizedBox(
            height: 200, // Limit height
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                City city = _searchResults[index];
                return ListTile(
                  title: Text("${city.name}, ${city.country}"),
                  onTap: () {
                    widget.onCitySelected(city);
                    _controller.clear();
                    setState(() => _searchResults = []);
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
