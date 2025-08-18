import 'package:flutter/material.dart';
import 'package:panda_biru/model/store_model.dart';
import 'package:panda_biru/model/promo_shop_model.dart';
import 'package:panda_biru/services/promo_api.dart';
import 'package:panda_biru/screen/list_shop_screen.dart';

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
          title: const Text("Tambah Promo"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Pilihan produk pakai RadioListTile
                Column(
                  children: productOptions.map((product) {
                    return RadioListTile<String>(
                      title: Text(product),
                      value: product,
                      groupValue: _selectedProduct,
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
                  decoration: const InputDecoration(
                    labelText: "Harga Normal",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _promoPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Harga Promo",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
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
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Promo - ${widget.store.name}")),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _showAddPromoDialog,
          icon: const Icon(Icons.add),
          label: const Text("Add Promo"),
        ),
      ),
    );
  }
}
