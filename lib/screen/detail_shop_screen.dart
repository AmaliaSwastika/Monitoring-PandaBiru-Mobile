import 'package:flutter/material.dart';
import 'package:panda_biru/model/store_model.dart';
import 'package:panda_biru/screen/product_shop_screen.dart';
import 'package:panda_biru/screen/promo_shop_screen.dart';
import 'package:panda_biru/theme/theme_color.dart';
import 'package:panda_biru/theme/theme_text_style.dart';

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
      backgroundColor: ThemeColor().whiteColor,
      appBar: AppBar(
        // title: Text(widget.store.name,
        //           style: ThemeTextStyle().appBar,
        //         ),
        backgroundColor: ThemeColor().blueColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ThemeColor().whiteColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.store.name,
              style:ThemeTextStyle().storeName
            ),
            const SizedBox(height: 12),
            Text("Kode Toko: ${widget.store.code}", style:ThemeTextStyle().storeDetail),
            const SizedBox(height: 8),
            Text("Alamat: ${widget.store.address}", style:ThemeTextStyle().storeDetail),
            const SizedBox(height: 24),

            // Tombol Product
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
    icon: Icon(Icons.shopping_bag, color: ThemeColor().whiteColor),
    label: Text("Product", style:ThemeTextStyle().attendance),
    style: ElevatedButton.styleFrom(
      backgroundColor: ThemeColor().blueColor,
      padding: const EdgeInsets.symmetric(vertical: 16),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
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
    icon: Icon(Icons.local_offer, color: ThemeColor().whiteColor),
    label: Text("Promo", style:ThemeTextStyle().attendance),
    style: ElevatedButton.styleFrom(
      backgroundColor: ThemeColor().blueColor,
      padding: const EdgeInsets.symmetric(vertical: 16),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
),

          ],
        ),
      ),
    );
  }
}
