import 'package:flutter/material.dart';
import 'package:panda_biru/model/store_model.dart';
import 'package:panda_biru/model/promo_shop_model.dart';
import 'package:panda_biru/services/promo_api.dart';
import 'package:panda_biru/screen/list_shop_screen.dart';
import 'package:panda_biru/theme/theme_color.dart';
import 'package:panda_biru/theme/theme_text_style.dart';

class PromoShopScreen extends StatefulWidget {
  final StoreModel store;

  const PromoShopScreen({super.key, required this.store});

  @override
  State<PromoShopScreen> createState() => _PromoShopScreenState();
}

class _PromoShopScreenState extends State<PromoShopScreen> {
  final PromoService _promoService = PromoService();

  String? _selectedProduct;
  final TextEditingController _normalPriceController = TextEditingController();
  final TextEditingController _promoPriceController = TextEditingController();

  final List<String> productOptions = [
    "Keripik Kentang Xie-xie 250mL",
    "Biskuit Kelapa Ni-hao 100mL",
    "Coklat Kacang Peng-you 50mL",
  ];

  Future<void> _showAddPromoDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ThemeColor().whiteColor,
          title: Text("Tambah Promo", style:ThemeTextStyle().popupPromo),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Pilihan produk pakai RadioListTile
                Column(
  children: productOptions.map((product) {
    return RadioListTile<String>(
      title: Text(product, style: ThemeTextStyle().promoShop),
      value: product,
      groupValue: _selectedProduct,
      activeColor: ThemeColor().blueColor, // warna ketika dipilih
      onChanged: (value) {
        setState(() {
          _selectedProduct = value;
        });
        Navigator.pop(context); // tutup dialog dulu
        _showAddPromoDialog(); // buka ulang biar refresh radio
      },
    );
  }).toList(),
),

                const SizedBox(height: 10),

                TextField(
                  controller: _normalPriceController,
                  keyboardType: TextInputType.number,
                    decoration: InputDecoration(
    labelText: "Harga Normal",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: ThemeColor().blueColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: ThemeColor().blueColor),
    ),
  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _promoPriceController,
                  keyboardType: TextInputType.number,
                   decoration: InputDecoration(
    labelText: "Harga Promo",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: ThemeColor().blueColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: ThemeColor().blueColor),
    ),
    )
                ),
              ],
            ),
          ),
          actions: [
  TextButton(
    onPressed: () => Navigator.pop(context),
    child: Text("Batal",style: ThemeTextStyle().buttonPromo2),
  ),
  ElevatedButton(
    onPressed: () async {
      if (_selectedProduct == null ||
          _normalPriceController.text.isEmpty ||
          _promoPriceController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Lengkapi semua field")),
        );
        return;
      }

      final promo = PromoModel(
        product: _selectedProduct!,
        normalPrice: int.parse(_normalPriceController.text),
        promoPrice: int.parse(_promoPriceController.text),
      );

      final success = await _promoService
          .submitPromoReport(widget.store.id, [promo]);

      if (success && mounted) {
        Navigator.pop(context); // tutup dialog
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ListShopScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal submit promo")),
        );
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: ThemeColor().blueColor, // warna button
      foregroundColor: Colors.white,            // warna teks
      minimumSize: const Size(80, 40),          // ukuran tombol
    ),
    child: Text("Submit", style: ThemeTextStyle().buttonPromo,),
  ),
],

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text("Promo Toko",
                  style: ThemeTextStyle().appBar,
                ),
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
      // Informasi toko
      Text(widget.store.name, style: ThemeTextStyle().storeName),
      const SizedBox(height: 8),
      Text("Kode : ${widget.store.code}", style: ThemeTextStyle().storeDetail),
      Text("Alamat: ${widget.store.address}", style: ThemeTextStyle().storeDetail),
      const Divider(height: 30),

      const SizedBox(height: 20),

      // Tombol Add Promo di bawah
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _showAddPromoDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeColor().blueColor,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(50),
          ),
          child: Text("Add Promo", style: ThemeTextStyle().attendance),
        ),
      ),
    ],
  ),
),


    );
  }
}
