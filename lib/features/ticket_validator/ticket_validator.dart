import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MyQrReader extends StatefulWidget {
  const MyQrReader({super.key});

  @override
  State<MyQrReader> createState() => _MyQrReaderState();
}

class _MyQrReaderState extends State<MyQrReader>
    with SingleTickerProviderStateMixin {
  final MobileScannerController controller = MobileScannerController(
    facing: CameraFacing.back,
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  late AnimationController _lineController;
  bool _isScanning = true;
  String? _scannedText; // 👈 store scanned result

  @override
  void initState() {
    super.initState();
    _lineController =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    _lineController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) async {
    if (!_isScanning) return;

    final barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final value = barcodes.first.rawValue;
      if (value != null && value.isNotEmpty) {
        setState(() {
          _isScanning = false;
          _scannedText = value;
        });

        // Stop camera & scanner
        await controller.stop();

        // Show Alert Dialog
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("QR Detected"),
              content: Text(value),
              actions: [
                TextButton(
                  onPressed: () {

                    setState(() {
                      _isScanning = true;
                      _scannedText = value;
                    });

                    Navigator.pop(context);},
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text("QR Scanner"),
      ),
      body: Stack(
        children: [
          // Show scanner only while scanning
          if (_isScanning)
            MobileScanner(
              controller: controller,
              onDetect: _onDetect,
            ),

          // Overlay with animated line (hide if scanning stopped)
          if (_isScanning)
            LayoutBuilder(
              builder: (context, constraints) {
                final cutoutSize = constraints.maxWidth * 0.7;
                final top = (constraints.maxHeight - cutoutSize) / 2;
                final left = (constraints.maxWidth - cutoutSize) / 2;
                final rect =
                Rect.fromLTWH(left, top, cutoutSize, cutoutSize);

                return AnimatedBuilder(
                  animation: _lineController,
                  builder: (context, _) {
                    final lineY =
                        rect.top + rect.height * _lineController.value;

                    return CustomPaint(
                      size: Size(constraints.maxWidth, constraints.maxHeight),
                      painter: _ScannerOverlayPainter(
                        cutout: rect,
                        lineY: lineY,
                      ),
                    );
                  },
                );
              },
            ),

          // Show scanned text instead of camera after detection
          if (!_isScanning && _scannedText != null)
            Center(
              child: Text(
                "Scanned QR:\n$_scannedText",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  final Rect cutout;
  final double lineY;

  _ScannerOverlayPainter({required this.cutout, required this.lineY});

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = Colors.black54;

    // Dark background
    final full = Path()..addRect(Offset.zero & size);
    final hole = Path()..addRRect(RRect.fromRectXY(cutout, 16, 16));
    final overlay = Path.combine(PathOperation.difference, full, hole);
    canvas.drawPath(overlay, bgPaint);

    // Border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawRRect(RRect.fromRectXY(cutout, 16, 16), borderPaint);

    // Scan line
    final linePaint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 3;
    canvas.drawLine(
      Offset(cutout.left + 8, lineY),
      Offset(cutout.right - 8, lineY),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScannerOverlayPainter oldDelegate) =>
      oldDelegate.lineY != lineY;
}
