import 'package:flutter/material.dart';
import 'package:healthy_food/data/dummy_data.dart';
import 'package:healthy_food/modals/category.dart';
import 'package:healthy_food/modals/meal.dart';
import 'package:healthy_food/screens/meals.dart';
import 'package:healthy_food/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggeleFavorite,required this.availableMeals});
  final void Function(Meal) onToggeleFavorite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMealList= availableMeals.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScrenn(
            meals: filteredMealList, title: category.title, onToggeleFavorite: onToggeleFavorite,),),); //Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: [
            for (final category in availableCategories)
              CategoryGridItem(category: category, onSelectCategory: (){_selectCategory(context,category);},)
          ],
        );
  }
}
