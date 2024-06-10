import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import './models/form_field_model.dart';
import './providers/form_provider.dart';
import './widgets/dynamic_form.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Form by Brian Lopez 🚀',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Dynamic Form by Brian Lopez 🚀')),
        body: const FormLoader(),
      ),
    );
  }
}

class FormLoader extends ConsumerStatefulWidget {
  const FormLoader({super.key});

  @override
  _FormLoaderState createState() => _FormLoaderState();
}

class _FormLoaderState extends ConsumerState<FormLoader> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadForm();
  }

  Future<void> _loadForm() async {
    final jsonString = await rootBundle.loadString('assets/form.json');
    final formFields = (json.decode(jsonString) as List)
        .map((data) => FormFieldModel.fromJson(data))
        .toList();

    ref.read(formFieldsProvider.notifier).state = formFields;
    ref.read(visibleFieldsProvider.notifier).state = formFields
        .where((field) => field.visible == null)
        .map((field) => field.fieldName)
        .toList();

    setState(() {
      _isLoading = false;
    });
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
              "This form consumes a json hosted in the assets folder of this project, if you want to modify by adding or removing elements see that file directly"),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _showAlert(context);
            },
            child: const Text("Info about this app"),
          ),
          Expanded(child: DynamicForm()),
        ],
      );
    }
  }
}
