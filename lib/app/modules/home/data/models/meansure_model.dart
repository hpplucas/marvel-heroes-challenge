import '../../domain/entities/entities.dart';

class MeansureModel extends Mensure {
  MeansureModel({required double value, required String unity}) : super(value: value, unity: unity);
  
  factory MeansureModel.fromJson(Map<String, dynamic> json) {
    return MeansureModel(
      value: json['value']?.toDouble(), 
      unity: json['unity']
    );
  }
}