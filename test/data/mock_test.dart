import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements AuthenticationController {
  @override
  // ignore: override_on_non_overriding_member
  Future<bool> signIn({required String email, required String password}) async {
    final emailVal = "barry.allen@example.com" == email;
    final passwordVal = "SuperSecretPassword!" == password;
    return emailVal && passwordVal;
  }

  @override
  // ignore: override_on_non_overriding_member
  Future<bool> signOut() async {
    return true;
  }

  @override
  // ignore: override_on_non_overriding_member
  Future<bool> signUp(
      {required String name,
      required String email,
      required String password}) async {
    final emailVal = email.contains("@") && email.contains(".co");
    final passwordVal = password.length > 6;
    return emailVal && passwordVal;
  }
}

void main() {
  late MockAuth auth;

  setUp(() {
    auth = MockAuth();
  });

  test('auth-signin', () async {
    final result = await auth.signIn(
        email: "barry.allen@example.com", password: "SuperSecretPassword!");
    expect(result, true);
  });

  test('auth-signup', () async {
    final result = await auth.signUp(
        name: "Barry Allen",
        email: "barry.allen@example.com",
        password: "SuperSecretPassword!");
    expect(result, true);
  });

  test('auth-signout', () async {
    final result = await auth.signOut();
    expect(result, true);
  });
}

class Auth {
  signIn({required String email, required String password}) {}

  signUp(
      {required String name,
      required String email,
      required String password}) {}

  signOut() {}
}
