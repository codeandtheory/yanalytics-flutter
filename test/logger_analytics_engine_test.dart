import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yanalytics/yanalytics.dart';

class MockLoggerAnalyticsEngine extends Mock implements LoggerAnalyticsEngine{}

void main() {
  late CompoundAnalyticsEngine sut;
  late MockLoggerAnalyticsEngine mockLoggerAnalyticsEngineOne;
  late MockLoggerAnalyticsEngine mockLoggerAnalyticsEngineTwo;

  setUp(() {
    sut = CompoundAnalyticsEngine();
    mockLoggerAnalyticsEngineOne = MockLoggerAnalyticsEngine();
    mockLoggerAnalyticsEngineTwo = MockLoggerAnalyticsEngine();
  });

  setUpAll(() {
    registerFallbackValue(AnalyticsEvent.screenView(screenName: 'test screen'));
  });

  test('forwards log event to all registered engines', () {
    // Arrange
    sut.add(engine: mockLoggerAnalyticsEngineOne);
    sut.add(engine: mockLoggerAnalyticsEngineTwo);

    // Act
    sut.trackEvent(AnalyticsEvent.screenView(screenName: 'dashboard'));

    // Assert
    verify(() => mockLoggerAnalyticsEngineOne.trackEvent(any())).called(1);
    verify(() => mockLoggerAnalyticsEngineTwo.trackEvent(any())).called(1);
  });

  test('forwards the same event to all engines when logging an event', () {
    // Arrange
    sut.add(engine: mockLoggerAnalyticsEngineOne);
    sut.add(engine: mockLoggerAnalyticsEngineTwo);
    final someEvent = AnalyticsEvent.userProperty(
        userPropertyName: 'name', userPropertyValue: 'value');

    // Act
    sut.trackEvent(someEvent);

    // Assert
    verify(
            () => mockLoggerAnalyticsEngineOne.trackEvent(any(that: equals(someEvent))));
    verify(
            () => mockLoggerAnalyticsEngineTwo.trackEvent(any(that: equals(someEvent))));
  });
}