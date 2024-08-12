import "package:carousel_slider/carousel_slider.dart";
import "package:fe_mal/helpers/navigation_helper.dart";
import "package:fe_mal/helpers/session_helper.dart";
import "package:fe_mal/models/anime.dart";
import "package:fe_mal/pages/anime_page.dart";
import "package:fe_mal/pages/profile_page.dart";
import "package:fe_mal/services/api_service.dart";
import "package:fe_mal/theme/theme_notifier.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Anime> _animes = [];

  @override
  void initState() {
    super.initState();
    _fetchAnimes();
    print(SessionHelper.currentUser);
  }

  void _fetchAnimes() async {
    try {
      final response = await ApiService.get("/animes");
      final responseBody = response["body"];
      final responseStatusCode = response["statusCode"];

      if (responseStatusCode == 400) {
        return;
      }

      setState(() {
        _animes = (responseBody["data"] as List)
            .map((animeJson) => Anime.fromJson(animeJson))
            .toList();
      });
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        NavigationHelper.navigateToPage(context, AnimePage());
        break;
      case 2:
        NavigationHelper.navigateToPage(context, ProfilePage());
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
              'Welcome, ${SessionHelper.currentUser!.username!}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.blue),
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
          children: [
            SizedBox(height: 24),
            Text(
              "Recommended Animes",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue),
            ),
            SizedBox(height: 24),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
              items: _animes.map((anime) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                      ),
                      child: Image.network(
                        (ApiService.baseUrl + anime.imageUrl!),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 36),
            Image.asset("../../assets/images/mal_banner.png", height: 200),
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
