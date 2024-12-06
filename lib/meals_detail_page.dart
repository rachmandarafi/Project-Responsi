import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../api_service.dart';

class MealDetailPage extends StatelessWidget {
  final String mealId;

  MealDetailPage({required this.mealId});

  // Fungsi untuk membuka URL video
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Video Error $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meal Details')),
      body: FutureBuilder(
        future: ApiService.fetchMealDetails(mealId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final meal = snapshot.data as Map<String, dynamic>;

            // Ambil video URL (YouTube)
            final videoUrl = meal['strYoutube'];

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar makanan
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      meal['strMealThumb'],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Nama makanan
                  Text(
                    meal['strMeal'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                    ),
                  ),
                  SizedBox(height: 10),

                  // Kategori dan area makanan
                  Text(
                    'Category: ${meal['strCategory']}',
                    style: TextStyle(fontSize: 16, color: Colors.brown[700]),
                  ),
                  Text(
                    'Area: ${meal['strArea']}',
                    style: TextStyle(fontSize: 16, color: Colors.brown[700]),
                  ),
                  SizedBox(height: 20),

                  // Bahan-bahan makanan
                  Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                    ),
                  ),
                  SizedBox(height: 10),
                  ..._buildIngredientsList(meal),

                  SizedBox(height: 20),

                  // Instruksi masak
                  Text(
                    'Instructions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    meal['strInstructions'],
                    style: TextStyle(fontSize: 16, color: Colors.brown[700]),
                  ),
                  SizedBox(height: 30),

                  // Tombol untuk video tutorial
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _launchURL(videoUrl),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        child: Text(
                          'Lihat Tutorial',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Fungsi untuk menampilkan daftar bahan makanan
  List<Widget> _buildIngredientsList(Map<String, dynamic> meal) {
    List<Widget> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = meal['strIngredient$i'];
      final measure = meal['strMeasure$i'];

      if (ingredient != null &&
          ingredient.isNotEmpty &&
          measure != null &&
          measure.isNotEmpty) {
        ingredients.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              '$ingredient - $measure',
              style: TextStyle(fontSize: 16, color: Colors.brown[700]),
            ),
          ),
        );
      }
    }
    return ingredients;
  }
}
