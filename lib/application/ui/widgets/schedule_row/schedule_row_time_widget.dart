// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_fest/application/ui/themes/app_colors.dart';
import 'package:flutter_fest/application/ui/themes/app_text_style.dart';
import 'package:flutter_fest/application/ui/widgets/schedule_row/schedule_row_widget.dart';

class ScheduleRowTimeWidget extends StatelessWidget {
  final ScheduleRowTimeWidgetConfiguration configuration;

  const ScheduleRowTimeWidget({
    Key? key,
    required this.configuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                configuration.startTime,
                style: AppTextStyle.bookTextSmall
                    .copyWith(color: configuration._style.startColor),
              ),
              const Spacer(),
              Text(
                configuration.endTime,
                style: AppTextStyle.bookTextSmall
                    .copyWith(color: configuration._style.endColor),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Expanded(
                  child: _DividerWidget(
                color: configuration._style.startColor,
                position: _DividerWidgetPosition.top,
              )),
              Expanded(
                  child: _DividerWidget(
                color: configuration._style.endColor,
                position: _DividerWidgetPosition.bottom,
              )),
            ],
          )

         
        ],
      ),
    );
  }
}

enum _DividerWidgetPosition { top, bottom }

class _DividerWidget extends StatelessWidget {
  final Color color;
  final _DividerWidgetPosition position;

  const _DividerWidget({
    Key? key,
    required this.color,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(1.0);
    final borderRadius = position == _DividerWidgetPosition.top
        ? const BorderRadius.only(topLeft: radius, topRight: radius)
        : const BorderRadius.only(bottomLeft: radius, bottomRight: radius);
    return Container(
      width: 2,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: color,
      ),
    );
  }
}

class _ScheduleRowTimeWidgetConfigurationProgressStyle {
  final Color startColor;
  final Color endColor;

  const _ScheduleRowTimeWidgetConfigurationProgressStyle({
    required this.startColor,
    required this.endColor,
  });
}

class ScheduleRowTimeWidgetConfiguration {
  final String startTime;
  final String endTime;
  final ScheduleRowWidgetConfigurationProgressStatus progressStatus;

  _ScheduleRowTimeWidgetConfigurationProgressStyle get _style {
    switch (progressStatus) {
      case ScheduleRowWidgetConfigurationProgressStatus.past:
        return pastStyle;
      case ScheduleRowWidgetConfigurationProgressStatus.current:
        return inProgressStyle;
      case ScheduleRowWidgetConfigurationProgressStatus.upcoming:
        return upComingStyle;
    }
  }

  const ScheduleRowTimeWidgetConfiguration({
    required this.startTime,
    required this.endTime,
    required this.progressStatus,
  });

  static const upComingStyle = _ScheduleRowTimeWidgetConfigurationProgressStyle(
    startColor: AppColors.whiteWithOpacity72,
    endColor: AppColors.whiteWithOpacity72,
  );

  static const inProgressStyle =
      _ScheduleRowTimeWidgetConfigurationProgressStyle(
    startColor: AppColors.darkTextWithOpacity72,
    endColor: AppColors.greenWithOpacity72,
  );

  static const pastStyle = _ScheduleRowTimeWidgetConfigurationProgressStyle(
    startColor: AppColors.darkTextWithOpacity72,
    endColor: AppColors.darkTextWithOpacity72,
  );
}
