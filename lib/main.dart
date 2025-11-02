import 'package:flutter/material.dart';
import 'page/application/application.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(const Application());
}







