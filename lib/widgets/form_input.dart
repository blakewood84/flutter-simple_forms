import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:simple_forms/models/app_form_state.dart';

typedef Validator = String? Function(String? value);
typedef FormStateKey = dynamic;

class FormInput extends HookWidget {
  const FormInput({
    required this.formState,
    required this.formStateKey,
    required this.labelText,
    required this.validator,
    this.inputDecoration,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters = const [],
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
    this.readOnly,
    this.obscureText,
    Key? key,
  }) : super(key: key);

  final AppFormState formState;
  final FormStateKey formStateKey;

  final int maxLines;
  final bool? readOnly;
  final String labelText;
  final bool? obscureText;
  final Validator validator;

  final TextInputType textInputType;
  final InputDecoration? inputDecoration;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return ValueListenableBuilder(
      valueListenable: formState.getNotifier(formStateKey),
      builder: (context, value, child) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            controller.text = formState[formStateKey].toString();
            controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
          },
        );
        return TextFormField(
          controller: controller,
          readOnly: readOnly ?? false,
          keyboardType: textInputType,
          maxLines: maxLines,
          autocorrect: false,
          obscureText: obscureText ?? false,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          autofillHints: autofillHints,
          decoration: inputDecoration,
          onChanged: (String? val) => formState.updateFormOnly(formStateKey, val!),
          validator: validator,
        );
      },
    );
  }
}
