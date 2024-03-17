import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_api/app/app_service_setup.dart';
import 'package:teste_api/app/configs/AppSettings.dart';

class MockAppService extends Mock implements AppService {}

class MockBuildContext extends Mock implements BuildContext {}

class MockAppSettings extends Mock implements AppSettings {
  late Map<String, dynamic> _conta;
  Map<String, dynamic> get conta => _conta;
  factory MockAppSettings.create() => MockAppSettings._();

  MockAppSettings._() {
    _conta = {
      'username': '',
      'isAuth': false,
      'setupModel': null,
    };
  }

  getConta() {
    return conta;
  }
}

class MockDio extends Mock implements Dio {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MockAppService appService = MockAppService();
  MockBuildContext buildContext = MockBuildContext();
  MockAppSettings appSettings = MockAppSettings.create();
  test('TRYLOGIN', () async {

    await appService.tryLogin('adolfo.silva', '123456', 'lumen');

    final setup = appService.getSetupModel;

    expect(setup, isNotNull);
  });

  test('TRYLOGOUT', () async {
    appService.logout(buildContext);

    final conta = appSettings.getConta();

    expect(conta, isNotNull); // Verifica se conta não é nulo
    expect(conta.containsKey('username'), true);
    expect(conta['username'], '');
    expect(conta.containsKey('isAuth'), true);
    expect(conta['isAuth'], false);
    expect(conta.containsKey('setupModel'), true);
    expect(conta['setupModel'], null);
  });
}
/*
    appService.tryLogin('adolfo.silva', '123456', 'lumen');
      test('getRotina should return a Future<Response<dynamic>>', () async {
    await appService.tryLogin('adolfo.silva', '123456', 'lumen');
    final expectedResponse = Response(data: 'response_data', statusCode: 200, requestOptions: );
    when(mockDio.get(any, options: anyNamed('options'))).thenAnswer((_) async => expectedResponse);
    expect(appService.getRotina('PALM/v1/AppCD01'), isNotNull);
    
    
  });
    verify(appService.tryLogin('adolfo.silva', '123456', 'lumen')).called(1);
*/
