import 'package:flutter/material.dart';
import 'package:panda_biru/model/product_shop_model.dart';
import 'package:panda_biru/model/store_model.dart';
import 'package:panda_biru/screen/detail_shop_Screen.dart';
import 'package:panda_biru/services/product_shop_api.dart';

class ProductShopScreen extends StatefulWidget {
  final StoreModel store;

  const ProductShopScreen({super.key, required this.store});

  @override
  State<ProductShopScreen> createState() => _ProductShopScreenState();
}

class _ProductShopScreenState extends State<ProductShopScreen> {
  late int storeId;
  final ProductService _productService = ProductService();

  // Dummy produk, bisa juga diambil dari API lain kalau ada
  final List<ProductModel> products = [
    ProductModel(product: "Keripik Kentang Xie-xie 250mL", barcode: "1234567890123"),
    ProductModel(product: "Biskuit Kelapa Ni-hao 100mL", barcode: "2345678901234"),
    ProductModel(product: "Coklat Kacang Peng-you 50mL", barcode: "3456789012345"),
  ];

  @override
  void initState() {
    super.initState();
    storeId = widget.store.id;
  }

  Future<void> _submitReport() async {
  try {
    final success = await _productService.submitProductReport(storeId, products);
    if (success) {
      // Tampilkan snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Laporan produk berhasil dikirim!")),
      );

      // Arahkan ke DetailShopScreen, sambil mengganti halaman saat ini
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => DetailShopScreen(store: widget.store),
          ),
        );
      });
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Toko")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.store.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Kode Toko: ${widget.store.code}"),
            Text("Alamat: ${widget.store.address}"),
            const Divider(height: 30),

            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return CheckboxListTile(
                    title: Text(product.product),
                    subtitle: Text("Barcode: ${product.barcode}"),
                    value: product.available,
                    onChanged: (value) {
                      setState(() {
                        product.available = value ?? false;
                      });
                    },
                  );
                },
              ),
            ),

            ElevatedButton.icon(
              onPressed: _submitReport,
              icon: const Icon(Icons.send),
              label: const Text("Kirim Laporan"),
            ),
          ],
        ),
      ),
    );
  }
}
