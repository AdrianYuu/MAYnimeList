import 'package:fe_mal/helpers/navigation_helper.dart';
import 'package:fe_mal/helpers/session_helper.dart';
import 'package:fe_mal/helpers/snackbar_helper.dart';
import 'package:fe_mal/models/review.dart';
import 'package:fe_mal/pages/home_page.dart';
import 'package:fe_mal/pages/profile_page.dart';
import 'package:fe_mal/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:fe_mal/models/anime.dart';
import 'package:fe_mal/services/api_service.dart';
import 'package:provider/provider.dart';

class AnimeDetailPage extends StatefulWidget {
  final Anime anime;

  AnimeDetailPage({required this.anime});

  @override
  _AnimeDetailPageState createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  int _selectedIndex = 1;
  final TextEditingController _reviewController = TextEditingController();

  void _handleSubmit() async {
    final review = _reviewController.text;
    final body = Review(
        userId: SessionHelper.currentUser!.id!,
        animeId: widget.anime.id,
        review: review);

    try {
      final response = await ApiService.post("/reviews", body.toJson());
      final responseBody = response["body"];
      final responseStatusCode = response["statusCode"];

      if (responseStatusCode == 400) {
        SnackbarHelper.showErrorSnackbar(context, responseBody["message"]);
        return;
      }

      _reviewController.clear();
      SnackbarHelper.showSuccessSnackbar(context, responseBody["message"]);
    } catch (e) {}
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        NavigationHelper.navigateToPage(context, HomePage());
        break;
      case 1:
        break;
      case 2:
        NavigationHelper.navigateToPage(context, ProfilePage());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final anime = widget.anime;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${SessionHelper.currentUser!.username!}',
              style: TextStyle(
                fontSize: 20, // Text size
                fontWeight: FontWeight.w900, // Text weight
                color: Colors.blue,
              ),
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
      body: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.info), // Icon for Information tab
                  text: 'Information',
                ),
                Tab(
                  icon: Icon(Icons.rate_review), // Icon for Reviews tab
                  text: 'Reviews',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Information tab
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Image.network(
                        ApiService.baseUrl + (anime.imageUrl ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      (anime.name! + " - " + anime.genre!),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      (anime.description!),
                      maxLines: 5, // Limit to 8 lines
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify, // Add ellipsis for overflow
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        Text('${anime.rating?.toStringAsFixed(1)}')
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '${anime.totalEpisode!} episodes',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 16.0),
                    // TextField for review
                    TextField(
                      controller: _reviewController,
                      maxLines: 1, // Ensures single line input
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your review',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            // Handle review submission
                            _handleSubmit();
                          },
                        ),
                      ),
                      scrollPhysics:
                          ClampingScrollPhysics(), // Enables horizontal scrolling
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
              // Reviews tab (initially empty)
              Center(
                child: Text('No reviews yet.'),
              ),
            ],
          ),
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
