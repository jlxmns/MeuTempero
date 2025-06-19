import 'package:flutter/material.dart';
import '../utils/AppColor.dart';

class RecipeDetailPage extends StatefulWidget {
  final Map<String, dynamic> receita;

  const RecipeDetailPage({super.key, required this.receita});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late List<bool> checkedIngredients;

  @override
  void initState() {
    super.initState();
    checkedIngredients = _buildIngredientList().map((_) => false).toList();
  }

  List<String> _buildIngredientList() {
    final List<String> ingredientes = [];
    for (int i = 1; i <= 19; i++) {
      final quantity =
          widget.receita['Quantity${i.toString().padLeft(2, '0')}'];
      final unit = widget.receita['Unit${i.toString().padLeft(2, '0')}'];
      final ingredient =
          widget.receita['Ingredient${i.toString().padLeft(2, '0')}'];
      if ((quantity != null && quantity.toString().trim().isNotEmpty) ||
          (unit != null && unit.toString().trim().isNotEmpty) ||
          (ingredient != null && ingredient.toString().trim().isNotEmpty)) {
        ingredientes.add(
          "${quantity ?? ""} ${unit ?? ""} ${ingredient ?? ""}".trim(),
        );
      }
    }
    return ingredientes;
  }

  @override
  Widget build(BuildContext context) {
    final ingredientes = _buildIngredientList();
    final modoPreparo = widget.receita['Directions'] ?? 'Sem instruções.';
    final tituloReceita = widget.receita['Title'] ?? 'Sem título';
    final categoria = widget.receita['Category'];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.primaryExtraSoft,
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.chevron_left)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 10,
            ),
            // Nome da receita centralizado
            Center(
              child: Text(
                tituloReceita,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (categoria != null) ...[
              const SizedBox(height: 8),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    categoria,
                    style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 32),

            // Ingredientes box
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.primary.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(18),
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Ingredientes",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ingredientes.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: ingredientes.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 6),
                          itemBuilder: (context, i) => CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              ingredientes[i],
                              style: const TextStyle(fontSize: 16),
                            ),
                            value: checkedIngredients[i],
                            activeColor: AppColor.primary,
                            checkColor: AppColor.secondary,
                            onChanged: (val) {
                              setState(() {
                                checkedIngredients[i] = val ?? false;
                              });
                            },
                          ),
                        )
                      : const Text(
                          "Nenhum ingrediente informado.",
                          textAlign: TextAlign.center,
                        ),
                ],
              ),
            ),

            // Modo de preparo box
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.primary.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(18),
              margin: const EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Modo de preparo",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    modoPreparo,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
