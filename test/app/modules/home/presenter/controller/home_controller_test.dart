import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_heroes/app/core/errors/failures.dart';
import 'package:marvel_heroes/app/modules/home/domain/entities/char.dart';
import 'package:marvel_heroes/app/modules/home/domain/usecases/get_chars_by_category.dart';
import 'package:marvel_heroes/app/modules/home/presenter/controller/home_controller.dart';
import 'package:mocktail/mocktail.dart';

class GetByCategoryMock extends Mock implements IGetCharsByCategory {}

void main() {
  late GetByCategoryMock usecase;
  late HomeController sut;

  setUp(() {
    usecase = GetByCategoryMock();
    sut = HomeController(usecase);

    for (CharCategory c in CharCategory.values) {
      registerFallbackValue(c);
    }
  });
  test('Should emits a Map<CharCategory, List<Char>> on get the all categories', () async {
    when(() => usecase.call(any())).thenAnswer((_) async => []);

    sut.loadAllCharsCategories();
    
    expectLater(sut.charsByCategoryBS, emits(isA<Map<CharCategory, List<Char>>>()));
    expectLater(sut.isLoading, emitsInOrder([true, false]));
  });
  test('Should emits a error message string when get all categories method fails', () async {
    when(() => usecase.call(any())).thenThrow(LocalDatasourceFailure());

    sut.loadAllCharsCategories();

    expectLater(sut.errorMessageBS, emits(isA<String>()));
  });
}