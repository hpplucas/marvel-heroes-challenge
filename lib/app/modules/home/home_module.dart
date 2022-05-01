
import 'package:provider/provider.dart';

import 'data/datasource/char_datasource.dart';
import 'data/datasource/char_local_datasource.dart';
import 'data/repositories/char_repository.dart';
import 'domain/repositories/char_repository.dart';
import 'domain/usecases/get_chars_by_category.dart';
import 'presenter/controller/home_controller.dart';

final homeModule = [
  Provider<ICharDatasource>(create: (context) => CharLocalDatasource()),
  Provider<ICharRepository>(create: (context) => CharRepositoryImp(context.read())),
  Provider<IGetCharsByCategory>(create: (context) => GetCharsByCategory(context.read())),
  Provider<HomeController>(create: (context) => HomeController(context.read()))
];