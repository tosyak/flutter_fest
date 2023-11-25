import 'package:flutter/material.dart';
import 'package:flutter_fest/application/navigation/main_navigation.dart';
import 'package:flutter_fest/application/ui/themes/app_colors.dart';
import 'package:flutter_fest/application/ui/themes/app_text_style.dart';
import 'package:flutter_fest/application/ui/widgets/schedule_row/schedule_row_session_widget.dart';
import 'package:flutter_fest/application/ui/widgets/schedule_row/schedule_row_time_widget.dart';

enum ScheduleRowWidgetConfigurationProgressStatus {
  upcoming,
  current,
  past,
}

abstract class ScheduleRowWidget extends StatelessWidget {
  const ScheduleRowWidget({Key? key}) : super(key: key);

  factory ScheduleRowWidget.single({Key? key}) =>
      _ScheduleRowSingleSessionWidget(key: key);

  factory ScheduleRowWidget.multi({Key? key}) =>
      _ScheduleRowMultiSessionWidget(key: key);
}

class _ScheduleRowSingleSessionWidget extends ScheduleRowWidget {
  const _ScheduleRowSingleSessionWidget({Key? key}) : super(key: key);

  final progressStatus = ScheduleRowWidgetConfigurationProgressStatus.upcoming;

  final configuration = const ScheduleRowSessionWidgetConfiguration(
      avatarUrl: 'https://placebeard.it/300x300',
      speakerName: 'speaker Name and Surname-Korsakov',
      sessionTitle:
          'Про то как космические корабли бороздят просторы вселенной',
      isFavorite: true,
      progressStatus: ScheduleRowWidgetConfigurationProgressStatus.current);

  final ddd = const ScheduleRowTimeWidgetConfiguration(
      startTime: '9:00',
      endTime: '12:00',
      progressStatus: ScheduleRowWidgetConfigurationProgressStatus.current);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(Screens.sessionDetails),
      splashColor: const Color.fromARGB(81, 0, 189, 19),
      borderRadius: BorderRadius.circular(20),
      child: IntrinsicHeight(
        child: Row(
          children: [
            ScheduleRowTimeWidget(configuration: ddd),
            Expanded(
              child: ScheduleRowSessionWidget(
                configuration: configuration,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleRowMultiSessionWidget extends ScheduleRowWidget {
  _ScheduleRowMultiSessionWidget({Key? key}) : super(key: key);

  final progressStatus = ScheduleRowWidgetConfigurationProgressStatus.upcoming;

  final List<ScheduleRowSessionWidgetConfiguration> configurationList =
      <ScheduleRowSessionWidgetConfiguration>[
    const ScheduleRowSessionWidgetConfiguration(
        avatarUrl: 'https://placebeard.it/300x300',
        speakerName: 'speaker Name and Surname-Korsakov',
        sessionTitle:
            'Про то как космические корабли бороздят просторы вселенной',
        isFavorite: true,
        progressStatus: ScheduleRowWidgetConfigurationProgressStatus.current),
    const ScheduleRowSessionWidgetConfiguration(
        avatarUrl: 'https://placebeard.it/300x300',
        speakerName: 'speaker Name and Surname-Korsakov',
        sessionTitle:
            'Про то как космические корабли бороздят просторы вселенной',
        isFavorite: true,
        progressStatus: ScheduleRowWidgetConfigurationProgressStatus.current),
    const ScheduleRowSessionWidgetConfiguration(
        avatarUrl: 'https://placebeard.it/300x300',
        speakerName: 'speaker Name and Surname-Korsakov',
        sessionTitle:
            'Про то как космические корабли бороздят просторы вселенной',
        isFavorite: true,
        progressStatus: ScheduleRowWidgetConfigurationProgressStatus.current)
  ];

 
  final ddd = const ScheduleRowTimeWidgetConfiguration(
      startTime: '9:00',
      endTime: '12:00',
      progressStatus: ScheduleRowWidgetConfigurationProgressStatus.current);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(Screens.sessionDetails),
      splashColor: const Color.fromARGB(81, 0, 189, 19),
      borderRadius: BorderRadius.circular(20),
      child: IntrinsicHeight(
        child: Row(
        
          children: [
            ScheduleRowTimeWidget(configuration: ddd),
            SizedBox(
              height: 130,
              width: 304,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: configurationList.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 280,
                    height: 150,
                    child: ScheduleRowSessionWidget(
                        configuration: configurationList[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyScrollWidget extends StatelessWidget {
  const MyScrollWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(68.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Text('data  ',
              style: AppTextStyle.steinbeckHeadNormal.copyWith(
                color: AppColors.whiteWithOpacity88,
              ));
        },
      ),
    );
  }
}

