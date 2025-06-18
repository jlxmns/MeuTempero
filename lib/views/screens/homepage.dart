import 'package:flutter/material.dart';
import '../../data/csv_reader.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias únicas'),
        backgroundColor: Colors.teal,
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
            return ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categorias[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
