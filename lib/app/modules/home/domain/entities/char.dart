import 'ability.dart';
import 'caracteristc.dart';
import 'movie.dart';

class Char {
  final String name;
  final String alterEgo;
  final String imagePath;
  final String biography;
  final Caracteristc caracteristics;
  final List<Movie> movies;
  final Ability abilities;

  Char({
    required this.name,
    required this.alterEgo,
    required this.imagePath,
    required this.biography,
    required this.caracteristics,
    required this.movies,
    required this.abilities,
  });
}

enum CharCategory {
  heroes,
  villains,
  antiHeroes,
  aliens,
  humans
}
