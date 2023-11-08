import 'package:flutter/material.dart';
import 'package:peliculas_curso/providers/providers.dart';
import 'package:peliculas_curso/search/search_delegate.dart';
import 'package:peliculas_curso/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true); // movies provider va al arbol de widgets y trae la primera instancia de un provider de tipo MovieProvider

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        elevation: 0,
        actions: [
          IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          
          CardSwiper(movies: moviesProvider.onDisplayMovies,),

          MovieSlider(
            movies: moviesProvider.popularMovies,
             sectionTitle: 'Populares!', 
             onNextPage: ()=> moviesProvider.getPopularMovies(),
             ),

        ],
        ),
        )
    );
  }
}