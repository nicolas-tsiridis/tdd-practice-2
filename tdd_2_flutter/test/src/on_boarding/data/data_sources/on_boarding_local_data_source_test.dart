import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart'; //cSpell:ignore mocktail
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_2_flutter/core/errors/exceptions.dart';
import 'package:tdd_2_flutter/src/on_boarding/data/data_sources/on_boarding_local_data_source.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnBoardingLocalDataSource localDataSource;

  setUp(() {
    prefs = MockSharedPreferences();
    localDataSource = OnBoardingLocalDataSourceImpl(prefs);
  });

  group('cacheFirstTimer', () {
    test('should call [SharedPreferences] to cache data', () async {
      when(() => prefs.setBool(any(), any()))
          .thenAnswer((_) async => true); //cSpell:ignore prefs
      await localDataSource.cacheFirstTimer();
      verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test(
        'should throw a [CacheException] when there is an error caching the data',
        () async {
      when(() => prefs.setBool(any(), any())).thenThrow(Exception());

      final methodCall = localDataSource.cacheFirstTimer;
      expect(methodCall, throwsA(isA<CacheException>()));
      verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });

  group('checkIfUserIsFirstTimer', () {
    test(
        'should call the [SharedPreferences] to check if user is a first '
        'timer and return the correct response from storage when data exists',
        () async {
      when(() => prefs.getBool(any())).thenReturn(false);

      final result = await localDataSource.checkIfUserIsFirstTimer();
      expect(result, false);
      verify(() => prefs.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test('should return true if there is no data in storage', () async {
      when(() => prefs.getBool(any())).thenReturn(null);
      final result = await localDataSource.checkIfUserIsFirstTimer();
      expect(result, true);
      verify(() => prefs.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test(
        'should throw a [CacheException] when there is an error '
        'retrieving the data', () async {
      when(() => prefs.getBool(any())).thenThrow(Exception());
      final call = localDataSource.checkIfUserIsFirstTimer;
      expect(call, throwsA(isA<CacheException>()));
      verify(() => prefs.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });
}
