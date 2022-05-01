import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_heroes/app/modules/home/domain/entities/char.dart';
import 'package:marvel_heroes/app/modules/home/domain/repositories/char_repository.dart';
import 'package:marvel_heroes/app/modules/home/domain/usecases/get_chars_by_category.dart';
import 'package:mocktail/mocktail.dart';

class CharRepositoryMock extends Mock implements ICharRepository {}

void main() {
  test('should call the CharRepository class and return a List<Char>',
      () async {
    final repository = CharRepositoryMock();
    final sut = GetCharsByCategory(repository);
    const category = CharCategory.antiHeroes;
    when((() => repository.getByCategory(category))).thenAnswer((_) async => []);

    final result = await sut.call(category);

    expect(result, isA<List<Char>>());
    verify(() => repository.getByCategory(category)).called(1);
  });
}
