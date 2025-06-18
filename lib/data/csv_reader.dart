import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

Future<List<Map<String, dynamic>>> carregarCsv() async {
  final rawData = await rootBundle.loadString("recipes/recipes.csv");
  final csvList = const CsvToListConverter(eol: '\r').convert(rawData);
 
  if (csvList.isEmpty) return [];

  final header = csvList.first.map((e) => e.toString()).toList();
  final rows = csvList.skip(1);

  final listMap = rows.map((linha) {
    return {
      for (int i = 0; i < header.length; i++) header[i]: linha[i],
    };
  }).toList();

  return listMap;
}

Future<List<String>> extrairUnicos(String chave) async {
  final listaMap = await carregarCsv();
  return listaMap
      .map((mapa) => mapa[chave]?.toString().trim() ?? '')
      .where((v) => v.isNotEmpty)
      .toSet()
      .toList();
}
