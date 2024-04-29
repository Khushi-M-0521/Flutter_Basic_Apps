import 'package:flutter/material.dart';
import 'package:healthy_food/modals/meal.dart';
import 'package:healthy_food/screens/meal_details.dart';
import 'package:healthy_food/widgets/meal_item.dart';

class MealsScrenn extends StatelessWidget {
  const MealsScrenn({super.key, required this.meals, this.title,required this.onToggeleFavorite});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal) onToggeleFavorite;

  void _selectMeal(BuildContext context,Meal meal){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MealDetailsScreen(meal: meal, onToggeleFavorite: onToggeleFavorite,)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => Text(meals[index].title));
    
    if(meals.isNotEmpty){
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(meal: meals[index], onSelectMeal: (meal){_selectMeal(context, meal);},));
    
    }
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Uh...oh.... nothing here",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Try selecting a different category!",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }

    if(title==null){
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
