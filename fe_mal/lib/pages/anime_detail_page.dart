import "package:fe_mal/helpers/navigation_helper.dart";
import "package:fe_mal/helpers/session_helper.dart";
import "package:fe_mal/helpers/snackbar_helper.dart";
import "package:fe_mal/models/review.dart";
import "package:fe_mal/pages/home_page.dart";
import "package:fe_mal/pages/profile_page.dart";
import "package:fe_mal/theme/theme_notifier.dart";
import "package:flutter/material.dart";
import "package:fe_mal/models/anime.dart";
import "package:fe_mal/services/api_service.dart";
import "package:provider/provider.dart";

class AnimeDetailPage extends StatefulWidget {
  final Anime anime;

  AnimeDetailPage({required this.anime});

  @override
  _AnimeDetailPageState createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _editReviewController = TextEditingController();

  int _selectedIndex = 1;
  List<Review> _reviews = [];
  Map<int, String> _usernames = {};

  @override
  void initState() {
    _fetchReviews();
    super.initState();
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

  void _handleSubmitReview() async {
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
      _fetchReviews();
      SnackbarHelper.showSuccessSnackbar(context, responseBody["message"]);
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  void _fetchReviews() async {
    try {
      final response = await ApiService.get("/reviews/${widget.anime.id}");
      final responseBody = response["body"];
      final responseStatusCode = response["statusCode"];

      if (responseStatusCode == 400) {
        return;
      }

      final reviews = (responseBody["data"] as List)
          .map((reviewJson) => Review.fromJson(reviewJson))
          .toList();

      setState(() {
        _reviews = reviews;
      });

      for (final review in reviews) {
        if (!_usernames.containsKey(review.userId)) {
          _fetchUsername(review.userId!);
        }
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  void _fetchUsername(int userId) async {
    try {
      final response = await ApiService.get("/users/${userId}");
      final responseBody = response["body"];
      final responseStatusCode = response["statusCode"];

      if (responseStatusCode == 400) {
        SnackbarHelper.showErrorSnackbar(context, responseBody["message"]);
        return;
      }

      final username = responseBody["data"]["username"];

      setState(() {
        _usernames[userId] = username;
      });
    } catch (e) {
      throw Exception("Error : $e");
    }
  }

  void _editReview(Review review) {
    _editReviewController.text = review.review!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Review"),
          content: TextField(
            controller: _editReviewController,
            maxLines: 4,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter new review",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                final updatedReview = _editReviewController.text;
                final reviewObj = Review(review: updatedReview);

                try {
                  final response = await ApiService.put(
                      "/reviews/${review.id}", reviewObj.toJson());
                  final responseBody = response["body"];
                  final responseStatusCode = response["statusCode"];

                  if (responseStatusCode == 400) {
                    SnackbarHelper.showErrorSnackbar(
                        context, responseBody["message"]);
                    return;
                  }

                  Navigator.of(context).pop();
                  SnackbarHelper.showSuccessSnackbar(
                      context, responseBody["message"]);
                  _fetchReviews();
                } catch (e) {
                  throw Exception("Error: $e");
                }
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void _deleteReview(Review review) async {
    try {
      final response = await ApiService.del("/reviews/${review.id}");
      final responseBody = response["body"];
      final responseStatusCode = response["statusCode"];

      if (responseStatusCode == 400) {
        SnackbarHelper.showErrorSnackbar(context, responseBody["message"]);
        return;
      }

      SnackbarHelper.showSuccessSnackbar(context, responseBody["message"]);
      _fetchReviews();
    } catch (e) {
      throw Exception("Error: $e");
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
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              tabs: [
                const Tab(
                  icon: Icon(Icons.info),
                  text: "Information",
                ),
                const Tab(
                  icon: Icon(Icons.rate_review),
                  text: "Reviews",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Image.network(
                          ApiService.baseUrl + (anime.imageUrl ?? ""),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        (anime.name!),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        (anime.genre!),
                        style: TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        anime.description!,
                        textAlign: TextAlign.justify,
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
                      const SizedBox(height: 8.0),
                      Text(
                        "${anime.totalEpisode!} episodes",
                        style: TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _reviewController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Enter your review",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: _handleSubmitReview,
                          ),
                        ),
                        scrollPhysics: ClampingScrollPhysics(),
                      ),
                      const SizedBox(height: 80.0),
                    ],
                  ),
                ),
              ),
              _reviews.isEmpty
                  ? Center(
                      child: const Text("No reviews yet."),
                    )
                  : ListView.builder(
                      itemCount: _reviews.length,
                      itemBuilder: (context, index) {
                        final review = _reviews[index];
                        final username = _usernames[review.userId];
                        final isUserReview =
                            review.userId == SessionHelper.currentUser!.id!;
                        return Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            title: Text(
                              username!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              review.review!,
                              textAlign: TextAlign.justify,
                            ),
                            trailing: isUserReview
                                ? PopupMenuButton<String>(
                                    onSelected: (String value) {
                                      if (value == "Edit") {
                                        _editReview(review);
                                      } else if (value == "Delete") {
                                        _deleteReview(review);
                                      }
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        const PopupMenuItem<String>(
                                          value: "Edit",
                                          child: const Text("Edit"),
                                        ),
                                        const PopupMenuItem<String>(
                                          value: "Delete",
                                          child: const Text("Delete"),
                                        ),
                                      ];
                                    },
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
            ],
          ),
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
