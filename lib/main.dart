import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:reminder_kelompok/features/onboarding/pages/splash_page.dart';

// --- TAMBAHAN: Import file onboarding kamu ---
// Pastikan nama filenya sesuai dengan yang kamu simpan (misal: onboarding_page.dart)

void main() {  
  runApp(const MyApp());
}

// ====================================================================
// INI ADALAH TAMPILAN REMINDER YANG AKAN MUNCUL DI ATAS SOSMED
// ====================================================================
@pragma("vm:entry-point")
void overlayMain() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue.withOpacity(0.95),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_clock, size: 80, color: Colors.white),
                const SizedBox(height: 10),
                const Text(
                  "PENGINGAT WAKTU BERMAIN",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Halo! Waktu Instagram kamu sisa 30 menit lagi ya. Gunakan dengan bijak!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                  ),
                  onPressed: () => FlutterOverlayWindow.closeOverlay(),
                  child: const Text("Oke, Mengerti"),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// ====================================================================
// APLIKASI UTAMA
// ====================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Ganti dari OnBoardingPage ke SplashScreen
    );
  }
}

// --- DashboardPage TETAP SAMA PERSIS ---
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isOverlayGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final status = await FlutterOverlayWindow.isPermissionGranted();
    setState(() {
      _isOverlayGranted = status ?? false;
    });
  }

  Future<void> _requestOverlayPermission() async {
    await FlutterOverlayWindow.requestPermission();
    _checkPermissions();
  }

  void _openAccessibilitySettings() {
    if (Platform.isAndroid) {
      final intent = AndroidIntent(
        action: 'android.settings.ACCESSIBILITY_SETTINGS',
      );
      intent.launch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Pengaturan"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Status Perizinan Sistem",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              color: _isOverlayGranted
                  ? Colors.green.shade50
                  : Colors.red.shade50,
              child: ListTile(
                leading: Icon(
                  _isOverlayGranted ? Icons.check_circle : Icons.warning,
                  color: _isOverlayGranted ? Colors.green : Colors.red,
                ),
                title: const Text("Izin Muncul di Atas Aplikasi Lain"),
                subtitle: Text(
                  _isOverlayGranted ? "Sudah Diizinkan" : "Wajib Diizinkan",
                ),
                trailing: _isOverlayGranted
                    ? null
                    : ElevatedButton(
                        onPressed: _requestOverlayPermission,
                        child: const Text("Beri Izin"),
                      ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.orange.shade50,
              child: const ListTile(
                leading: Icon(
                  Icons.settings_accessibility,
                  color: Colors.orange,
                ),
                title: Text("Izin Deteksi Aplikasi (Aksesibilitas)"),
                subtitle: Text(
                  "Harus diaktifkan manual di Pengaturan HP untuk mendeteksi Sosmed yang dibuka.",
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _openAccessibilitySettings,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text(
                "Buka Pengaturan Aksesibilitas",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  Text(
                    "Cara Uji Coba:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "1. Pastikan kedua izin di atas sudah diberikan.",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "2. Keluar dari aplikasi ini (Ke Home Screen).",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "3. Buka aplikasi Instagram.",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "4. Layar reminder akan otomatis muncul!",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
