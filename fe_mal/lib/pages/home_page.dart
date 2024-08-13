import "package:carousel_slider/carousel_slider.dart";
import "package:fe_mal/helpers/navigation_helper.dart";
import "package:fe_mal/helpers/session_helper.dart";
import "package:fe_mal/helpers/snackbar_helper.dart";
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
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        NavigationHelper.navigateToPage(context, AnimePage());
        break;
      case 2:
        NavigationHelper.navigateToPage(context, ProfilePage());
        break;
    }
  }

  void _fetchAnimes() async {
    try {
      final response = await ApiService.get("/animes");
      final responseBody = response["body"];
      final responseStatusCode = response["statusCode"];

      if (responseStatusCode == 400) {
        SnackbarHelper.showErrorSnackbar(context, responseBody["message"]);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Welcome, ${SessionHelper.currentUser!.username!}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                const PopupMenuItem<String>(
                  value: "Light Theme",
                  child: const Text("Light Theme"),
                ),
                const PopupMenuItem<String>(
                  value: "Dark Theme",
                  child: const Text("Dark Theme"),
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("../../assets/images/mal_banner.png", height: 200),
                const SizedBox(height: 12),
                const Text(
                  "MyAYnimeList is a vibrant community where anime enthusiasts from all around the world come together to share their passion for anime.",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 36),
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
                          child: Image.network(
                            (ApiService.baseUrl + anime.imageUrl!),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: const Icon(Icons.movie),
            label: "Anime",
          ),
          const BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "Profile",
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
