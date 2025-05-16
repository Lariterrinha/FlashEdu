import 'package:flashedu/Settings/userPreferencesService.dart';
import 'package:flutter/material.dart';

import '../AboutTheApp.dart';
import '../home_page.dart';

class ConfigPage extends StatefulWidget {
  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  Color selectedColor = Colors.deepPurple.shade800;
  int? _selectedCategory;

  // Color options available to the user
  final List<Color> colorOptions = [
    Colors.blueGrey,
    Colors.blueGrey.shade800,
    Colors.deepPurple.shade800,
    Colors.blue.shade800,
    Colors.green.shade800,
    Colors.red.shade900,
  ];

  // Map of categories
  final Map<int, String> categories = {
    0: 'Any Category',
    9: 'General Knowledge',
    10: 'Entertainment: Books',
    11: 'Entertainment: Film',
    12: 'Entertainment: Music',
    13: 'Entertainment: Musicals & Theatres',
    14: 'Entertainment: Television',
    15: 'Entertainment: Video Games',
    16: 'Entertainment: Board Games',
    17: 'Science & Nature',
    18: 'Science: Computers',
    19: 'Science: Mathematics',
    20: 'Mythology',
    21: 'Sports',
    22: 'Geography',
    23: 'History',
    24: 'Politics',
    25: 'Art',
    26: 'Celebrities',
    27: 'Animals',
    28: 'Vehicles',
    29: 'Entertainment: Comics',
    30: 'Science: Gadgets',
    31: 'Entertainment: Japanese Anime & Manga',
    32: 'Entertainment: Cartoon & Animations',
  };


  @override
  void initState() {
    super.initState();
    loadUserColor();
  }

  // Load the saved theme color from preferences
  void loadUserColor() async {
    Color color = await UserPreferencesService.getThemeColor();
    setState(() {
      selectedColor = color;
    });
  }

  // Save the selected color using the preferences service
  void changeColor(Color color) {
    setState(() {
      selectedColor = color;
    });
    UserPreferencesService.setThemeColor(color);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações', style: TextStyle(color: Colors.white)),
        backgroundColor: selectedColor,
      ),
      body: Column(
        children: [

          _buildSectionHeader('Select the Color Theme:'),

          Wrap(
            spacing: 10,
            children: colorOptions.map((color) {
              return GestureDetector(
                onTap: () => changeColor(color),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color == selectedColor ? Colors.black : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 20),


          _buildSectionHeader('Trivia Preferences'),

          // Difficulty Dropdown
          _buildDropdown(
            title: 'Difficulty',
            value: UserPreferencesService.getDifficulty(),
            items: ['radom','easy', 'medium', 'hard'],
            onChanged: (value) {
              setState(() => UserPreferencesService.setDifficulty(value!));
            },
          ),

          // Amount drops Down
          _buildDropdown(
            title: 'Amount',
            value: UserPreferencesService.getAmount(),
            items:  [5, 10, 15, 20],
            onChanged: (value) {
              setState(() => UserPreferencesService.setAmount(value!));
            },
          ),

          _buildDropdown<int>(
            title: 'Category',
            value: UserPreferencesService.getCategory() ?? 0,
            items: categories.keys.toList(),
            displayValue: (value) => categories[value] ?? 'Any Category',
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedCategory = value);
                UserPreferencesService.setCategory(value);
              }
            },
          ),

          SizedBox(height: 20),

          ListTile(
            leading: Icon(Icons.info),
            title: Text('About the App'),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Abouttheapp()),
            ),
          ),

        ],
      ),

    );
  }


  // Build the dropdown
  Widget _buildDropdown<T>({
    required String title,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    String Function(T)? displayValue,
  }) {
    return
      Padding(
      padding: const EdgeInsets.symmetric( horizontal: 16.0, vertical: 4 ) ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
          DropdownButtonFormField<T>(
            value: value,
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(displayValue != null ? displayValue(item) : item.toString()),
              );
            }).toList(),
            onChanged: onChanged,
            isExpanded: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: selectedColor,
        ),
      ),
    );
  }

}

