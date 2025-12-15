// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello!';

  @override
  String greeting(Object name) {
    return 'Welcome, $name!';
  }

  @override
  String get homeHeaderDescription => 'Order A YUM\nCombo\nToday!';

  @override
  String get homeMenu => 'Check the menu';

  @override
  String get homeSignUp => 'Sign up';

  @override
  String get homeOfferTxt =>
      'Check out our latest offers! \n Save up some money for your next meal!';

  @override
  String get homeOfferBtn => 'Check Offers';

  @override
  String get homeOrderTxt => 'Try Out Our Yum\nBacon Burger';

  @override
  String get homeOrderBtn => 'Order Now';

  @override
  String get homeAboutTxt => 'Want to learn how\nwe make our meals?';

  @override
  String get homeAboutBtn => 'About Us';

  @override
  String get homeFaqTxt => 'Have any questions?';

  @override
  String get homeFaqBtn => 'FAQ';

  @override
  String get homeCreateTxt =>
      'Create your account and\ncheck out the latest promotions';
}
