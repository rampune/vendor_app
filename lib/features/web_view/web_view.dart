import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({super.key});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late final WebViewController _controller;
  bool _isLoading = true; // loader ke liye state

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isLoading = true;
            });
            print('Loading: $url');
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
            print('Finished: $url');
          },
          onWebResourceError: (error) {
            setState(() {
              _isLoading = false;
            });
            print('Error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse('https://maxgentechnologies.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),

            // Loader Overlay
            if (_isLoading)
               Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.themeColor,
                  color: AppColors.black,

                ),
              ),

            // Back Button
            Positioned(
              top: 10,
              left: 5,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded, size: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
