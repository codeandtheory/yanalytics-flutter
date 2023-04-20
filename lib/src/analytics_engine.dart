class AnalyticsEvent {
  final String? userPropertyValue;
  final String? userPropertyName;
  final String? screenName;
  final String? eventName;
  final Map<String, dynamic>? eventParemeters;

  AnalyticsEvent.screenView({required this.screenName})
      : userPropertyName = null,
        userPropertyValue = null,
        eventName = null,
        eventParemeters = null;

  AnalyticsEvent.userProperty(
      {required this.userPropertyName, required this.userPropertyValue})
      : screenName = null,
        eventName = null,
        eventParemeters = null;

  AnalyticsEvent.event({required this.eventName, this.eventParemeters})
      : screenName = null,
        userPropertyName = null,
        userPropertyValue = null;
}

abstract class AnalyticsEventFactory {
  AnalyticsEvent get event;
}

abstract class AnalyticsEngine {
  void trackEvent(AnalyticsEvent event);
  void trackEventFactory(AnalyticsEventFactory factory);
}
