import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'mode_orang_tua_page.dart'; // Import halaman Mode Orang Tua

class VerifikasiKodePage extends StatefulWidget {
  const VerifikasiKodePage({Key? key}) : super(key: key);

  @override
  State<VerifikasiKodePage> createState() => _VerifikasiKodePageState();
}

class _VerifikasiKodePageState extends State<VerifikasiKodePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _starController;
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  // State untuk berpindah antara mode "Buat Kode" dan "Konfirmasi" untuk memudahkan testing
  bool _isVerificationMode = false;

  // Konfigurasi warna kosmik Astro.Secure
  static const Color primaryBgColor = Color(
    0xFF2C3E8C,
  ); // Latar belakang luar malam biru
  static const Color accentPurple = Color(0xFFE2CEFF); // Lavender pastel terang
  static const Color darkTextPurple = Color(0xFF3A3C9B); // Teks/Ikon ungu gelap

  @override
  void initState() {
    super.initState();
    // Animasi kelap-kelip bintang latar belakang
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // Otomatis fokus ke input PIN saat halaman dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pinFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _starController.dispose();
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBgColor,
      body: Stack(
        children: [
          // --- 1. Animasi Bintang Latar Belakang Kosmik ---
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _starController,
              builder: (context, child) {
                return CustomPaint(painter: StarPainter(_starController.value));
              },
            ),
          ),

          // --- 2. Input Keyboard Tersembunyi ---
          // Digunakan untuk menangkap input angka asli dari keyboard bawaan HP
          Opacity(
            opacity: 0,
            child: SizedBox(
              height: 1,
              width: 1,
              child: TextField(
                controller: _pinController,
                focusNode: _pinFocusNode,
                keyboardType: TextInputType.number,
                maxLength: 4,
                onChanged: (value) {
                  // Memicu pembangunan ulang widget saat pengguna mengetik agar kotak PIN ter-update
                  setState(() {});
                },
              ),
            ),
          ),

          // --- 3. Konten Utama ---
          SafeArea(
            child: Column(
              children: [
                // --- Bagian Header ---
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10.0),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // Tombol Kembali di Kiri Atas
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              color: accentPurple,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: darkTextPurple,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      // Logo Astro.Secure di Tengah
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/logo.svg',
                            height: 42,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.polyline_rounded,
                                color: Colors.white,
                                size: 42,
                              );
                            },
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Astro.Secure',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // --- Teks Judul Utama ---
                // Menggunakan teks "Verivikasi Kode" sesuai detail typo di gambar referensi
                const Center(
                  child: Text(
                    'Verivikasi Kode',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Garis pembatas tipis di bawah judul
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),

                const SizedBox(height: 60),

                // --- 4. 4 Kotak Input PIN Glassmorphism ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: GestureDetector(
                    onTap: () {
                      // Jika pengguna mengetuk area kotak, munculkan kembali keyboard
                      _pinFocusNode.requestFocus();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return _buildPinBox(index);
                      }),
                    ),
                  ),
                ),

                // Petunjuk interaktif kecil untuk kemudahan pengujian state
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isVerificationMode = !_isVerificationMode;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Ketuk di sini untuk simulasi mode: ${_isVerificationMode ? "Konfirmasi" : "Buat Kode"}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // --- 5. Tombol Utama Dinamis di Bagian Bawah ---
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48.0,
                    vertical: 40.0,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Logika ketika kode disubmit
                        if (_pinController.text.length == 4) {
                          // Tampilkan pesan berhasil
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _isVerificationMode
                                    ? 'Kode Berhasil Dikonfirmasi!'
                                    : 'Kode Baru Berhasil Dibuat!',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );

                          // Navigasi langsung menuju halaman Mode Orang Tua
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ModeOrangTuaPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Silakan masukkan 4 digit kode lengkap!',
                              ),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentPurple,
                        foregroundColor: darkTextPurple,
                        elevation: 4,
                        shadowColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        _isVerificationMode ? 'Konfirmasi' : 'Buat Kode',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Pembuat elemen kotak PIN bergaya Glassmorphic frosted
  Widget _buildPinBox(int index) {
    String pinText = _pinController.text;
    bool isFilled = pinText.length > index;
    String charAt = isFilled ? pinText[index] : "";

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isFilled
                  ? Colors.white.withOpacity(0.6)
                  : Colors.white.withOpacity(0.25),
              width: 1.2,
            ),
          ),
          alignment: Alignment.center,
          child: isFilled
              ? Text(
                  // Menampilkan titik bulat sandi agar aman, atau karakter angka aslinya
                  charAt.isNotEmpty ? "●" : "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Container(
                  // Placeholder titik kecil redup di tengah sesuai gambar saat kosong
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                ),
        ),
      ),
    );
  }
}

// =========================================================================
// WIDGET KHUSUS: StarPainter (Animasi Bintang Kosmik Stellar)
// =========================================================================
class StarPainter extends CustomPainter {
  final double animationValue;
  final Random random = Random(42);

  StarPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.white;

    for (int i = 0; i < 65; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double baseSize = random.nextDouble() * 2.2;

      double opacity = (0.25 + (random.nextDouble() * 0.75)) * animationValue;
      double currentSize =
          baseSize * (0.6 + (random.nextDouble() * 0.4) * animationValue);

      paint.color = Colors.white.withOpacity(opacity.clamp(0.1, 1.0));

      // Gambar bintang bulat kecil
      canvas.drawCircle(
        Offset(x, y),
        currentSize,
        paint..style = PaintingStyle.fill,
      );

      // Gambar pancaran garis cahaya bintang 4-sudut (seperti tanda tambah halus)
      if (i % 6 == 0) {
        double glowSize = currentSize * (2.5 + animationValue * 3.0);
        paint.strokeWidth = 0.4;

        // Garis horizontal
        canvas.drawLine(
          Offset(x - glowSize, y),
          Offset(x + glowSize, y),
          paint,
        );
        // Garis vertikal
        canvas.drawLine(
          Offset(x, y - glowSize),
          Offset(x, y + glowSize),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
