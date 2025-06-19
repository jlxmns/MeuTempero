import 'package:flutter/material.dart';
import '../../data/csv_reader.dart';
import 'categorypage.dart';
import 'package:meu_tempero/views/utils/AppColor.dart';



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
        
        
        color: AppColor.primary.withAlpha(80),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          
          
          
          
        ),
        elevation: 8.0,
        shadowColor: Colors.black.withAlpha(50),
        
        child: Stack(
          fit: StackFit.expand, 
          children: [
            
            Image.asset(
              imagePath,
              
              
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
            
            
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withAlpha(70), 
                    Colors.black.withAlpha(50),
                    Colors.transparent,           
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 0.4, 1.0], 
                ),
              ),
            ),
            
            
            Positioned(
              bottom: 12.0,
              left: 12.0,
              right: 12.0,
              child: Text(
                categoryName,
                textAlign: TextAlign.center, 
                maxLines: 2,
                overflow: TextOverflow.ellipsis, 
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20, 
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

  
  String _getImageAssetPath(String categoryText) {
    switch (categoryText) {
      case 'Bolos':
        return 'assets/images/cake.png';
      case 'Biscoitos':
        return 'assets/images/cookies.png';
      case 'Tortas':
        return 'assets/images/pie.png';
      case 'Saladas e Molhos':
        return 'assets/images/salad.png';
      case 'Sopas':
        return 'assets/images/soup.png';
      case 'Pratos Principais':
        return 'assets/images/dishes.png';
      default:
        
        return 'assets/images/default_background.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: categorias.length,
                itemBuilder: (context, index) {
                  final categoria = categorias[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom:16),
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                              CategoryRecipesPage(category: categoria),
                          ),
                        );
                      },

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          _getImageAssetPath(categoria),
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.contain,

                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 180,
                              color: Colors.grey[200],
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined, 
                                  color: Colors.grey[400],
                                  size: 50,
                                ),
                              ),
                            );
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                          child: Text(
                            categoria,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey[850],
                            ),
                          ),
                        ),
                      ],
                    )

                    )
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
