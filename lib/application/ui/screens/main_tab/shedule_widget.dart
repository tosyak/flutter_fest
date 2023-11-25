// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_fest/application/ui/themes/app_colors.dart';
import 'package:flutter_fest/application/ui/widgets/dialogs/dialog_widget.dart';
import 'package:flutter_fest/application/ui/widgets/schedule_row/schedule_row_break_widget.dart';
import 'package:flutter_fest/application/ui/widgets/schedule_row/schedule_row_widget.dart';
import 'package:flutter_fest/resources/resources.dart';

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({super.key});

  void showOverlay(BuildContext context) {
    final configuration = DialogConfiguration(title: 'Title Title', actions: [
      DialogActionConfiguration('No no', () {
        Navigator.of(context).pop();
      }, true),
      DialogActionConfiguration('Yes', () {
        Navigator.of(context).pop();
      }, false),
    ]);

    DialogWidget.show<void>(context, configuration);
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return DecoratedBox(
      decoration: const BoxDecoration(
         
          ),
      child: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            const _LogoWidget(),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(topInset: topInset),
            ),
          
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == 2) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 16.0, left: 14, right: 14),
                      child:
                          SizedBox(height: 60, child: ScheduleRowBreakWidget()),
                    );
                  }
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 15, right: 15),
                    child: ScheduleRowWidget.single(),
                  );
                },
                childCount: 15,
              ),
             
            )
          ],
        ),
      ),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 204,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(AppImages.scheduleBg),
            ),
            Positioned(
              // top: 84,
              bottom: 0,
              left: 20,
              child: Image.asset(AppImages.scheduleFfLogo),
            ),
            Positioned(
              top: 64,
              right: 20,
              child: Image.asset(AppImages.scheduleSurfLogo),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double _height = 56;
  final double topInset;

  _SliverAppBarDelegate({
    required this.topInset,
  });

  @override
  double get maxExtent => _height + topInset;

  @override
  double get minExtent => _height + topInset;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _SectionButtonsWidget(topInset: topInset);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

class _SectionButtonsWidget extends StatelessWidget {
  final double topInset;

  const _SectionButtonsWidget({
    Key? key,
    required this.topInset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const totalMenuItemCount = 4;
    const menuItemWidth = 2;
    const double middleGradientPoint = menuItemWidth / 2;
    const double endGradientPoint = totalMenuItemCount * menuItemWidth + 1;
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 20, right: 20, top: topInset),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          final currentGradientStartPoint = middleGradientPoint + index * 2;
          final currentGradientEndPoint =
              endGradientPoint - currentGradientStartPoint;

          return Center(
            child: SizedBox(
              height: 36,
             
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  elevation: MaterialStateProperty.all(0),
                  minimumSize: MaterialStateProperty.all(Size.zero),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0))),
                ),
                onPressed: () {},
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-currentGradientStartPoint, 0.0),
                      end: Alignment(currentGradientEndPoint, 0.0),
                      colors: const <Color>[
                        AppColors.green,
                        AppColors.blue,
                      ],
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(child: Text('Секция ${index + 1}')),
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 10,
          );
        },
      ),
    );
  }
}
