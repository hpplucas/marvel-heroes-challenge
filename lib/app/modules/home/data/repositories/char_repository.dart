
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/char.dart';
import '../../domain/repositories/char_repository.dart';
import '../datasource/char_datasource.dart';

class CharRepositoryImp implements ICharRepository {
  final ICharDatasource datasource;

  CharRepositoryImp(this.datasource);

  @override
  Future<List<Char>> getByCategory(CharCategory category) async {
    try {
      return await datasource.getByCategory(category);
    } on LocalDatasourceExeption {
      throw LocalDatasourceFailure();
    }
  }

}