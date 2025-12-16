import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yum_burger/Controllers/burger_controller.dart';
import 'package:yum_burger/Controllers/cart_controller.dart';
import 'package:yum_burger/Controllers/user_controller.dart';
import 'package:yum_burger/l10n//app_localizations.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersPage> {
  final BurgerController _burgerController = BurgerController();
  final CartController _cartController = CartController();
  final UserController _userController = UserController();

  Map<String, dynamic>? _promoItem;
  String? _promoItemId;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPromoItem();
  }


  Future<void> _loadPromoItem() async {
    var collection = await _burgerController.getBurgersCollection();

    if (collection == null) {
      if (mounted) {
        setState(() => _loading = false);
      }
      return;
    }

    var snapshot = await collection.get();

    if (snapshot.docs.isNotEmpty) {
      var doc = snapshot.docs.first;
      if (mounted) {
        setState(() {
          _promoItem = doc.data() as Map<String, dynamic>;
          _promoItemId = doc.id;
          _loading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xfff2e9db),
      appBar: AppBar(
        title: Text(t.dealsAndOffers),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.brown,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _promoItem == null
          ?  Center(child: Text(t.noOffers))
           : Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _buildBogoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildBogoCard() {
    double originalPrice = (_promoItem!['price'] as num).toDouble();
    final t = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.memory(
              base64Decode(_promoItem?['image']),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  t.buyFree,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${t.orderOne}${_promoItem!['name']}${t.promoTxt}",
                  style:  TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${(originalPrice * 2).toStringAsFixed(2)}",
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.white60,
                          ),
                        ),
                        Text(
                          "\$${originalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () => _applyOffer(),
                      child:  Text(t.addOffer, style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _applyOffer() async {
    final t = AppLocalizations.of(context)!;
    final user = _userController.getCurrentUser();
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(t.plsLogin)));
      return;
    }

    await _cartController.addBogoDeal(user.id, _promoItemId!, "Burger");

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.bogoDeal)),
      );
    }
  }
}