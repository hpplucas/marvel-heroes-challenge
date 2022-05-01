

import '../../domain/entities/char.dart';
import '../models/char_model.dart';

abstract class ICharDatasource {
  Future<List<CharModel>> getByCategory(CharCategory category);
}