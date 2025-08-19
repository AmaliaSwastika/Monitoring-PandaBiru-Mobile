import 'package:flutter/material.dart';
import 'package:panda_biru/model/product_shop_model.dart';
import 'package:panda_biru/model/store_model.dart';
import 'package:panda_biru/screen/detail_shop_Screen.dart';
import 'package:panda_biru/services/product_shop_api.dart';
import 'package:panda_biru/theme/theme_color.dart';
import 'package:panda_biru/theme/theme_text_style.dart';

class ProductShopScreen extends StatefulWidget {
  final StoreModel store;

  const ProductShopScreen({super.key, required this.store});

  @override
  State<ProductShopScreen> createState() => _ProductShopScreenState();
}

class _ProductShopScreenState extends State<ProductShopScreen> {
  late int storeId;
  final ProductAPI _productAPI = ProductAPI();
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
      final success = await _productAPI.submitProductReport(storeId, products);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Laporan produk berhasil dikirim!")),
        );
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
      backgroundColor: ThemeColor().whiteColor,
      appBar: AppBar(
        title: Text(
          "Product Toko",
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
            Text(widget.store.name,style:ThemeTextStyle().storeName),
            const SizedBox(height: 8),
            Text("Kode : ${widget.store.code}", style:ThemeTextStyle().storeDetail),
            Text("Alamat: ${widget.store.address}", style:ThemeTextStyle().storeDetail),
            const Divider(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return CheckboxListTile(
                    title: Text(product.product, style:ThemeTextStyle().storeName),
                    subtitle: Text("Barcode: ${product.barcode}", style:ThemeTextStyle().storeDetail),
                    value: product.available,
                    activeColor: ThemeColor().blueColor,
                    onChanged: (value) {
                      setState(() {
                        product.available = value ?? false;
                      });
                    },
                  );
                },
              ),
            ),

           ElevatedButton(
            onPressed: _submitReport,
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColor().blueColor, 
              minimumSize: const Size.fromHeight(50), 
            ),
            child: Text(
              "Submit Laporan",
              style: ThemeTextStyle().attendance
            ),
          ),
          ],
        ),
      ),
    );
  }
}