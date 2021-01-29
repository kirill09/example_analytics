import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class FBAnalytics implements AnalyticsProvider {
  final _analytics = FirebaseAnalytics();

  @override
  Future<void> send(String name, Map<String, dynamic> event) async {
    await _analytics?.logEvent(
      name: name,
      parameters: event,
    );
  }

  @override
  NavigatorObserver navigatorObservers() {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  @override
  Future<void> registerUser(AppUser user) async {
    await _analytics.setUserId(user.uid);
  }

  @override
  Future<void> reportReferralUrl(String referral) {
    return null;
  }

  @override
  Future<void> updateUser(Map<String, dynamic> props) {
    props.forEach((String key, dynamic value) {
      _analytics.setUserProperty(name: key, value: value.toString());
    });
    return null;
  }
}
