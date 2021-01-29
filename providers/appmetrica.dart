import 'package:appmetrica_sdk/appmetrica_sdk.dart';

class AppMetricaAnalytics implements AnalyticsProvider {
  final _appMetrica = AppmetricaSdk();

  AppMetricaAnalytics() {
    _appMetrica.activate(apiKey: 'af87a369-8407-4188-9bcc-c3c211176f73');
  }

  @override
  Future<void> registerUser(AppUser user) async {
    await _appMetrica.setUserProfileID(userProfileID: user.uid);
    await _appMetrica.reportUserProfileUserName(userName: user.phoneNumber);
  }

  @override
  Future<void> send(String name, Map<String, dynamic> event) async {
    await _appMetrica.reportEvent(name: name, attributes: event);
  }

  @override
  NavigatorObserver navigatorObservers() {
    return null;
  }

  @override
  Future<void> reportReferralUrl(String referral) async {
    await _appMetrica.reportReferralUrl(referral: referral);
  }

  @override
  Future<void> updateUser(Map<String, dynamic> props) {
    props.forEach((String key, dynamic value) {
      if (key == 'notification_permission') {
        _appMetrica.reportUserProfileNotificationsEnabled(
          notificationsEnabled: value,
        );
      } else if (value is String) {
        _appMetrica.reportUserProfileCustomString(key: key, value: value);
      } else if (value is bool) {
        _appMetrica.reportUserProfileCustomBoolean(key: key, value: value);
      } else if (value is double) {
        _appMetrica.reportUserProfileCustomNumber(key: key, value: value);
      }
    });
    return null;
  }
}
