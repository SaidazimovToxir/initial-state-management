import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:homework43/utils/my_style.dart';
import 'package:homework43/views/widgets/custom_drawer.dart';
import 'package:homework43/views/widgets/dialog_box.dart';
import 'package:homework43/views/widgets/password_dialog.dart';

class SettingsScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onBackgroundChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<Color> onColorChanged;
  final Function(Color, double) onTextChanged;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
    required this.onBackgroundChanged,
    required this.onLanguageChanged,
    required this.onColorChanged,
    required this.onTextChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _items = ['uz', 'eng', 'rus'];
  String? _selectedItem;
  Color _currentColor = AppConstants.appColor;

  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Color picker panel',
            style: TextStyle(
              color: AppConstants.textColor,
              fontSize: AppConstants.textSize,
            ),
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (Color color) {
                _currentColor = color;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                widget.onColorChanged(_currentColor);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: AppConstants.textColor,
            fontSize: AppConstants.textSize,
          ),
        ),
        actions: [
          DropdownButton(
            hint: Text(AppConstants.language),
            value: _selectedItem,
            onChanged: (value) {
              widget.onLanguageChanged(value ?? '');
            },
            items: _items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      drawer: CustomDrawer(
        onThemeChanged: widget.onThemeChanged,
        onBackgroundChanged: widget.onBackgroundChanged,
        onLanguageChanged: widget.onLanguageChanged,
        onColorChanged: widget.onColorChanged,
        onTextChanged: widget.onTextChanged,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  AppConstants.imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SwitchListTile(
                value: AppConstants.themeMode == ThemeMode.dark,
                onChanged: widget.onThemeChanged,
                title: Text(
                  "Night mode",
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Write image url',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_textEditingController.text.isEmpty) {
                    widget.onBackgroundChanged(
                        'https://cdn.pixabay.com/photo/2020/08/08/13/34/abstract-5473052_960_720.jpg');
                  } else {
                    widget.onBackgroundChanged(_textEditingController.text);
                  }
                  setState(() {});
                },
                icon: const Icon(Icons.check_circle),
              ),
              TextButton(
                onPressed: () {
                  _openColorPicker();
                },
                child: Text(
                  'Change color',
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const PasswordAlertDialog();
                    },
                  );
                },
                child: Text(
                  'Change password',
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditTextAlertDialog(
                      onTextChanged: widget.onTextChanged,
                    ),
                  );
                },
                child: Text(
                  'Change text style',
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
