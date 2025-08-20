import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key,required this.logoUrl,
    this.title,this.description
  });
final String logoUrl;
final String? title,description;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      
      children: [
Center(
  child: SizedBox(
    
    child: Image.asset(logoUrl),),
)
    ],);
  }
}
