void main() {
  AppAnalytics()
    ..addService(FBAnalytics())
    ..addService(AppMetricaAnalytics())
    ..addService(FacebookAnalytics());

  runZonedGuarded();

// examples
  AppAnalytics().send(
    'test',
    {'key1': 'value1', 'key2': 'value2'},
  );

  AppAnalytics().sendEvent(TestEvent('value', 'value2'));
}
