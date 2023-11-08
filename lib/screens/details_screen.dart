import 'package:flutter/material.dart';
import 'package:peliculas_curso/models/models.dart';
import 'package:peliculas_curso/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
   
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie,),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie: movie,),
              _Overview(movie: movie,),

              CastingCards(movieId: movie.id,),
            ])
            ),
            
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomAppBar({
    Key? key,
     required this.movie
     }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child:  Text(
            movie.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, ),
            ),
        ),
        background: FadeInImage(
        placeholder: AssetImage('assets/loading.gif'),
         image: NetworkImage(movie.fullBackdropPath),
         fit: BoxFit.cover,
         ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle({
    Key? key,
   required this.movie
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final TextTheme theme = Theme.of(context).textTheme;
     final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId! ,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
          
                ),
            ),
          ),
          const SizedBox(width: 10,),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width-190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                Text(movie.title, style: theme.headline6,maxLines: 2,overflow: TextOverflow.ellipsis,),
                
          
                Text(movie.originalTitle,style: theme.subtitle1,maxLines: 2,overflow: TextOverflow.ellipsis,),
          
                Row(
                  children: [
                    const Icon(Icons.star_outline, size: 15, color: Colors.grey,),
                    const SizedBox(width: 5,),
                    Text('${movie.voteAverage}', style: theme.caption,),
                  ],
                )
          
              ],
            ),
          )

        ],
        ),
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview({
    Key? key,
   required this.movie
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
         ),
      );
  }
}