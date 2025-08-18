import 'package:flutter/material.dart';
import 'package:panda_biru/helper/shared_preferences.dart';
import 'package:panda_biru/model/store_model.dart';
import 'package:panda_biru/screen/detail_shop_screen.dart';
import 'package:panda_biru/screen/navbar/navbar.dart';
import 'package:panda_biru/services/store_api.dart';
import 'package:panda_biru/screen/activity_screen.dart'; // <-- pastikan import ActivityScreen

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
      appBar: AppBar(title: const Text("Daftar Toko")),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<StoreModel>>(
              future: _futureStores,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(
                          store.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Kode: ${store.code}"),
                            Text("Alamat: ${store.address}"),
                          ],
                        ),
                        leading: const Icon(Icons.store, color: Colors.blue),
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
  child: const Text("Sudah Selesai Monitoring"),
),

            ),
          ),
        ],
      ),
    );
  }
}
