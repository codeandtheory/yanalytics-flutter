import 'analytics_engine.dart';

class CompoundAnalyticsEngine extends AnalyticsEngine {
  final List<AnalyticsEngine> _engines;

  List<AnalyticsEngine> get engines => _engines;

  CompoundAnalyticsEngine({List<AnalyticsEngine>? engines})
      : _engines = engines ?? [];

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
