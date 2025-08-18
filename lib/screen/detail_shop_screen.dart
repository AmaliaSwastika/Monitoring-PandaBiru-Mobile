import 'package:flutter/material.dart';
import 'package:panda_biru/model/store_model.dart';
import 'package:panda_biru/screen/product_shop_screen.dart';
import 'package:panda_biru/screen/promo_shop_screen.dart';

class DetailShopScreen extends StatefulWidget {
  final StoreModel store;

  const DetailShopScreen({super.key, required this.store});

  @override
  State<DetailShopScreen> createState() => _DetailShopScreenState();
}

class _DetailShopScreenState extends State<DetailShopScreen> {
  late int storeId;

  @override
  void initState() {
    super.initState();
    // Simpan store_id dari store yang dikirim
    storeId = widget.store.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.store.name)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.store.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text("Kode Toko: ${widget.store.code}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Alamat: ${widget.store.address}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),

            // Tombol Product
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductShopScreen(store: widget.store),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_bag),
                label: const Text("Product"),
              ),
            ),
            const SizedBox(height: 12),

            // Tombol Promo
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PromoShopScreen(store: widget.store),
                    ),
                  );
                },
                icon: const Icon(Icons.local_offer),
                label: const Text("Promo"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
