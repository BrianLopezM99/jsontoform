import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/form_field_model.dart';

final formFieldsProvider = StateProvider<List<FormFieldModel>>((ref) => []);
final formValuesProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final visibleFieldsProvider = StateProvider<List<String>>((ref) => []);
