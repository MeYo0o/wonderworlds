import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.userRepository,
  }) : super(
          const SignInState(),
        );

  final UserRepository userRepository;

  void onEmailChanged(String newValue) {
    final previousState = state;
    final previousEmailState = previousState.email;
    final shouldValidate = previousEmailState.invalid;

    final newEmailState = shouldValidate
        ? Email.validated(newValue)
        : Email.unvalidated(newValue);

    final newScreenState = state.copyWith(
      email: newEmailState,
    );

    emit(newScreenState);
  }

  void onEmailUnfocused() {
    final previousState = state;
    final previousEmailState = previousState.email;
    final previousEmailValue = previousEmailState.value;

    final newEmailState = Email.validated(
      previousEmailValue,
    );

    final newScreenState = state.copyWith(
      email: newEmailState,
    );

    emit(newScreenState);
  }

  void onPasswordChanged(String newValue) {
    final lastPasswordState = state.password;
    final shouldValidate = lastPasswordState.invalid;
    final newPasswordState = shouldValidate
        ? Password.validated(newValue)
        : Password.unvalidated(newValue);

    final newScreenState = state.copyWith(
      password: newPasswordState,
    );

    emit(newScreenState);
  }

  void onPasswordUnfocused() {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final previousPasswordValue = previousPasswordState.value;

    final newPasswordState = Password.validated(
      previousPasswordValue,
    );

    final newScreenState = state.copyWith(
      password: newPasswordState,
    );

    emit(newScreenState);
  }

  void onSubmit() async {
    final email = Email.validated(state.email.value);
    final password = Password.validated(state.password.value);

    final isFormValid = Formz.validate([email, password]).isValid;

    final newButtonState = state.copyWith(
      email: email,
      password: password,
      submissionStatus: isFormValid ? SubmissionStatus.inProgress : null,
    );

    emit(newButtonState);

    if (isFormValid) {
      try {
        await userRepository.signIn(
          email.value,
          password.value,
        );
        final newButtonState = state.copyWith(
          submissionStatus: SubmissionStatus.success,
        );

        emit(newButtonState);
      } catch (error) {
        final newButtonState = state.copyWith(
          submissionStatus: error is InvalidCredentialsException
              ? SubmissionStatus.invalidCredentialsError
              : SubmissionStatus.genericError,
        );

        emit(newButtonState);
      }
    }
  }
}
