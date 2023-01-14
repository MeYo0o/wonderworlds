import 'package:form_fields/form_fields.dart';

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.unvalidated([String value = '']) : super.pure(value);

  const Password.validated([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }
    if (value.length < 5 || value.length > 120) {
      return PasswordValidationError.invalid;
    }
    return null;
  }
}

enum PasswordValidationError {
  empty,
  invalid,
}
