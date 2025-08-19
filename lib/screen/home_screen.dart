import 'package:flutter/material.dart';
import 'package:panda_biru/screen/list_shop_screen.dart';
import 'package:panda_biru/services/attendance_api.dart';
import 'package:panda_biru/model/attendance_model.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AttendanceService _attendanceService = AttendanceService();
  bool _loading = false;
  AttendanceModel? _attendance;

  Future<void> _handleAttendance() async {
    setState(() {
      _loading = true;
      _attendance = null;
    });

    try {
      final result = await _attendanceService.postAttendance(
        status: "Present",
        note: "Absen Masuk Kerja",
      );

      setState(() {
        _attendance = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal absen: $e")),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _goToShopList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListShopScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Halo, ${widget.username}!",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _attendance != null ? null : _handleAttendance,
                    child: const Text("Absen Masuk Kerja"),
                  ),
            const SizedBox(height: 20),
            if (_attendance != null) ...[
              Text(
                "Anda sudah absen : ${_attendance!.createdAt}",
                style: const TextStyle(fontSize: 16, color: Colors.green),
              ),
              const SizedBox(height: 8),
              const Text(
                "Silahkan masuk kerja",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _goToShopList,
                child: const Text("Daftar Toko"),
              ),
            ] else ...[
              // Kalau belum absen, tombol daftar toko disabled
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                child: const Text("Daftar Toko"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
