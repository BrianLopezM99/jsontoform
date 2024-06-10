import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/form_field_model.dart';
import '../providers/form_provider.dart';

class DynamicForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formFields = ref.watch(formFieldsProvider);
    final formValues = ref.watch(formValuesProvider);
    final visibleFields = ref.watch(visibleFieldsProvider);

    return ListView(
      children: formFields.map((field) {
        if (field.visible == null || visibleFields.contains(field.fieldName)) {
          return buildFormField(context, field, formValues, ref);
        } else {
          return Container();
        }
      }).toList(),
    );
  }

  Widget buildFormField(BuildContext context, FormFieldModel field,
      Map<String, dynamic> formValues, WidgetRef ref) {
    switch (field.widget) {
      case 'dropdown':
        return DropdownButtonFormField<String>(
          value: formValues[field.fieldName],
          items: field.validValues!.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            ref.read(formValuesProvider.notifier).update((state) {
              state[field.fieldName] = newValue;
              return state;
            });
            updateVisibility(ref);
          },
          decoration: InputDecoration(labelText: field.fieldName),
        );
      case 'textfield':
        return TextFormField(
          initialValue: formValues[field.fieldName],
          onChanged: (newValue) {
            ref.read(formValuesProvider.notifier).update((state) {
              state[field.fieldName] = newValue;
              return state;
            });
            updateVisibility(ref);
          },
          decoration: InputDecoration(labelText: field.fieldName),
        );
      case 'button':
        return ElevatedButton(
          onPressed: () {},
          child: Text(field.text ?? 'Button'),
        );
      case 'static_text':
        return Text(field.text ?? '');
      case 'checkbox':
        return CheckboxListTile(
          title: Text(field.text ?? ''),
          value: formValues[field.fieldName] ?? false,
          onChanged: (newValue) {
            ref.read(formValuesProvider.notifier).update((state) {
              state[field.fieldName] = newValue;
              return state;
            });
            updateVisibility(ref);
          },
        );
      case 'radio':
        return RadioListTile<String>(
          title: Text(field.text ?? ''),
          value: field.text ?? '',
          groupValue: formValues[field.group ?? ''] ?? '',
          onChanged: (newValue) {
            ref.read(formValuesProvider.notifier).update((state) {
              state[field.group ?? ''] = newValue;
              return state;
            });
            updateVisibility(ref);
          },
        );
      default:
        _showErrorDialog(context);
        return Container();
    }
  }

  void updateVisibility(WidgetRef ref) {
    final formFields = ref.read(formFieldsProvider);
    final formValues = ref.read(formValuesProvider);
    final visibleFields = <String>[];

    for (final field in formFields) {
      if (field.visible == null) {
        visibleFields.add(field.fieldName);
      } else {
        final visibilityCondition = field.visible!.split('==');
        final dependentField = visibilityCondition[0].trim();
        final expectedValue = visibilityCondition[1].trim().replaceAll("'", "");

        if (formValues[dependentField] == expectedValue) {
          visibleFields.add(field.fieldName);
        }
      }
    }

    ref.read(visibleFieldsProvider.notifier).state = visibleFields;
  }
}

void _showErrorDialog(BuildContext context) {
  Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
              "There is an error with a widget that you inserted in the json, it will not be displayed."),
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
  });
}
