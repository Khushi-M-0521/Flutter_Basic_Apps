import 'package:flutter/material.dart';
import 'package:healthy_food/data/dummy_data.dart';
import 'package:healthy_food/modals/meal.dart';
import 'package:healthy_food/screens/categories.dart';
import 'package:healthy_food/screens/filters.dart';
import 'package:healthy_food/screens/meals.dart';
import 'package:healthy_food/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutanfree: false,
  Filter.lactosefree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectFilters = {
    Filter.glutanfree: false,
    Filter.lactosefree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage("Meal is no longer favroute");
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage("Marked as favroite");
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectFilters,),
        ),
      );
      setState(() {
        _selectFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final avaliableMeals = dummyMeals.where((meal) {
      if (_selectFilters[Filter.glutanfree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectFilters[Filter.lactosefree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggeleFavorite: _toggleMealFavouriteStatus,
      availableMeals: avaliableMeals,
    );
    var activePageTitle = "Categories";
    if (_selectedPageIndex == 1) {
      activePage = MealsScrenn(
        meals: _favoriteMeals,
        onToggeleFavorite: _toggleMealFavouriteStatus,
      );
      activePageTitle = "Your Favrourites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourite"),
        ],
      ),
    );
  }
}
