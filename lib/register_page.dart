import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void register(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Simpan username dan password yang terdaftar
    prefs.setString('registeredUsername', usernameController.text);
    prefs.setString('registeredPassword', passwordController.text);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Registrasi Berhasil! Sekarang kamu bisa login.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
              'Buat Akun Baru',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Daftar untuk explore lebih jauh!',
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

            // Register Button
            ElevatedButton(
              onPressed: () => register(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[400],
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Register',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),

            // Back to Login Button
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                'Kembali ke Login',
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
