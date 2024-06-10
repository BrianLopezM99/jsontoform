import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../models/form_field_model.dart';

Future<List<FormFieldModel>> loadFormFields() async {
  final jsonString = await rootBundle.loadString('assets/form.json');
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((data) => FormFieldModel.fromJson(data)).toList();
}
