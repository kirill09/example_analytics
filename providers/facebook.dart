import 'package:facebook_app_events/facebook_app_events.dart';

class FacebookAnalytics implements AnalyticsProvider {
  final FacebookAppEvents _facebookAppEvents;

  FacebookAnalytics() : _facebookAppEvents = FacebookAppEvents();

  @override
  Future<void> registerUser(AppUser user) async {
    await _facebookAppEvents.setUserID(user.uid);
  }

  @override
  Future<void> send(String name, Map<String, dynamic> event) async {
    await _facebookAppEvents.logEvent(name: name, parameters: event);
  }

  @override
  NavigatorObserver navigatorObservers() {
    return null;
  }

  @override
  Future<void> reportReferralUrl(String referral) {
    return null;
  }

  @override
  Future<void> updateUser(Map<String, dynamic> props) {
    _facebookAppEvents.updateUserProperties(parameters: props);
    return null;
  }
}
