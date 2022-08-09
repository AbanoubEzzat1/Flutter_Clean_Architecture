import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_revision2/app/app.dart';
import 'package:flutter_clean_arch_revision2/app/di.dart';
import 'package:flutter_clean_arch_revision2/presentation/resources/language_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale("en", "US"),
        Locale("ar", "SA"),
      ],
      path: ASSET_PATH_LOCALISATIONS,
      child: Phoenix(
        child: MyApp(),
      ),
    ),
  );
}
