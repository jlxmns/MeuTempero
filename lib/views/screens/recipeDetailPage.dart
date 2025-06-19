import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/AppColor.dart';

class RecipeDetailPage extends StatefulWidget {
  final Map<String, dynamic> receita;

  const RecipeDetailPage({super.key, required this.receita});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late List<bool> checkedIngredients;
  late List<String> ingredients;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    ingredients = _buildIngredientList();
    _loadCheckedIngredients();
  }

  Future<void> _loadCheckedIngredients() async {
    final prefs = await SharedPreferences.getInstance();
    final recipeTitle = widget.receita['Title'] ?? 'sem_titulo';
    final key = 'checked_ingredients_$recipeTitle';

    final savedData = prefs.getStringList(key);

    if (savedData != null) {
      checkedIngredients = savedData.map((item) => item == 'true').toList();
    } else {
      checkedIngredients = List<bool>.filled(ingredients.length, false);
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveCheckedIngredients() async {
    final prefs = await SharedPreferences.getInstance();
    final recipeTitle = widget.receita['Title'] ?? 'sem_titulo';
    final key = 'checked_ingredients_$recipeTitle';

    final dataToSave =
        checkedIngredients.map((item) => item.toString()).toList();
    await prefs.setStringList(key, dataToSave);
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

  List<String> _buildDirectionsList(String directions) {
    return directions
        .split('\n')
        .where((step) => step.trim().isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final directionsList =
        _buildDirectionsList(widget.receita['Directions'] ?? '');
    final title = widget.receita['Title'] ?? 'Sem título';
    final category = widget.receita['Category'];
    final imageUrl = 'assets/images/${widget.receita['Image_Name']}.jpg';

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColor.primary,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(
                        Icons.restaurant_menu,
                        color: Colors.grey[500],
                        size: 80,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.grey[850],
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (category != null)
                    Chip(
                      label: Text(category),
                      backgroundColor: AppColor.secondary,
                      labelStyle: TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const SizedBox(height: 24),
                  _buildSectionTitle("Ingredientes"),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColor.primaryExtraSoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                                color: AppColor.primary))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: ingredients.length,
                            itemBuilder: (context, index) {
                              return _buildIngredientItem(index);
                            },
                          ),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle("Modo de Preparo"),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: directionsList.length,
                    itemBuilder: (context, index) {
                      return _buildDirectionStep(index, directionsList[index]);
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColor.primary,
      ),
    );
  }

  Widget _buildIngredientItem(int index) {
    bool isChecked = checkedIngredients[index];
    return InkWell(
      onTap: () {
        setState(() {
          checkedIngredients[index] = !isChecked;
          _saveCheckedIngredients();
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  checkedIngredients[index] = value ?? false;
                  _saveCheckedIngredients();
                });
              },
              activeColor: AppColor.primary,
              checkColor: Colors.white,
              visualDensity: VisualDensity.compact,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                ingredients[index],
                style: TextStyle(
                  fontSize: 16,
                  color: isChecked ? Colors.grey[500] : Colors.grey[800],
                  decoration: isChecked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectionStep(int index, String step) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: AppColor.primary,
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              step,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}