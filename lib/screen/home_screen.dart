import 'package:flutter/material.dart';
import 'package:panda_biru/screen/list_shop_screen.dart';
import 'package:panda_biru/services/attendance_api.dart';
import 'package:panda_biru/model/attendance_model.dart';
import 'package:panda_biru/theme/theme_color.dart';
import 'package:panda_biru/theme/theme_text_style.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AttendanceAPI _attendanceAPI = AttendanceAPI();
  bool _loading = false;
  AttendanceModel? _attendance;

  Future<void> _handleAttendance() async {
    setState(() {
      _loading = true;
      _attendance = null;
    });

    try {
      final result = await _attendanceAPI.postAttendance(
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
      backgroundColor: ThemeColor().whiteColor,
      appBar: PreferredSize(
  preferredSize: const Size.fromHeight(60.0),
  child: AppBar(
    backgroundColor: ThemeColor().blueColor,
    elevation: 0,
    centerTitle: true,
    title: Text(
      "Attendance",
      style: ThemeTextStyle().appBar,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
    ),
  ),
),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Halo! ${widget.username}",
              style: ThemeTextStyle().welcomeUsername
            ),
            const SizedBox(height: 20),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColor().blueColor,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    onPressed: _attendance != null ? null : _handleAttendance,
                    child: Text(
                      _attendance != null ? "Anda sudah absen" : "Absen Masuk Kerja",
                      style: ThemeTextStyle().attendance,
                    ),
                  ),
            const SizedBox(height: 20),
            if (_attendance != null) ...[
              Text(
                "Anda sudah absen : ${_attendance!.createdAt}",
                style: ThemeTextStyle().attendanceSuccess,
              ),
              const SizedBox(height: 8),
              Text(
                "Silahkan masuk kerja",
                style: ThemeTextStyle().attendanceSuccess2,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColor().blueColor,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: _goToShopList,
                child: Text(
                  "Daftar Toko",
                  style: ThemeTextStyle().attendance,
                ),
              ),
            ] else ...[
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: null,
                child: Text(
                  "Daftar Toko",
                  style: ThemeTextStyle().attendance,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
