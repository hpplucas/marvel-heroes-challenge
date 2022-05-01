import '../entities/char.dart';

abstract class ICharRepository {
  Future<List<Char>> getByCategory(CharCategory category);
}