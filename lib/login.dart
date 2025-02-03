import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  void _login() async {
    setState(() => _isLoading = true);

    try {
      var response = await http.post(
        Uri.parse('https://mt.diodeinfosolutions.com/api/login'),
        body: {
          'username': _usernameController.text,
          'password': _passwordController.text,
        },
      );

      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        log('Decoded Response: $data');

        if (data['auth_token'] != null) {
          var token = data['auth_token'];
          await SharedPreferences.getInstance().then((prefs) {
            prefs.setString('token', token);
          });
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          _showError("Token not found in response");
        }
      } else {
        _showError("Login failed. Please check your credentials.");
      }
    } catch (e) {
      _showError("An error occurred. Please try again.");
      log("Error: $e");
    }

    setState(() => _isLoading = false);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     appBar: AppBar(
        centerTitle: true, 
        elevation: 0, // Remove the shadow from the AppBar
        flexibleSpace: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF347c78), // Background color
                  image: DecorationImage(
                    image: AssetImage('asset/Frame 28 (1).png'), // Background image
                    fit: BoxFit.cover, // Make the image cover the space
                  ),
                ),
              ),
            ),
            
          ],
        ),
        title: Text("Login",style: TextStyle( color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      resizeToAvoidBottomInset: true, // Ensure the screen adjusts when keyboard appears
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header Text
              Text(
                "ROAST",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8,
                  color: backgroundColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Coffee Roastery",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: backgroundColor,
                ),
              ),
              SizedBox(height: 50),

              // Username TextField
              TextField(
                cursorColor: backgroundColor,
                controller: _usernameController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: backgroundColor),
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person, color: backgroundColor),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: backgroundColor),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),

              // Password TextField with show/hide functionality
              TextField(
                cursorColor: backgroundColor,
                controller: _passwordController,
                obscureText: _obscurePassword, // Toggle password visibility
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: backgroundColor),
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: backgroundColor),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: backgroundColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: backgroundColor),
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 30),

              // Login Button or Loading Indicator
              _isLoading
                  ? CircularProgressIndicator(
                      color: backgroundColor,
                    )
                  : ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
              SizedBox(height: 20),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to sign-up page
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: backgroundColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
