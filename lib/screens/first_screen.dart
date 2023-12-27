import 'package:flutter/material.dart';
import 'package:suitmedia_test/screens/second_screen.dart';

bool isPalindrome(String text) {
  String cleanedText =
      text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
  String reversedText = cleanedText.split('').reversed.join('');
  return cleanedText == reversedText;
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _textName = TextEditingController();

  final TextEditingController _textPalindrome = TextEditingController();

  bool _isPalindrome = false;

  void _checkPalindrome(BuildContext context) {
    String inputTextPalindrome = _textPalindrome.text;
    _isPalindrome = isPalindrome(inputTextPalindrome);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            _isPalindrome ? 'isPalindrome' : 'not palindrome',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/ic_photo.png',
                  width: 100.0,
                ),
                const SizedBox(height: 60.0),
                TextField(
                  controller: _textName,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(226, 227, 228, 1),
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 25.0),
                TextField(
                  controller: _textPalindrome,
                  decoration: const InputDecoration(
                    hintText: 'Palindrome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(226, 227, 228, 1),
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 45.0),
                SizedBox(
                  width: double.infinity,
                  child: FloatingActionButton(
                    onPressed: () => _checkPalindrome(context),
                    backgroundColor: const Color.fromRGBO(43, 99, 123, 1),
                    foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
                    child: const Text('CHECK'),
                  ),
                ),
                const SizedBox(height: 15.0),
                SizedBox(
                  width: double.infinity,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondScreen(
                                    name: _textName.text,
                                  )));
                    },
                    backgroundColor: const Color.fromRGBO(43, 99, 123, 1),
                    foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
                    child: const Text('NEXT'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
