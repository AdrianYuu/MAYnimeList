import "package:fe_mal/helpers/navigation_helper.dart";
import "package:fe_mal/helpers/session_helper.dart";
import "package:fe_mal/pages/anime_page.dart";
import "package:fe_mal/pages/home_page.dart";
import "package:fe_mal/pages/login_page.dart";
import "package:fe_mal/theme/theme_notifier.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        NavigationHelper.navigateToPage(context, HomePage());
        break;
      case 1:
        NavigationHelper.navigateToPage(context, AnimePage());
        break;
    }
  }

  void _logout() {
    SessionHelper.setCurrentUser(null);
    NavigationHelper.navigateToPage(context, LoginPage());
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
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 140,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    _logout();
                  },
                  child: const Text("Logout",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: Colors.red),
                ),
              ),
            )
          ],
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
