import 'analytics_engine.dart';

/// A class that extends AnalyticsEngine that allows to log messages from each event 
class LoggerAnalyticsEngine extends AnalyticsEngine
{
  /// The logger instance definition.
  Logger get logger => Logger("co.yml.yanalytics.Core", "Analytics");

  /// Log an analytics event
  ///
  /// [event] the event to log
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

  /// Log an analytics event
  ///
  /// [factory] object that generates the event to log
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

/// Logger class to handle logging
class Logger
{
  /// The name for the subsystem.
  final String _subsystem;

  /// The name for the category.
  final String _category;

  Logger(this._subsystem, this._category);

  /// Log a message
  ///
  /// [message] the message to log
  void log(String message)
  {
    print('[$_subsystem/$_category]: $message');
  }
}