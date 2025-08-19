import 'package:flutter/material.dart';
import 'package:panda_biru/helper/shared_preferences.dart';
import 'package:panda_biru/model/store_model.dart';
import 'package:panda_biru/screen/detail_shop_screen.dart';
import 'package:panda_biru/screen/navbar/navbar.dart';
import 'package:panda_biru/services/store_api.dart';
import 'package:panda_biru/theme/theme_color.dart';
import 'package:panda_biru/theme/theme_text_style.dart';

class ListShopScreen extends StatefulWidget {
  const ListShopScreen({super.key});

  @override
  State<ListShopScreen> createState() => _ListShopScreenState();
}

class _ListShopScreenState extends State<ListShopScreen> {
  final StoreService _storeService = StoreService();
  late Future<List<StoreModel>> _futureStores;

  @override
  void initState() {
    super.initState();
    _futureStores = _storeService.getStores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor().whiteColor,
      appBar: AppBar(
        title: Text(
                  "Daftar Toko",
                  style: ThemeTextStyle().appBar,
                ),
        backgroundColor: ThemeColor().blueColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ThemeColor().whiteColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<StoreModel>>(
              future: _futureStores,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Tidak ada toko tersedia"));
                }

                final stores = snapshot.data!;

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: stores.length,
                  itemBuilder: (context, index) {
                    final store = stores[index];
                   return Card(
  color: ThemeColor().whiteColor,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(
      color: ThemeColor().blueColor, // warna border
      width: 1, // ketebalan border
    ),
  ),
  margin: const EdgeInsets.only(bottom: 12),
  child: ListTile(
    title: Text(
      store.name,
      style: ThemeTextStyle().storeName
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Kode: ${store.code}", style: ThemeTextStyle().storeDetail,),
        Text("Alamat: ${store.address}", style: ThemeTextStyle().storeDetail,),
      ],
    ),
    leading: Icon(Icons.store, color: ThemeColor().blueColor),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailShopScreen(store: store),
        ),
      );
    },
  ),
);

                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColor().blueColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () async {
                  final username = await SharedPrefHelper.getUsername(); // ambil dari shared pref

                  if (!mounted) return; // safety

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NavBar(
                        username: username ?? "Guest", // fallback kalau null
                        initialIndex: 1, // langsung ke Activity tab
                      ),
                    ),
                  );
                },
                child: Text(
                  "Sudah Selesai Monitoring",
                  style: ThemeTextStyle().attendance,),
                ),
              ),
            ),
          
        ],
      ),
    );
  }
}
