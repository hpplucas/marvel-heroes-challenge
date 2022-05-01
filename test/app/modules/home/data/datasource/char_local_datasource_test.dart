import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_heroes/app/modules/home/data/datasource/char_local_datasource.dart';
import 'package:marvel_heroes/app/modules/home/domain/entities/char.dart';

void main() {
  test('Should return a List<CharModel> after loads local assets', () async {
    //need to load a asset
    TestWidgetsFlutterBinding.ensureInitialized();
    final sut = CharLocalDatasource();

    final result = await sut.getByCategory(CharCategory.humans);

    expect(result, isA<List<Char>>());
  });
}
