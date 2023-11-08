
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_curso/helpers/debouncer.dart';
import 'package:peliculas_curso/models/models.dart';
import 'package:peliculas_curso/models/search_movies_response.dart';

class MoviesProvider extends ChangeNotifier{

  final String _baseUrl ='api.themoviedb.org';
  final String _apiKey= '17e002b40f0c64a9de99597b2946f85c';
  final String _language='es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;
  Map<int,List<Cast>> movieCast = {};

  final StreamController<List<Movie>> _suggestionsStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionsStream => _suggestionsStreamController.stream;

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500)
  );


  MoviesProvider(){
    print('MoviesProvider inicializado');

    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async{
     final url = Uri.https(_baseUrl, endpoint,  {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    }
    );

    final response = await http.get(url);
    return response.body;


  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();//Notifica a los widgets de algun cambio en la data
  }

  getPopularMovies() async{

    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);

    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies,...popularResponse.results];// Concatena todos los resultados
    notifyListeners();//Notifica a los widgets de algun cambio en la data
  }

  Future<List<Cast>> getMovieCast(int movieId) async{
    
    if(movieCast.containsKey(movieId)) return movieCast[movieId]!;//Evita que se vuelva a hacer la peticion http

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    movieCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;

  }

  Future <List<Movie>> searchMovies(String query) async{

    final url = Uri.https(_baseUrl, '3/search/movie',  {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    final response = await http.get(url);
    final searchResponse = SearchMovieResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm){
    debouncer.value = '';
    debouncer.onValue= (value )async{
      final results = await searchMovies(value);
      _suggestionsStreamController.add(results);
    };
    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
     });

     Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());

  }

   

}