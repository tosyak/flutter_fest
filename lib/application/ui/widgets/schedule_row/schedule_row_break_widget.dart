// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_fest/application/ui/themes/app_colors.dart';
import 'package:flutter_fest/application/ui/themes/app_text_style.dart';

class ScheduleRowBreakWidget extends StatelessWidget {
  const ScheduleRowBreakWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
            child: _BreakDecoratorWidget(
          reversed: true,
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            'ПЕРЕРЫВ',
            style: AppTextStyle.breakTimeSMall
                .copyWith(color: AppColors.whiteWithOpacity88),
          ),
        ),
        const Expanded(
            child: _BreakDecoratorWidget(
          reversed: false,
        )),
      ],
    );
  }
}

class _BreakDecoratorWidget extends StatelessWidget {
  final bool reversed;
  const _BreakDecoratorWidget({
    Key? key,
    required this.reversed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 7),
      painter: _BreakDecoratorPainter(reversed),
    );
  }
}

class _BreakDecoratorPainter extends CustomPainter {
  final bool reversed;
  const _BreakDecoratorPainter(this.reversed);

  @override
  void paint(Canvas canvas, Size size) {
    const spaceWidth = 6.96;
    const itemWIdth = 2.96;
    const itemOffset = 7.13;

    final paint = Paint()
      ..color = AppColors.darkText
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final itemsCount = (size.width / (itemOffset).floor() + 1);
    final margin = reversed ? size.width - (itemsCount * itemOffset) : 0;
    for (var i = 0; i < itemsCount; i++) {
      final xOffset = spaceWidth * i + margin;
      final start = Offset(xOffset + itemWIdth, 0);
      final end = Offset(xOffset, size.height);

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BreakDecoratorPainter oldDelegate) {
    return oldDelegate.reversed != reversed;
  }
}
