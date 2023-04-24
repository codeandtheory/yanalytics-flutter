import 'analytics_engine.dart';

class CompoundAnalyticsEngine extends AnalyticsEngine {
  final List<AnalyticsEngine> _engines;

  List<AnalyticsEngine> get engines => _engines;

  /// Initialize compound analytics engine.
  ///
  /// `track(event:)` will be called on each engine in array order.
  /// [engines] array of engines to combine
  CompoundAnalyticsEngine({List<AnalyticsEngine>? engines})
      : _engines = engines ?? [];

  /// Add a new engine to dispatch events to
  void add({required AnalyticsEngine engine}) {
    _engines.add(engine);
  }

  @override
  void trackEvent(AnalyticsEvent event) {
    _engines.forEach((engine) => engine.trackEvent(event));
  }

  @override
  void trackEventFactory(AnalyticsEventFactory factory) {
    _engines.forEach((engine) => engine.trackEventFactory(factory));
  }
}
