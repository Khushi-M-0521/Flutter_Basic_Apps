import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_food/provider/meals_provider.dart';

enum Filter{
  glutanfree,
  lactosefree,
  vegan,
  vegetarian
}

class FiltersNotifier extends StateNotifier<Map<Filter,bool>>{
  FiltersNotifier():super({
    Filter.glutanfree:false,
    Filter.lactosefree: false,
    Filter.vegan: false,
    Filter.vegetarian:false
  });

  void setFilter(Filter filter, bool isActive){
    state={
      ...state,
      filter:isActive,
    };
  }

  void setFilters(Map<Filter,bool> chosenFilters){
    state = chosenFilters;
  }

}

final filtersProvider = StateNotifierProvider<FiltersNotifier,Map<Filter,bool>>((ref) => FiltersNotifier());

final filteredMealsProvider=Provider((ref) {
  final meals= ref.watch(mealsProvider);
  final activeFilters= ref.watch(filtersProvider);
  return meals.where((meal) {
      if (activeFilters[Filter.glutanfree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactosefree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
});