import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_heroes/app/core/errors/exceptions.dart';
import 'package:marvel_heroes/app/core/errors/failures.dart';
import 'package:marvel_heroes/app/modules/home/data/datasource/char_datasource.dart';
import 'package:marvel_heroes/app/modules/home/data/repositories/char_repository.dart';
import 'package:marvel_heroes/app/modules/home/domain/entities/char.dart';
import 'package:mocktail/mocktail.dart';

class CharDatasourceMock extends Mock implements ICharDatasource {}

void main() {
  test('Should call getByCategory datasource method and return a list of Char entity',
      () async {
    final datasource = CharDatasourceMock();
    const category = CharCategory.aliens;
    final sut = CharRepositoryImp(datasource);
    when(() => datasource.getByCategory(category)).thenAnswer((_) async => []);

    final result = await sut.getByCategory(category);

    expect(result, isA<List<Char>>());
    verify(() => datasource.getByCategory(category)).called(1);
  });
}
