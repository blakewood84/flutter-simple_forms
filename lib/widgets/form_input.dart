import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_forms/models/app_form_state.dart';

typedef OnChanged = Function(String? value);
typedef Validator = String? Function(String? value);
typedef FormStateKey = String;

class FormInput extends StatefulWidget {
  const FormInput({
    required this.formState,
    required this.formStateKey,
    required this.labelText,
    required this.validator,
    this.onChanged,
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
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType textInputType;
  final Iterable<String>? autofillHints;
  final int maxLines;
  final bool? readOnly;
  final OnChanged? onChanged;
  final Validator validator;
  final String labelText;
  final bool? obscureText;

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Find the notifier to use
    _controller.text = widget.formState[widget.formStateKey];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.formState.getNotifier(widget.formStateKey),
      builder: (context, Map<dynamic, dynamic> formStateListenable, child) {
        _controller.text = formStateListenable[widget.formStateKey].toString();
        return TextFormField(
          controller: _controller,
          readOnly: widget.readOnly ?? false,
          keyboardType: widget.textInputType,
          maxLines: widget.maxLines,
          autocorrect: false,
          obscureText: widget.obscureText ?? false,
          inputFormatters: widget.inputFormatters,
          textCapitalization: widget.textCapitalization,
          autofillHints: widget.autofillHints,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: widget.labelText,
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
          onChanged: (String? val) => widget.formState.updateValue(widget.formStateKey, val),
          validator: widget.validator,
        );
      },
    );
  }
}
