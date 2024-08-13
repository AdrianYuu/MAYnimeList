import "package:fe_mal/helpers/navigation_helper.dart";
import "package:fe_mal/helpers/session_helper.dart";
import "package:fe_mal/helpers/snackbar_helper.dart";
import "package:fe_mal/models/anime.dart";
import "package:fe_mal/pages/anime_detail_page.dart";
import "package:fe_mal/pages/home_page.dart";
import "package:fe_mal/pages/profile_page.dart";
import "package:fe_mal/services/api_service.dart";
import "package:fe_mal/theme/theme_notifier.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class AnimePage extends StatefulWidget {
  @override
  _AnimePageState createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  int _selectedIndex = 1;
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
      case 0:
        NavigationHelper.navigateToPage(context, HomePage());
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

  void _onCardTapped(Anime anime) {
    NavigationHelper.navigateToPage(context, AnimeDetailPage(anime: anime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Welcome, ${SessionHelper.currentUser!.username!}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
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
        child: ListView.builder(
          itemCount: _animes.length,
          itemBuilder: (context, index) {
            final anime = _animes[index];
            return GestureDetector(
              onTap: () => {_onCardTapped(anime)},
              child: Card(
                margin: EdgeInsets.only(bottom: 16.0),
                child: Column(
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(4)),
                        child: Image.network(
                          (ApiService.baseUrl + anime.imageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (anime.name! + " - " + anime.genre!),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            (anime.description!),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            "${anime.totalEpisode!} episodes",
                            style: TextStyle(color: Colors.blue),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20,
                              ),
                              Text("${anime.rating?.toStringAsFixed(1)}")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
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
