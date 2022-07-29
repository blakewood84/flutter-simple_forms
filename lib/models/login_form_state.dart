import 'package:simple_forms/models/app_form_state.dart';

class LoginFormState extends AppFormState<String, dynamic> {
  LoginFormState()
      : super(
          {
            'email': '',
            'password': '',
          },
        );
}
