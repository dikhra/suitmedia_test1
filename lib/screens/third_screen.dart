import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:suitmedia_test/models/user.dart';
import 'package:suitmedia_test/screens/second_screen.dart';
import 'package:http/http.dart' as http;

class ThirdScreen extends StatefulWidget {
  final String name;

  const ThirdScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late List<User> userData;
  int currentPage = 1;
  bool isLoading = false;
  late ScrollController _scrollController;

  Future<void> _refreshData() async {
    setState(() {
      currentPage = 1;
      userData.clear();
      _fetchUserData();
    });
  }

  Future<void> _fetchUserData() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=$currentPage&per_page=10'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> newUserList = data['data'];
        final List<User> users =
            newUserList.map((user) => User.fromJson(user)).toList();

        setState(() {
          userData.addAll(users);
          currentPage++;
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    userData = [];
    _scrollController = ScrollController()..addListener(_scrollListener);
    _fetchUserData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (!_scrollController.position.outOfRange &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading) {
      _fetchUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Third Screen',
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
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(20.0),
          itemCount: userData.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                    userData[index].name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  subtitle: Text(
                    userData[index].email,
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromRGBO(104, 103, 119, 1)),
                  ),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(userData[index].avatar),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondScreen(
                          name: widget.name,
                          selectedName: userData[index].name,
                        ),
                      ),
                    );
                  },
                ),
                const Divider(
                  color: Color.fromRGBO(226, 227, 228, 1),
                  height: 1.0,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
