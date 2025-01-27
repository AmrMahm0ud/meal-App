import 'package:flutter/material.dart';
import 'package:section7_final/dummy_data.dart';
import 'package:section7_final/screens/filters_screen.dart';
import 'package:section7_final/screens/meal_detail_screen.dart';
import 'package:section7_final/screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import 'models/meal.dart';
import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String , bool> _filters = {

    'gluten' : false ,
    'lactose' : false ,
    'vegan' : false ,
    'vegetarian' : false,
  };
  List <Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(Map<String , bool> filterData){
  setState(() {
    _filters = filterData;
     _availableMeals = DUMMY_MEALS.where((meal) {
       if(_filters['gluten'] && !meal.isGlutenFree){
         return false;
       }
       if(_filters['lactose'] && !meal.isLactoseFree){
         return false;
       }
       if(_filters['vegan'] && !meal.isVegan){
         return false;
       }
       if(_filters['vegetarian'] && !meal.isVegetarian){
         return false;
       }
       return true;
     }).toList();
  });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ))),
    //  home: TabsScreen(),
      routes: {
        '/' : (ctx) => TabsScreen(),
        '/categories-meals' : (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName :(ctx) => MealDetailScreen(),
        FliterScreen.routeName : (ctx) => FliterScreen(_filters , _setFilters),
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      //onUnknownRoute: ,
    );
  }
}
