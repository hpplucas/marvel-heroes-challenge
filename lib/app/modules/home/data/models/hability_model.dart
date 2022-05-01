import '../../domain/entities/entities.dart';

class AbilityModel extends Ability {
  AbilityModel({required int force, required int intelligence, required int agility, required int endurance, required int velocity}) : super(force: force, intelligence: intelligence, agility: agility, endurance: endurance, velocity: velocity);

  factory AbilityModel.fromJson(Map<String, dynamic> json) {
    return AbilityModel(
      force: json['force'], 
      intelligence: json['intelligence'], 
      agility: json['agility'], 
      endurance: json['endurance'], 
      velocity: json['velocity']
    );
  }
}