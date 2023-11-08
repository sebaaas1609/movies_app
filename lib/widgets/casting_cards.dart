import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_curso/models/models.dart';
import 'package:peliculas_curso/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {

  final int movieId;
  const CastingCards({
    Key? key, 
  required this.movieId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {

        if (!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (_, int index) => _CastCard(actor: cast[index],),
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
    
  }
}


class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard({
    Key? key, 
    required this.actor
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: 140,
              width: 100,
              fit: BoxFit.cover,
              image: NetworkImage(actor.fullProfilePath),
              placeholder: const AssetImage('assets/no-image.jpg'),
            ),
          ),
          const SizedBox(height: 5,),
          Text(actor.name, maxLines: 2,
           overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,),
          

      ],),
    );
  }
}