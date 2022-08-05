import 'package:flutter/material.dart';

import 'package:simple_forms/widgets/form_input.dart';
import 'package:simple_forms/models/login_form_state.dart';

import 'dart:developer' as devtools;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formState = LoginFormState();

  @override
  void initState() {
    super.initState();
    setDelayedValue();
  }

  Future<void> setDelayedValue() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      _formState['email'] = 'BOOM!!'; // Widget will show changed value
      _formState.updateFormOnly('email', 'new@value.com'); // Widget won't display this value
    });
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      _formState['password'] = 'BOOM # 2!!'; // Only the FormInput with password as key will update
    });
  }

  void _onSubmit() {
    devtools.log(_formState.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text('Simple Form Demo'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: constraints.maxWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 40),
                FormInput(
                  formState: _formState,
                  formStateKey: 'email',
                  labelText: 'Email',
                  validator: (String? val) {},
                ),
                const SizedBox(height: 20),
                FormInput(
                  formState: _formState,
                  formStateKey: 'password',
                  labelText: 'Password',
                  validator: (String? val) {},
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text('Save Form'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
