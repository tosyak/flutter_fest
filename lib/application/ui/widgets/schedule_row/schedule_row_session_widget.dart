// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_fest/application/ui/themes/app_colors.dart';
import 'package:flutter_fest/application/ui/themes/app_text_style.dart';
import 'package:flutter_fest/application/ui/widgets/schedule_row/schedule_row_widget.dart';

import 'package:flutter_fest/resources/resources.dart';

class ScheduleRowSessionWidget extends StatelessWidget {
  final ScheduleRowSessionWidgetConfiguration configuration;
  const ScheduleRowSessionWidget({Key? key, required this.configuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 4, right: 1, bottom: 10),
      margin: const EdgeInsets.only(left: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: configuration._favoriteStyle.widgetBackgroundColor,
        color: configuration._style.widgetBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _SpeakerWidget(configuration: configuration),
              _FavoriteButtonWidget(configuration: configuration),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: _DescriptionWidget(configuration: configuration),
          )
        ],
      ),
    );
  }
}


class _SpeakerWidget extends StatelessWidget {
  final ScheduleRowSessionWidgetConfiguration configuration;

  const _SpeakerWidget({Key? key, required this.configuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double avatarSize = 24;

    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(avatarSize / 2),
            child: Image.network(
              configuration.avatarUrl,
              width: avatarSize,
              height: avatarSize,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(configuration.speakerName,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: AppTextStyle.bookText
                    .copyWith(color: configuration._style.speakerNameColor)),
          )
        ],
      ),
    );
  }
}

class _FavoriteButtonWidget extends StatelessWidget {
  final ScheduleRowSessionWidgetConfiguration configuration;

  const _FavoriteButtonWidget({Key? key, required this.configuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: ImageIcon(
        AssetImage(configuration._favoriteStyle.favoriteButtonIcon),
        size: 24,
        color: configuration._favoriteStyle.favoriteButtonColor,
      ),
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  final ScheduleRowSessionWidgetConfiguration configuration;

  const _DescriptionWidget({Key? key, required this.configuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(configuration.sessionTitle,
        textAlign: TextAlign.start,
        style: AppTextStyle.steinbeckNormalText.copyWith(
          color: configuration._style.sessionTitleColor,
        ));
  }
}

class _ScheduleRowSessionWidgetConfigurationProgressStyle {
  final Color widgetBackground;
  final Color speakerNameColor;
  final Color sessionTitleColor;
  const _ScheduleRowSessionWidgetConfigurationProgressStyle({
    required this.widgetBackground,
    required this.speakerNameColor,
    required this.sessionTitleColor,
  });
}

class _ScheduleRowSessionWidgetConfigurationFavoriteStyle {
  final String favoriteButtonIcon;
  final Color favoriteButtonColor;
  final Gradient? widgetBackgroundColor;
  const _ScheduleRowSessionWidgetConfigurationFavoriteStyle({
    required this.favoriteButtonIcon,
    required this.favoriteButtonColor,
    this.widgetBackgroundColor,
  });
}

class ScheduleRowSessionWidgetConfiguration {
  final String avatarUrl;
  final String speakerName;
  final String sessionTitle;
  final bool isFavorite;
  final ScheduleRowWidgetConfigurationProgressStatus progressStatus;

  _ScheduleRowSessionWidgetConfigurationProgressStyle get _style {
    switch (progressStatus) {
      case ScheduleRowWidgetConfigurationProgressStatus.upcoming:
      case ScheduleRowWidgetConfigurationProgressStatus.current:
        return upComingStyle;
      case ScheduleRowWidgetConfigurationProgressStatus.past:
        return pastStyle;
    }
  }

  _ScheduleRowSessionWidgetConfigurationFavoriteStyle get _favoriteStyle =>
      isFavorite ? isFavoriteStyle : isNotFavoriteStyle;

  const ScheduleRowSessionWidgetConfiguration({
    required this.avatarUrl,
    required this.speakerName,
    required this.sessionTitle,
    required this.isFavorite,
    required this.progressStatus,
  });

  static const upComingStyle =
      _ScheduleRowSessionWidgetConfigurationProgressStyle(
          widgetBackground: AppColors.darkSecondary,
          speakerNameColor: AppColors.darkText,
          sessionTitleColor: AppColors.whiteWithOpacity88);

  static const pastStyle = _ScheduleRowSessionWidgetConfigurationProgressStyle(
    widgetBackground: Colors.transparent,
    speakerNameColor: AppColors.darkTextWithOpacity48,
    sessionTitleColor: AppColors.darkText,
  );

  static const isFavoriteStyle =
      _ScheduleRowSessionWidgetConfigurationFavoriteStyle(
    favoriteButtonIcon: AppImages.bookmarkFull,
    favoriteButtonColor: AppColors.green,
    widgetBackgroundColor: RadialGradient(
      colors: [
        AppColors.green,
        Colors.transparent,
      ],
      center: Alignment(6, -7),
      radius: 14,
    ),
  );

  static const isNotFavoriteStyle =
      _ScheduleRowSessionWidgetConfigurationFavoriteStyle(
    favoriteButtonIcon: AppImages.bookmark,
    favoriteButtonColor: AppColors.darkText,
  );
}
