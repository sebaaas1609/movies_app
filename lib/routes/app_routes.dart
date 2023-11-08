import 'package:flutter/material.dart';
import 'package:peliculas_curso/screens/screens.dart';

class AppRoutes{
 static const initialRoute = 'home';

  /*static final menuOption = <MenuOption>[

  ];*/

  static Map<String, Widget Function(BuildContext)> getAppRoutes(){
    Map<String, Widget Function(BuildContext)> appRoutes ={};
    //Permite que exista el home al quitarlo de las rutas principales
    appRoutes.addAll({'home': (BuildContext context)=> const HomeScreen()});
    appRoutes.addAll({'details': (BuildContext context)=> const DetailsScreen()});
    /*for (final option in menuOption) {
      appRoutes.addAll({option.route : (BuildContext context) => option.screen});
    }*/

    return  appRoutes;
  }



  //Genera ruta por defecto
  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    return MaterialPageRoute(
          builder: (context) => const AlertScreen(),
          );
  }

}
