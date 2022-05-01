import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../../../../core/errors/exceptions.dart';

import '../../domain/entities/char.dart';
import '../models/char_model.dart';
import 'char_datasource.dart';

class CharLocalDatasource implements ICharDatasource {
  
  final String _filePath = 'assets/heroes.json';

  Future<String> _loadJsonAsset() async {
    try {
      return await rootBundle.loadString(_filePath);
    } catch (e) {
      throw LocalDatasourceExeption();
    }
  }

  @override
  Future<List<CharModel>> getByCategory(CharCategory category) async {
    final Map<String, dynamic> jsonData = jsonDecode(await _loadJsonAsset());

    if (!jsonData.containsKey(describeEnum(category))) throw LocalDatasourceExeption();

    final categoryChars = jsonData[describeEnum(category)];
    final chars = (categoryChars as List).map((e) => CharModel.fromJson(e)).toList();

    return chars;
  }
}