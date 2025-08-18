import 'package:flutter/material.dart';
import 'package:panda_biru/model/store_model.dart';

class PromoShopScreen extends StatefulWidget {
  final StoreModel store;

  const PromoShopScreen({super.key, required this.store});

  @override
  State<PromoShopScreen> createState() => _PromoShopScreenState();
}

class _PromoShopScreenState extends State<PromoShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Promo - ${widget.store.name}")),
      body: const Center(
        child: Text("Halaman Promo"),
      ),
    );
  }
}
