import 'package:aklni/core/utils/helper/responsive_ui_helper/size_helper_extensions.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'core/routing/router_generation/router_generation_config.dart';
import 'core/utils/helper/responsive_ui_helper/size_provider.dart';
import 'core/utils/helper/shared_pref_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // تهيئة SharedPreferences
  await SharedPrefHelper.init();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => SizeProvider(
        baseSize: const Size(360, 690),
        width: context.screenWidth,
        height: context.screenHeight,
        child: MaterialApp.router(
          useInheritedMediaQuery: true,
          routerConfig: RouterGenerationConfig.goRouter,
        ),
      ),
    ),
  );
}
