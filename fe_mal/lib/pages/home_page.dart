import "package:carousel_slider/carousel_slider.dart";
import "package:fe_mal/services/api_service.dart";
import "package:fe_mal/theme/theme_notifier.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:hexcolor/hexcolor.dart";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _fetchAnimes() async {
    try {
      final response = await ApiService.get("/animes");
      final responseBody = response["body"];
      final responseStatusCode = response["statusCode"];

      if (responseStatusCode == 400) {
        return;
      }
    } catch (e) {}
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/anime');
        break;
      case 2:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'MyAYNimeList',
              style: TextStyle(
                  fontSize: 20, // Text size
                  fontWeight: FontWeight.w900, // Text weight
                  color: HexColor("#3054a4")),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              final themeNotifier =
                  Provider.of<ThemeNotifier>(context, listen: false);
              if (value == "Light Theme") {
                themeNotifier.setTheme(ThemeData.light());
              } else if (value == "Dark Theme") {
                themeNotifier.setTheme(ThemeData.dark());
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: "Light Theme",
                  child: Text("Light Theme"),
                ),
                PopupMenuItem<String>(
                  value: "Dark Theme",
                  child: Text("Dark Theme"),
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
              items: [
                'https://via.placeholder.com/400x200.png?text=Slide+1',
                'https://via.placeholder.com/400x200.png?text=Slide+2',
                'https://via.placeholder.com/400x200.png?text=Slide+3',
              ]
                  .map((item) => Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                            ),
                            child: Image.network(item, fit: BoxFit.cover),
                          );
                        },
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Anime',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: HexColor("#3054a4"),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
