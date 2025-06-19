import 'package:flutter/material.dart';
import '../../data/csv_reader.dart';
import 'categorypage.dart';
import 'package:meu_tempero/views/utils/AppColor.dart';

// (Place this new widget class above your HomePage class)

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.categoryName,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        // SOLUTION 1B: Change the card's background color
        // This color will show through the transparent parts of your PNGs.
        color: AppColor.primary.withAlpha(80),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          // side: BorderSide(
          //   color: AppColor.secondary,
          //   width: 1.0,
          // )
        ),
        elevation: 8.0,
        shadowColor: Colors.black.withAlpha(50),
        // We use a Stack to layer the image, gradient, and text
        child: Stack(
          fit: StackFit.expand, // Makes all children in the stack fill the card
          children: [
            // Layer 1: The Image
            Image.asset(
              imagePath,
              // Using `fit: BoxFit.contain` works better for transparent PNGs
              // It ensures the whole item is visible without being cut off.
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
            
            // Layer 2: The Gradient Scrim for text readability
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withAlpha(70), // Darker at the bottom
                    Colors.black.withAlpha(50),
                    Colors.transparent,           // Fades to transparent
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 0.4, 1.0], // Controls how quickly the gradient fades
                ),
              ),
            ),
            
            // Layer 3: The Text, positioned at the bottom
            Positioned(
              bottom: 12.0,
              left: 12.0,
              right: 12.0,
              child: Text(
                categoryName,
                textAlign: TextAlign.center, // Center the text horizontally
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // Handle long category names
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20, // Slightly smaller to fit better at the bottom
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Helper function to get the correct image for each category
  String _getImageAssetPath(String categoryText) {
    switch (categoryText) {
      case 'Cakes':
        return 'assets/images/cake.png';
      case 'Cookies':
        return 'assets/images/cookie.png';
      case 'Pies':
        return 'assets/images/pie.png';
      case 'Salads and Dressings':
        return 'assets/images/salad.png';
      case 'Soup':
        return 'assets/images/soup.png';
      default:
        // Return a default image in case one is missing
        return 'assets/images/default_background.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Optional: Make the AppBar transparent for a more modern look
      backgroundColor: Colors.teal, // A dark background color
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.chevron_left)),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Categorias',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primary,
      ),
      body: FutureBuilder<List<String>>(
        future: extrairUnicos('Category'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            final categorias = snapshot.data!;
            // MODIFICATION: Using GridView.builder for the new card layout
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: categorias.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,    // Two cards per row
                  crossAxisSpacing: 16, // Horizontal space between cards
                  mainAxisSpacing: 16,  // Vertical space between cards
                  childAspectRatio: 0.8,// Adjust aspect ratio (width/height) as needed
                ),
                itemBuilder: (context, index) {
                  final categoria = categorias[index];
                  return CategoryCard(
                    categoryName: categoria,
                    imagePath: _getImageAssetPath(categoria),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CategoryRecipesPage(category: categoria),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
