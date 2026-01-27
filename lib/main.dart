import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/theme/app_theme.dart';
import 'router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyCollegeFinancesApp(),
    ),
  );
}

class MyCollegeFinancesApp extends StatelessWidget {
  const MyCollegeFinancesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MyCollegeFinances',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: routerProvider,
    );
  }
}
