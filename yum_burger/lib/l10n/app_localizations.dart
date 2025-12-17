import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Yum Burger!'**
  String get hello;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Yum Burger!'**
  String greeting(Object name);

  /// No description provided for @homeHeaderDescription.
  ///
  /// In en, this message translates to:
  /// **'Order A YUM\nCombo\nToday!'**
  String get homeHeaderDescription;

  /// No description provided for @homeMenu.
  ///
  /// In en, this message translates to:
  /// **'Check the menu'**
  String get homeMenu;

  /// No description provided for @homeSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get homeSignUp;

  /// No description provided for @homeOfferTxt.
  ///
  /// In en, this message translates to:
  /// **'Check out our latest offers! \n Save up some money for your next meal!'**
  String get homeOfferTxt;

  /// No description provided for @homeOfferBtn.
  ///
  /// In en, this message translates to:
  /// **'Check Offers'**
  String get homeOfferBtn;

  /// No description provided for @homeOrderTxt.
  ///
  /// In en, this message translates to:
  /// **'Try Out Our Yum\nBacon Burger'**
  String get homeOrderTxt;

  /// No description provided for @homeOrderBtn.
  ///
  /// In en, this message translates to:
  /// **'Order Now'**
  String get homeOrderBtn;

  /// No description provided for @homeAboutTxt.
  ///
  /// In en, this message translates to:
  /// **'Want to learn how\nwe make our meals?'**
  String get homeAboutTxt;

  /// No description provided for @homeAboutBtn.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get homeAboutBtn;

  /// No description provided for @homeFaqTxt.
  ///
  /// In en, this message translates to:
  /// **'Have any questions?'**
  String get homeFaqTxt;

  /// No description provided for @homeFaqBtn.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get homeFaqBtn;

  /// No description provided for @homeCreateTxt.
  ///
  /// In en, this message translates to:
  /// **'Create your account and\ncheck out the latest promotions'**
  String get homeCreateTxt;

  /// No description provided for @aboutWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Yum Burger!'**
  String get aboutWelcome;

  /// No description provided for @aboutTxt.
  ///
  /// In en, this message translates to:
  /// **'At Yum Burger, we believe a great burger is more than just a meal, it’s an experience.\nCreated with fresh ingredients and bold flavors, we serve handcrafted burgers made to satisfy every craving.\n\nFrom our delicious beef patties to our plant‑based creations, every bite is cooked with care and served with a smile.\nWhether you’re dining in, ordering online, or grabbing a quick bite on the go, Yum Burger is here to make your day better.\n\nWe’re proud to be part of the community, offering friendly service, sustainable practices, and a menu that brings people together.\nSo come hungry, leave happy, and remember: life’s too short for boring burgers!'**
  String get aboutTxt;

  /// No description provided for @accountInfo.
  ///
  /// In en, this message translates to:
  /// **'Account Info'**
  String get accountInfo;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @adminHomeHamburgers.
  ///
  /// In en, this message translates to:
  /// **'Hamburgers'**
  String get adminHomeHamburgers;

  /// No description provided for @adminHomeRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get adminHomeRevenue;

  /// No description provided for @adminHomeCustomers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get adminHomeCustomers;

  /// No description provided for @adminHomeDrinks.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get adminHomeDrinks;

  /// No description provided for @adminOrdersTitle.
  ///
  /// In en, this message translates to:
  /// **'All Orders'**
  String get adminOrdersTitle;

  /// No description provided for @adminOrdersNoOrders.
  ///
  /// In en, this message translates to:
  /// **'No orders yet sorry.'**
  String get adminOrdersNoOrders;

  /// No description provided for @adminOrdersOrderNum.
  ///
  /// In en, this message translates to:
  /// **'Order #'**
  String get adminOrdersOrderNum;

  /// No description provided for @adminOrdersOrderTotal.
  ///
  /// In en, this message translates to:
  /// **'Total: '**
  String get adminOrdersOrderTotal;

  /// No description provided for @burgers.
  ///
  /// In en, this message translates to:
  /// **'Burgers'**
  String get burgers;

  /// No description provided for @addBurger.
  ///
  /// In en, this message translates to:
  /// **'Add Burger'**
  String get addBurger;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price: '**
  String get price;

  /// No description provided for @deletedBurger.
  ///
  /// In en, this message translates to:
  /// **'Burger was successfully deleted!'**
  String get deletedBurger;

  /// No description provided for @burgerName.
  ///
  /// In en, this message translates to:
  /// **'Burger Name'**
  String get burgerName;

  /// No description provided for @burgerPrice.
  ///
  /// In en, this message translates to:
  /// **'Burger Price'**
  String get burgerPrice;

  /// No description provided for @burgerDescription.
  ///
  /// In en, this message translates to:
  /// **'Burger Description'**
  String get burgerDescription;

  /// No description provided for @pickImage.
  ///
  /// In en, this message translates to:
  /// **'Pick Image'**
  String get pickImage;

  /// No description provided for @noImage.
  ///
  /// In en, this message translates to:
  /// **'No image'**
  String get noImage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @fillFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill out all the fields!'**
  String get fillFields;

  /// No description provided for @addedBurger.
  ///
  /// In en, this message translates to:
  /// **'Burger added successfully'**
  String get addedBurger;

  /// No description provided for @editBurger.
  ///
  /// In en, this message translates to:
  /// **'Edit Burger'**
  String get editBurger;

  /// No description provided for @editedBurger.
  ///
  /// In en, this message translates to:
  /// **'Burger edited successfully'**
  String get editedBurger;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get save;

  /// No description provided for @drinks.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get drinks;

  /// No description provided for @addDrink.
  ///
  /// In en, this message translates to:
  /// **'Add Drink'**
  String get addDrink;

  /// No description provided for @deletedDrink.
  ///
  /// In en, this message translates to:
  /// **'Drink was successfully deleted!'**
  String get deletedDrink;

  /// No description provided for @drinkName.
  ///
  /// In en, this message translates to:
  /// **'Drink Name'**
  String get drinkName;

  /// No description provided for @drinkPrice.
  ///
  /// In en, this message translates to:
  /// **'Drink Price'**
  String get drinkPrice;

  /// No description provided for @drinkDescription.
  ///
  /// In en, this message translates to:
  /// **'Drink Description'**
  String get drinkDescription;

  /// No description provided for @drinkAdded.
  ///
  /// In en, this message translates to:
  /// **'Drink added successfully!'**
  String get drinkAdded;

  /// No description provided for @editDrink.
  ///
  /// In en, this message translates to:
  /// **'Edit Drink'**
  String get editDrink;

  /// No description provided for @editedDrink.
  ///
  /// In en, this message translates to:
  /// **'Drink edited successfully'**
  String get editedDrink;

  /// No description provided for @myCart.
  ///
  /// In en, this message translates to:
  /// **'MY CART '**
  String get myCart;

  /// No description provided for @mustLogin.
  ///
  /// In en, this message translates to:
  /// **'You must log in to access cart'**
  String get mustLogin;

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmpty;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal:'**
  String get subtotal;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery fee:'**
  String get deliveryFee;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax:'**
  String get tax;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total:'**
  String get total;

  /// No description provided for @noBuy.
  ///
  /// In en, this message translates to:
  /// **'Why you don\'t buy anything'**
  String get noBuy;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'ORDER'**
  String get order;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'error'**
  String get error;

  /// No description provided for @goBackHome.
  ///
  /// In en, this message translates to:
  /// **'Go back home'**
  String get goBackHome;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @qOne.
  ///
  /// In en, this message translates to:
  /// **'What are your opening hours?'**
  String get qOne;

  /// No description provided for @aOne.
  ///
  /// In en, this message translates to:
  /// **'We’re open Monday to Sunday from 11:00 AM to 11:00 PM.'**
  String get aOne;

  /// No description provided for @qTwo.
  ///
  /// In en, this message translates to:
  /// **'Do you offer online ordering?'**
  String get qTwo;

  /// No description provided for @aTwo.
  ///
  /// In en, this message translates to:
  /// **'Yes! You can order directly through our website or mobile app for pickup or delivery.'**
  String get aTwo;

  /// No description provided for @qThree.
  ///
  /// In en, this message translates to:
  /// **'Are vegetarian or vegan options available?'**
  String get qThree;

  /// No description provided for @aThree.
  ///
  /// In en, this message translates to:
  /// **'Absolutely. We have veggie burgers and plant-based patties!'**
  String get aThree;

  /// No description provided for @qFour.
  ///
  /// In en, this message translates to:
  /// **'Do you deliver?'**
  String get qFour;

  /// No description provided for @aFour.
  ///
  /// In en, this message translates to:
  /// **'Yes, we deliver through partners like Uber Eats and DoorDash.'**
  String get aFour;

  /// No description provided for @qFive.
  ///
  /// In en, this message translates to:
  /// **'How can I contact customer support?'**
  String get qFive;

  /// No description provided for @aFive.
  ///
  /// In en, this message translates to:
  /// **'You can call us at (555) 123‑4567.'**
  String get aFive;

  /// No description provided for @qSix.
  ///
  /// In en, this message translates to:
  /// **'Do you have loyalty rewards?'**
  String get qSix;

  /// No description provided for @aSix.
  ///
  /// In en, this message translates to:
  /// **'Yes, sign up for our rewards program to earn points on every purchase.'**
  String get aSix;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @successLogin.
  ///
  /// In en, this message translates to:
  /// **'Success Login'**
  String get successLogin;

  /// No description provided for @failedLogin.
  ///
  /// In en, this message translates to:
  /// **'Failed Login'**
  String get failedLogin;

  /// No description provided for @notMember.
  ///
  /// In en, this message translates to:
  /// **'Not a member?'**
  String get notMember;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// No description provided for @errorAddToCart.
  ///
  /// In en, this message translates to:
  /// **'Error while adding to cart!'**
  String get errorAddToCart;

  /// No description provided for @successAddToCart.
  ///
  /// In en, this message translates to:
  /// **'Successfully added item to cart!'**
  String get successAddToCart;

  /// No description provided for @mustLoginToCart.
  ///
  /// In en, this message translates to:
  /// **'You must log in to add to cart!'**
  String get mustLoginToCart;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @mustLoginOrders.
  ///
  /// In en, this message translates to:
  /// **'You must be logged in to view your orders.'**
  String get mustLoginOrders;

  /// No description provided for @emptyOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders Empty.\n Make your first order!'**
  String get emptyOrders;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @noOrders.
  ///
  /// In en, this message translates to:
  /// **'No orders yet.'**
  String get noOrders;

  /// No description provided for @madePurchase.
  ///
  /// In en, this message translates to:
  /// **'You recently made a purchase of '**
  String get madePurchase;

  /// No description provided for @paymentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful!'**
  String get paymentSuccess;

  /// No description provided for @youPaid.
  ///
  /// In en, this message translates to:
  /// **'You paid '**
  String get youPaid;

  /// No description provided for @earnedPts.
  ///
  /// In en, this message translates to:
  /// **' and earned points!'**
  String get earnedPts;

  /// No description provided for @ty.
  ///
  /// In en, this message translates to:
  /// **'Thank you'**
  String get ty;

  /// No description provided for @paymentDecline.
  ///
  /// In en, this message translates to:
  /// **'Payment Declined. Check Card # (16) or Expiry (MM/YY).'**
  String get paymentDecline;

  /// No description provided for @secureCheckout.
  ///
  /// In en, this message translates to:
  /// **'Secure Checkout'**
  String get secureCheckout;

  /// No description provided for @cardNum.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNum;

  /// No description provided for @expDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expDate;

  /// No description provided for @confPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get confPayment;

  /// No description provided for @passNoMatch.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password and Password don\'t match'**
  String get passNoMatch;

  /// No description provided for @passResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password reset successfully!'**
  String get passResetSuccess;

  /// No description provided for @usernameNoExist.
  ///
  /// In en, this message translates to:
  /// **'Username does not exist!'**
  String get usernameNoExist;

  /// No description provided for @errorResetPass.
  ///
  /// In en, this message translates to:
  /// **'Error resetting password!'**
  String get errorResetPass;

  /// No description provided for @confPass.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confPass;

  /// No description provided for @rememberPass.
  ///
  /// In en, this message translates to:
  /// **'Remember the password?'**
  String get rememberPass;

  /// No description provided for @goToLogin.
  ///
  /// In en, this message translates to:
  /// **'Go to Login'**
  String get goToLogin;

  /// No description provided for @customerReviews.
  ///
  /// In en, this message translates to:
  /// **'Customer Reviews'**
  String get customerReviews;

  /// No description provided for @noLoadReviews.
  ///
  /// In en, this message translates to:
  /// **'Could not load reviews.'**
  String get noLoadReviews;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @noFoundReviews.
  ///
  /// In en, this message translates to:
  /// **'No reviews found.'**
  String get noFoundReviews;

  /// No description provided for @plsLogin.
  ///
  /// In en, this message translates to:
  /// **'Please log in'**
  String get plsLogin;

  /// No description provided for @rewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewards;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **' Points'**
  String get points;

  /// No description provided for @drinkPts.
  ///
  /// In en, this message translates to:
  /// **'Drinks (5 pts)'**
  String get drinkPts;

  /// No description provided for @burgerPts.
  ///
  /// In en, this message translates to:
  /// **'Burgers (10 pts)'**
  String get burgerPts;

  /// No description provided for @notEnoughPts.
  ///
  /// In en, this message translates to:
  /// **'Not enough points!'**
  String get notEnoughPts;

  /// No description provided for @redeemReward.
  ///
  /// In en, this message translates to:
  /// **'Redeem Reward'**
  String get redeemReward;

  /// No description provided for @showCashier.
  ///
  /// In en, this message translates to:
  /// **'Please show this screen to the cashier.'**
  String get showCashier;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'1x FREE'**
  String get free;

  /// No description provided for @cost.
  ///
  /// In en, this message translates to:
  /// **'Cost: '**
  String get cost;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @noFound.
  ///
  /// In en, this message translates to:
  /// **'No items found.'**
  String get noFound;

  /// No description provided for @dealsAndOffers.
  ///
  /// In en, this message translates to:
  /// **'Deals & Offers'**
  String get dealsAndOffers;

  /// No description provided for @noOffers.
  ///
  /// In en, this message translates to:
  /// **'No offers right now.'**
  String get noOffers;

  /// No description provided for @buyFree.
  ///
  /// In en, this message translates to:
  /// **'BUY 1 GET 1 FREE!'**
  String get buyFree;

  /// No description provided for @orderOne.
  ///
  /// In en, this message translates to:
  /// **'Order one '**
  String get orderOne;

  /// No description provided for @promoTxt.
  ///
  /// In en, this message translates to:
  /// **' and get the second one completely free!'**
  String get promoTxt;

  /// No description provided for @addOffer.
  ///
  /// In en, this message translates to:
  /// **'ADD OFFER'**
  String get addOffer;

  /// No description provided for @bogoDeal.
  ///
  /// In en, this message translates to:
  /// **'BOGO Deal added to cart!'**
  String get bogoDeal;

  /// No description provided for @priceError.
  ///
  /// In en, this message translates to:
  /// **'Price has to be a number value'**
  String get priceError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
