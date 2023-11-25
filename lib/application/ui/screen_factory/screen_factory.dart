import 'package:flutter/material.dart';
import 'package:flutter_fest/application/ui/screens/main_tab/main_tab_screen.dart';
import 'package:flutter_fest/application/ui/screens/main_tab/main_tab_view_model.dart';
import 'package:flutter_fest/application/ui/screens/session_details_widget.dart';
import 'package:provider/provider.dart';

class ScreenFactory {
  Widget makeMainTab() => ChangeNotifierProvider(
        create: (_) => MainTabViewModel(),
        child: const MainTabScreen(),
      );

  Widget makeSessionDetails() => const SessionDetailsScreen();
}
