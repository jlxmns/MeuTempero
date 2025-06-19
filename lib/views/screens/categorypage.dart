import 'package:flutter/material.dart';
import '../../data/csv_reader.dart';
import 'recipeDetailPage.dart';
import '../utils/AppColor.dart';

class CategoryRecipesPage extends StatelessWidget {
  final String category;

  const CategoryRecipesPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Receitas: $category',
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2),
        ),
        backgroundColor: AppColor.primary,
        elevation: 0, 
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: carregarCsv(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: AppColor.primary,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar receitas: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma receita encontrada.'));
          } else {
            final receitas = snapshot.data!
                .where((mapa) => mapa['Category'].toString() == category)
                .toList();

            if (receitas.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhuma receita encontrada para esta categoria.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }
            
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: receitas.length,
              itemBuilder: (context, index) {
                final receita = receitas[index];
                
                
                final imageUrl = 'assets/images/${receita['Image_Name']}.jpg';

                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(bottom: 16), 
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailPage(receita: receita),
                        ),
                      );
                    },
                    
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Image.asset(
                          imageUrl,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          
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
                            receita['Title'] ?? 'Sem título',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey[850],
                            ),
                            
                            
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
