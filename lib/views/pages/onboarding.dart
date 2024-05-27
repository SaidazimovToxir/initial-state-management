import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homework43/utils/my_style.dart';
import 'package:homework43/views/pages/home_page.dart';

class Onboarding extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onBackgroundChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<Color> onColorChanged;
  final Function(Color, double) onTextChanged;

  const Onboarding({
    super.key,
    required this.onThemeChanged,
    required this.onBackgroundChanged,
    required this.onLanguageChanged,
    required this.onColorChanged,
    required this.onTextChanged,
  });

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<TextEditingController> _textEditingControllersList = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  for (int i = 0; i < _textEditingControllersList.length; i++)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _textEditingControllersList[i],
                          maxLength: 1,
                          onChanged: (value) {
                            FocusScope.of(context).nextFocus();
                          },
                          decoration: InputDecoration(
                            counterText: '',
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Text(errorMessage),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  errorMessage = '';

                  List<String> password = AppConstants.password.split('');
                  for (int i = 0; i < _textEditingControllersList.length; i++) {
                    if (password[i] != _textEditingControllersList[i].text) {
                      errorMessage = 'Invalid password';
                      break;
                    }
                  }
                  if (errorMessage.isEmpty) {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return HomePage(
                            onThemeChanged: widget.onThemeChanged,
                            onBackgroundChanged: widget.onBackgroundChanged,
                            onLanguageChanged: widget.onLanguageChanged,
                            onColorChanged: widget.onColorChanged,
                            onTextChanged: widget.onTextChanged,
                          );
                        },
                      ),
                    );
                  }
                  setState(() {});
                },
                child: Text('Enter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
