import '../../domain/entities/entities.dart';
import 'caracteristc_model.dart';
import 'hability_model.dart';
import 'movie_model.dart';

class CharModel extends Char {
  CharModel({required String name, required String alterEgo, required String imagePath, required String biography, required Caracteristc caracteristics, required List<Movie> movies, required Ability abilities}) : super(name: name, alterEgo: alterEgo, imagePath: imagePath, biography: biography, caracteristics: caracteristics, movies: movies, abilities: abilities);


  factory CharModel.fromJson(Map<String, dynamic> json) {
    return CharModel(
      name: json['name'], 
      alterEgo: json['alterEgo'], 
      imagePath: json['imagePath'], 
      biography: json['biography'], 
      abilities: AbilityModel.fromJson(json['abilities']),
      caracteristics: CaracteristicModel.fromJson(json['caracteristics']), 
      movies: json['movies'] != null ? (json['movies'] as List).map((e) => MovieModel(banner: e)).toList() : [],
    );
  } 
}