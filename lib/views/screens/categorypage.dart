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
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.chevron_left)),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Receitas: $category',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primary,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: carregarCsv(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            final receitas = snapshot.data!
                .where((mapa) => mapa['Category'].toString() == category)
                .toList();

            if (receitas.isEmpty) {
              return const Center(
                child: Text('Nenhuma receita nesta categoria.'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: receitas.length,
              itemBuilder: (context, index) {
                final receita = receitas[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(receita['Title'] ?? 'Sem título'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailPage(receita: receita),
                        ),
                      );
                    },
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
