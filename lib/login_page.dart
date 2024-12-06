import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_page.dart';
import 'categories_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil username dan password dari SharedPreferences
    String? savedUsername = prefs.getString('registeredUsername');
    String? savedPassword = prefs.getString('registeredPassword');

    if (savedUsername == null || savedPassword == null) {
      // Jika tidak ada data terdaftar
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content:
              Text('Kamu belum terdaftar, silahkan daftar terlebih dahulu!.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Periksa apakah username dan password cocok
      if (usernameController.text == savedUsername &&
          passwordController.text == savedPassword) {
        // Login berhasil
        prefs.setString(
            'username', usernameController.text); // Simpan login aktif
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CategoriesPage(username: usernameController.text),
          ),
        );
      } else {
        // Login gagal
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Username atau Password salah.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.brown[600], // Warna tema cokelat untuk AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30),
            // Heading
            Text(
              'Selamat Datang!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Silahkan Login untuk Menuju Halaman Berikutnya',
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            // Username Field
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.brown[800]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown[600]!),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Password Field
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.brown[800]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown[600]!),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),

            // Login Button
            ElevatedButton(
              onPressed: () => login(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[400],
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),

            // Register Button
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text(
                'Belum punya akun? Register',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.brown[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
