import '../entities/entities.dart';
import '../repositories/char_repository.dart';

abstract class IGetCharsByCategory {
  Future<List<Char>> call(CharCategory category);
}

class GetCharsByCategory implements IGetCharsByCategory {
  final ICharRepository repository;

  GetCharsByCategory(this.repository);

  @override
  Future<List<Char>> call(CharCategory category) async {
    return await repository.getByCategory(category);
  }

}