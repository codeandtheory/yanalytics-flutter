import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yanalytics/yanalytics.dart';

class MockAnalyticsEngine extends Mock implements AnalyticsEngine {}

class FakeAnalyticsEventFactory implements AnalyticsEventFactory {
  @override
  AnalyticsEvent get event =>
      AnalyticsEvent.screenView(screenName: 'test screen');
}

void main() {
  late CompoundAnalyticsEngine sut;
  late MockAnalyticsEngine mockAnalyticsEngineOne;
  late MockAnalyticsEngine mockAnalyticsEngineTwo;
  late FakeAnalyticsEventFactory fakeAnalyticsEventFactory;

  setUp(() {
    sut = CompoundAnalyticsEngine();
    fakeAnalyticsEventFactory = FakeAnalyticsEventFactory();
    mockAnalyticsEngineOne = MockAnalyticsEngine();
    mockAnalyticsEngineTwo = MockAnalyticsEngine();
    fakeAnalyticsEventFactory = FakeAnalyticsEventFactory();
  });

  setUpAll(() {
    registerFallbackValue(AnalyticsEvent.screenView(screenName: 'test screen'));
    registerFallbackValue(FakeAnalyticsEventFactory());
  });

  test('forwards track event to all registered engines', () {
    // Arrange
    sut.add(engine: mockAnalyticsEngineOne);
    sut.add(engine: mockAnalyticsEngineTwo);

    // Act
    sut.trackEvent(AnalyticsEvent.screenView(screenName: 'dashboard'));

    // Assert
    verify(() => mockAnalyticsEngineOne.trackEvent(any())).called(1);
    verify(() => mockAnalyticsEngineTwo.trackEvent(any())).called(1);
  });

  test('forwards the same event to all engines when tracking an event', () {
    // Arrange
    sut.add(engine: mockAnalyticsEngineOne);
    sut.add(engine: mockAnalyticsEngineTwo);
    final someEvent = AnalyticsEvent.userProperty(
        userPropertyName: 'name', userPropertyValue: 'value');

    // Act
    sut.trackEvent(someEvent);

    // Assert
    verify(
        () => mockAnalyticsEngineOne.trackEvent(any(that: equals(someEvent))));
    verify(
        () => mockAnalyticsEngineTwo.trackEvent(any(that: equals(someEvent))));
  });
}
