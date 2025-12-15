import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:yum_burger/Controllers/locale_controller.dart';
import 'package:yum_burger/Controllers/notifications_controller.dart';
import 'package:yum_burger/Controllers/user_controller.dart';
import 'package:yum_burger/Controllers/header.dart';
import 'package:yum_burger/Models/database_connection.dart';
import '../Controllers/tab_navigation.dart';
import 'package:yum_burger/l10n//app_localizations.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPage();
}

class _AccountSettingsPage extends State<AccountSettingsPage> {
  UserController userController = UserController();
  var user;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    var currentUser = await userController.getCurrentUser();
    setState(() {
      user = currentUser;
    });
  }

  void _onTabTapped(int index) {
    if (index == 3) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyNavigation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    bool isDark = AdaptiveTheme.of(context).mode.isDark;
    return NavBar(
      body: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 150,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(t.accountInfo, style: TextStyle(fontSize: 30)),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    children: [
                       Text(t.username, style: TextStyle(fontSize: 25)),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: user == null
                            ?  Text(t.username)
                            : Text("${user['username']}",
                            style: const TextStyle(color: Colors.black, fontSize: 25)),
                      ),
                      const SizedBox(height: 15),
                       Text(t.password, style: TextStyle(fontSize: 25)),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: user == null
                            ?  Text(t.password)
                            : Text("${user['password']}",
                            style: const TextStyle(color: Colors.black, fontSize: 25)),
                      ),
                      const SizedBox(height: 15),
                       Text(t.fullName, style: TextStyle(fontSize: 25)),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: user == null
                            ?  Text(t.fullName)
                            : Text("${user['fullName']}",
                            style: const TextStyle(color: Colors.black, fontSize: 25)),
                      ),
                      const SizedBox(height: 15),
                       Text(t.email, style: TextStyle(fontSize: 25)),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: user == null
                            ?  Text(t.email)
                            : Text("${user['email']}",
                            style: const TextStyle(color: Colors.black, fontSize: 25)),
                      ),
                      const SizedBox(height: 15),
                       Text(t.settings, style: TextStyle(fontSize: 30)),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (isDark) {
                                AdaptiveTheme.of(context).setLight();
                              } else {
                                AdaptiveTheme.of(context).setDark();
                              }
                            },
                            child: Icon(
                              isDark ? Icons.dark_mode : Icons.light_mode,
                              size: 40,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Locale currentLocale = Localizations.localeOf(context);

                              Locale newLocale = currentLocale.languageCode == 'en'
                                  ? const Locale('fr')
                                  : const Locale('en');

                              MyAppState? myApp = context.findAncestorStateOfType<MyAppState>();
                              myApp?.setLocale(newLocale);
                            },
                            child: const Icon(Icons.language, size: 40),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Offers'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Rewards'),
          BottomNavigationBarItem(icon: Icon(Icons.rate_review), label: 'Reviews'),
        ],
      ),
    );
  }
}