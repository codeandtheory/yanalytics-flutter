/// Represents any event we might wish to track via analytics
class AnalyticsEvent {
  final String? userPropertyValue;
  final String? userPropertyName;
  final String? screenName;
  final String? eventName;
  final Map<String, dynamic>? eventParemeters;

  /// Screen view event
  ///
  /// [screenName] screen name
  AnalyticsEvent.screenView({required this.screenName})
      : userPropertyName = null,
        userPropertyValue = null,
        eventName = null,
        eventParemeters = null;

  /// User property event
  ///
  /// [name] user property name
  /// [value] user property value
  AnalyticsEvent.userProperty(
      {required this.userPropertyName, required this.userPropertyValue})
      : screenName = null,
        eventName = null,
        eventParemeters = null;

  /// Generic event
  ///
  /// [name] event name
  /// [parameters] event metadata to track
  AnalyticsEvent.event({required this.eventName, this.eventParemeters})
      : screenName = null,
        userPropertyName = null,
        userPropertyValue = null;
}

abstract class AnalyticsEventFactory {
  AnalyticsEvent get event;
}

/// Generic analytics functions to abstract away from specific implementations (Firebase etc)
abstract class AnalyticsEngine {
  /// Track an analytics event
  ///
  /// [event] the event to log
  void trackEvent(AnalyticsEvent event);

  /// Tracks an analytics event
  ///
  /// [factory] object that generates the event to log
  void trackEventFactory(AnalyticsEventFactory factory) {
    trackEvent(factory.event);
  }
}
