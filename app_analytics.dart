class AppAnalytics {
  final _logger = createLogger('AppAnalytics');

  static final AppAnalytics _singleton = AppAnalytics._internal();

  factory AppAnalytics() => _singleton;

  AppAnalytics._internal();

  bool isDebug = false;

  final List<AnalyticsProvider> _services = [];

  void addService(AnalyticsProvider service) {
    _services.add(service);
  }

  void error(dynamic error, {StackTrace stackTrace}) {
    if (isDebug) {
      debugPrint('AppLogger error: $error');
      return;
    }

    Zone.current?.handleUncaughtError(
      error,
      stackTrace ?? StackTrace.current,
    );
  }

  void send(String name, Map<String, dynamic> event) {
    if (isDebug) {
      _logger.i('send: $name ${event.toString()}');
      return;
    }
    // Некоторе системы аналитики не принимают значение null
    event
      ..removeWhere((key, value) => (value == null || key == null))
      ..removeWhere((key, value) => (value is List));

    _services.forEach((item) {
      item.send(name, event);
    });
  }

  void sendEvent(EventInterface event) {
    send(event.name, event.toMap());
  }

  void updateUser(Map<String, dynamic> props) {
    _services.forEach((service) => service.updateUser(props));
  }

  void userAuth(AppUser user) async {
    _services.forEach((service) => service.registerUser(user));
  }

  List<NavigatorObserver> navigatorObservers() {
    return _services
        .where((item) => item.navigatorObservers() != null)
        .map((item) => item.navigatorObservers())
        .toList();
  }

  void reportReferralUrl(String referral) async {
    _services.forEach((service) => service.reportReferralUrl(referral));
  }
}

abstract class AnalyticsProvider {
  Future<void> send(String name, Map<String, dynamic> event);
  Future<void> registerUser(AppUser user);
  Future<void> reportReferralUrl(String referral);
  Future<void> updateUser(Map<String, dynamic> props);

  NavigatorObserver navigatorObservers() {
    return null;
  }
}

abstract class EventInterface {
  final String name;
  final int timestamp;

  EventInterface(this.name) : timestamp = DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toMap() => {
        'timestamp': timestamp ~/ 1000,
      };
}
