// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get hello => 'Bonjour!';

  @override
  String greeting(Object name) {
    return 'Bienvenue, $name!';
  }

  @override
  String get homeHeaderDescription =>
      'Commandez un YUM\ncombo\ndès aujourd\'hui!';

  @override
  String get homeMenu => 'Consultez le menu';

  @override
  String get homeSignUp => 'Inscrivez-vous';

  @override
  String get homeOfferTxt =>
      'Découvrez nos dernières offres!\n Économisez sur votre prochain repas!';

  @override
  String get homeOfferBtn => 'Consultez les offres';

  @override
  String get homeOrderTxt => 'Essayez notre délicieux burger au bacon!';

  @override
  String get homeOrderBtn => 'Commandez maintenant';

  @override
  String get homeAboutTxt =>
      'Envie de savoir comment\n nous préparons nos plats?';

  @override
  String get homeAboutBtn => 'À propos de nous';

  @override
  String get homeFaqTxt => 'Des questions?';

  @override
  String get homeFaqBtn => 'FAQ';

  @override
  String get homeCreateTxt =>
      'Créez votre compte et\n découvrez les dernières promotions';
}
