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
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    final _controller = useTextEditingController();
    return ValueListenableBuilder(
      valueListenable: formState.getNotifier(formStateKey),
      builder: (context, value, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _controller.text = formState[formStateKey].toString();
          _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
        });
        return TextFormField(
          controller: _controller,
          readOnly: readOnly ?? false,
          keyboardType: textInputType,
          maxLines: maxLines,
          autocorrect: false,
          obscureText: obscureText ?? false,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          autofillHints: autofillHints,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Colors.black87,
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 0.0,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
                width: 2.0,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          onChanged: (String? val) => formState.updateFormOnly(formStateKey, val!),
          validator: validator,
        );
      },
    );
  }
}
