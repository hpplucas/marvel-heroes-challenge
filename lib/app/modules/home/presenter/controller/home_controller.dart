
import 'package:rxdart/rxdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/char.dart';
import '../../domain/usecases/get_chars_by_category.dart';

class HomeController {
  final IGetCharsByCategory usecase;

  final charsByCategoryBS = BehaviorSubject<Map<CharCategory, List<Char>>>();
  final isLoading = BehaviorSubject<bool>();
  final errorMessageBS = BehaviorSubject<String>();

  HomeController(this.usecase);

  Future<void> loadAllCharsCategories() async {
    isLoading.sink.add(true);

    try {
      final Map<CharCategory, List<Char>> charsByCategory = {};
      for (CharCategory category in CharCategory.values) {
        final chars = await usecase(category);

        charsByCategory[category] = chars;
      }

      charsByCategoryBS.sink.add(charsByCategory);
    } on Failure {
      errorMessageBS.sink.add( 'Houve um erro inesperado ao carregar os dados.');
    }

    isLoading.add(false);
  }

  void dispose() {
    charsByCategoryBS.close();
    isLoading.close();
  }
}