import '../../domain/entities/entities.dart';

class MovieModel extends Movie {
  MovieModel({required String banner}) : super(banner: banner);


  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(banner: json['banner']);
  }
}