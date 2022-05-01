import '../../domain/entities/entities.dart';
import 'meansure_model.dart';

class CaracteristicModel extends Caracteristc {
  CaracteristicModel({required String birth, required String universe, required Mensure weight, required Mensure height}) : super(birth: birth, universe: universe, weight: weight, height: height);

  factory CaracteristicModel.fromJson(Map<String, dynamic> json) {
    return CaracteristicModel(
      birth: json['birth'], 
      universe: json['universe'],
      weight: MeansureModel.fromJson(json['weight']), 
      height: MeansureModel.fromJson(json['height'])
    );
  }
}