class FormFieldModel {
  final String fieldName;
  final String widget;
  final List<String>? validValues;
  final String? visible;
  final String? text;
  final String? group;

  FormFieldModel({
    required this.fieldName,
    required this.widget,
    this.validValues,
    this.visible,
    this.text,
    this.group,
  });

  factory FormFieldModel.fromJson(Map<String, dynamic> json) {
    return FormFieldModel(
      fieldName: json['field_name'] as String,
      widget: json['widget'] as String,
      validValues: json['valid_values'] != null
          ? List<String>.from(json['valid_values'] as List)
          : null,
      visible: json['visible'] as String?,
      text: json['text'] as String?,
      group: json['group'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'field_name': fieldName,
      'widget': widget,
      'valid_values': validValues,
      'visible': visible,
      'text': text,
      'group': group,
    };
  }
}
