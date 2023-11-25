// // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_fest/application/ui/screens/favorite_screen.dart';
import 'package:flutter_fest/application/ui/screens/main_tab/main_tab_view_model.dart';
import 'package:flutter_fest/application/ui/screens/main_tab/shedule_widget.dart';
import 'package:flutter_fest/application/ui/widgets/google_maps/google_maps_widget.dart';
import 'package:flutter_fest/resources/resources.dart';
import 'package:provider/provider.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({Key? key}) : super(key: key);

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _BodyWidget(),
      bottomNavigationBar: _NavBarWidget(),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTabIndex =
        context.select((MainTabViewModel vm) => vm.currentTabIndex);
    return IndexedStack(
      index: currentTabIndex,
      children: const [
        Center(
          child: ScheduleWidget(),
        ),
        Center(
          child: FavoriteScreen(),
        ),
        Center(
          child: GoogleMaps(),
        )
      ],
    );
  }
}

class _NavBarWidget extends StatelessWidget {
  const _NavBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainTabViewModel>();
    final currentIndex =
        context.select((MainTabViewModel vm) => vm.currentTabIndex);

    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      onTap: model.setCurrentTabIndex,
      items: const [
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(AppImages.tabbarCalendar),
          ),
          label: '123',
          tooltip: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(AppImages.tabbarBookmark),
          ),
          label: '',
          tooltip: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(AppImages.tabbarPoint),
          ),
          label: '',
          tooltip: '',
        ),
      ],
    );
  }
}
