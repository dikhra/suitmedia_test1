import 'package:flutter/material.dart';
import 'package:suitmedia_test/screens/third_screen.dart';

class SecondScreen extends StatelessWidget {
  final String name;
  final String selectedName;

  const SecondScreen(
      {Key? key, required this.name, this.selectedName = 'Selected User Name'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Second Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color.fromRGBO(85, 74, 240, 1),
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Color.fromRGBO(226, 227, 228, 1),
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Center(
              child: Text(
                selectedName,
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                width: double.infinity,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThirdScreen(
                                  name: name,
                                )));
                  },
                  backgroundColor: const Color.fromRGBO(43, 99, 123, 1),
                  foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
                  child: const Text('Choose a User'),
                )),
          ],
        ),
      ),
    );
  }
}
