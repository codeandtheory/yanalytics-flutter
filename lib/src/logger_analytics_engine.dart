import 'analytics_engine.dart';

class LoggerAnalyticsEngine extends AnalyticsEngine
{
  Logger get logger => Logger("co.yml.yanalytics.Core", "Analytics");

  @override
  void trackEvent(AnalyticsEvent event)
  {
    if (event.screenName != null)
    {
      String? screenName = event.screenName;
      logger.log("Screen view: $screenName");
    }
    else if (event.userPropertyName != null)
    {
      String? userPropertyName = event.userPropertyName;
      String? userPropertyValue = event.userPropertyValue;
      logger.log("User property:: $userPropertyName = $userPropertyValue");
    }
    else if (event.eventName != null)
    {
      String? eventName = event.eventName;
      Map<String, dynamic>? eventParameters = event.eventParemeters;
      if (event.eventParemeters != null)
      {
        logger.log("Event: $eventName, $eventParameters");
      }
      else
      {
        logger.log("Event: $eventName");
      }
    }
  }

  @override
  void trackEventFactory(AnalyticsEventFactory factory) {
    if (factory.event.eventName != null)
    {
      String? screenName = factory.event.screenName;
      logger.log("Screen view: $screenName");
    }
    else if (factory.event.userPropertyName != null)
    {
      String? userPropertyName = factory.event.userPropertyName;
      String? userPropertyValue = factory.event.userPropertyValue;
      logger.log("User property:: $userPropertyName = $userPropertyValue");
    }
    else if (factory.event.eventName != null)
    {
      String? eventName = factory.event.eventName;
      Map<String, dynamic>? eventParameters = factory.event.eventParemeters;
      if (factory.event.eventParemeters != null)
      {
        logger.log("Event: $eventName, $eventParameters");
      }
      else
      {
        logger.log("Event: $eventName");
      }
    }
  }
}

class Logger
{
  final String _subsystem;
  final String _category;

  Logger(this._subsystem, this._category);

  void log(String message)
  {
    print('[$_subsystem/$_category]: $message');
  }
}