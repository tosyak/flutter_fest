import 'package:flutter/cupertino.dart';
import 'package:flutter_fest/application/ui/themes/app_colors.dart';
import 'package:flutter_fest/application/ui/themes/app_text_style.dart';
import 'package:flutter_fest/application/ui/widgets/schedule_row/schedule_row_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: CustomScrollView(
        // shrinkWrap: true,
        slivers: [
          const _HeaderWidget(),
          const _NotificationWidget(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 20, right: 20),
                  child: ScheduleRowWidget.multi(),
                );
              },
              childCount: 15,
            ),
          )
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 60),
          child: RichText(
            text: TextSpan(
                text: 'Моя',
                style: AppTextStyle.steinbeckHeadItalic.copyWith(
                  color: AppColors.whiteWithOpacity88,
                ),
                children: [
                  TextSpan(
                      text: '\nпрограмма',
                      style: AppTextStyle.steinbeckHeadNormal.copyWith(
                        color: AppColors.whiteWithOpacity88,
                      ))
                ]),
          )
         
          ),
    );
  }
}

class _NotificationWidget extends StatelessWidget {
  const _NotificationWidget();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          top: 28,
          right: 20,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          // height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.darkSecondary,
          ),

          // width: MediaQuery.of(context).size.width - 40,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Напоминать мне о лекциях за 10 минут до начала',
                  style: AppTextStyle.bookText
                      .copyWith(color: AppColors.whiteWithOpacity88),
                ),
              ),
              const _SwitchWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SwitchWidget extends StatefulWidget {
  const _SwitchWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<_SwitchWidget> {
  bool _value = true;
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      activeColor: AppColors.darkText,
      trackColor: AppColors.green,
      thumbColor: AppColors.darkSecondary,
      value: _value,
      onChanged: (newValue) => setState(() => _value = newValue),
    );
  }
}
