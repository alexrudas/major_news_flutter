import 'package:app_majpr_new/domain/use_case/auth_management.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/ui/pages/initial_presentation/initial_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUp(() {
    Get.put(AuthManagement());
    Get.put(AuthenticationController());
  });

  // Test Login
  testWidgets('Login widget testing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // El pumpWidget Construye el app y muestra el frame
    await tester.pumpWidget(
      GetMaterialApp(
        // Aqui decimos que haga el test en InitialPresentation
        home: InitialPresentation(),
      ),
    );

    // El tester.pum espera por defecto 5 segundos
    await tester.pump();

    // con elfindsOneWidget se espera encontrar un Widget
    expect(find.byKey(Key('presentationScaffold')), findsOneWidget);

    // con findsNWidgets se espera encontrar uno o varios Widgets
    // testeamos el Button_login
    expect(find.byKey(Key('Button_login')), findsNWidgets(1));

    // esta línea hace tap (simula la presión del botón)
    await tester.tap(find.byKey(Key('Button_login')));
    await tester.pumpAndSettle(); // salta a la página ciuando

    expect(find.byKey(Key('loginScaffold')), findsOneWidget);
    //expect(find.byKey(Key('Iniciar sesión')), findsNWidgets(1));

    await tester.enterText(find.byKey(Key('keyTFemail')), 'a@a.com');
    await tester.enterText(find.byKey(Key('keyTFPassword')), '123456');
    //expect(find.text('User ok'), findsOneWidget);
    expect(find.text('a@a.com'), findsOneWidget);
    expect(find.text('123456'), findsOneWidget);
  });

  // Test SignUp
  testWidgets("signUp test", (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // El pumpWidget Construye el app y carga el widget
    await tester.pumpWidget(
      GetMaterialApp(
        home: InitialPresentation(),
      ),
    );

    await tester.pump();
    expect(find.byKey(Key('presentationScaffold')), findsOneWidget);
    expect(find.byKey(Key('keyButtonSignUp')), findsNWidgets(1));

    await tester.tap(find.byKey(Key('keyButtonSignUp')));
    await tester.pumpAndSettle(); // Hace el salto de página

    //expect(find.byKey(Key('loginScaffold')), findsOneWidget);
    expect(find.byKey(Key('keySign')), findsNWidgets(1));

    await tester.enterText(find.byKey(Key('keyTFname')), 'abc254');
    await tester.enterText(find.byKey(Key('keyTFemail')), 'a@a.com');
    await tester.enterText(find.byKey(Key('keyTFPassword')), '123456');
    await tester.enterText(find.byKey(Key('keyTFConfirmPassword')), '123456');
    await tester.pumpAndSettle(); // termina la animación de ingresar texto
    expect(find.text('abc254'), findsOneWidget);
    expect(find.text('a@a.com'), findsOneWidget);
    expect(find.text('123456'), findsNWidgets(2));
  });
}
