import "package:fe_mal/helpers/navigation_helper.dart";
import "package:fe_mal/helpers/session_helper.dart";
import "package:fe_mal/helpers/snackbar_helper.dart";
import "package:fe_mal/models/user.dart";
import "package:fe_mal/pages/home_page.dart";
import "package:fe_mal/services/api_service.dart";
import "package:flutter/material.dart";

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final body = User(email: email, password: password);

    try {
      final response = await ApiService.post("/users/login", body.toJson());
      final responseBody = response["body"];
      final responseStatusCode = response["statusCode"];

      if (responseStatusCode == 400) {
        SnackbarHelper.showErrorSnackbar(context, responseBody["message"]);
        return;
      }

      SnackbarHelper.showSuccessSnackbar(context, responseBody["message"]);

      SessionHelper.setCurrentUser(User.fromJson(responseBody["data"]));
      await Future.delayed(Duration(seconds: 2));
      NavigationHelper.navigateToPage(context, HomePage());
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("../../assets/images/mal_logo.jpg", height: 150),
            const SizedBox(height: 48),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  _login();
                },
                child: const Text("Login",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
