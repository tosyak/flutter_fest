import 'package:flutter/material.dart';
import 'package:flutter_fest/application/ui/themes/app_colors.dart';
import 'package:flutter_fest/application/ui/themes/app_text_style.dart';
import 'package:flutter_fest/resources/resources.dart';

class SessionDetailsScreen extends StatefulWidget {
  const SessionDetailsScreen({super.key});

  @override
  State<SessionDetailsScreen> createState() => _SessionDetailsScreenState();
}

class _SessionDetailsScreenState extends State<SessionDetailsScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: const _AddToFavorite(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Stack(children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: EasterEggWidget(
                scrollController: _scrollController,
              ),
            ),
            ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              controller: _scrollController,
              padding: EdgeInsets.zero,
              children: const [
                _HeaderWidget(),
                _SessionTitleWidget(),
                _SessionDescWidget(),
                _ScheduleInfoWidget(),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class EasterEggWidget extends StatefulWidget {
  final ScrollController scrollController;
  const EasterEggWidget({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<EasterEggWidget> createState() => _EasterEggWidgetState();
}

class _EasterEggWidgetState extends State<EasterEggWidget> {
  late ScrollController _scrollController;
  var _easterEggScale = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController;
    _scrollController.addListener(_onChangeScrollOffset);
  }

  @override
  void didUpdateWidget(covariant EasterEggWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.scrollController, widget.scrollController)) {
      _scrollController.removeListener(_onChangeScrollOffset);
      _scrollController = widget.scrollController;
      _scrollController.addListener(_onChangeScrollOffset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: _easterEggScale, child: Image.asset(AppImages.easterEggLarge));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onChangeScrollOffset);
    super.dispose();
  }

  void _onChangeScrollOffset() {
    var offset =
        _scrollController.offset - _scrollController.position.maxScrollExtent;
    setState(() {
      _easterEggScale = offset > 0 ? offset / 250 : offset = 0;
    });
  }
}

class _AddToFavoriteConfiguration {
  final String text;
  final String icon;
  final Color color;
  final Color? backgroundColor;
  final LinearGradient? backgroundGradient;

  static const isFavorite = _AddToFavoriteConfiguration(
    text: 'В программе',
    icon: AppImages.bookmarkFull,
    color: AppColors.green,
    backgroundColor: AppColors.darkSecondary,
    backgroundGradient: null,
  );

  static const isNotFavorite = _AddToFavoriteConfiguration(
    text: 'В мою программу',
    icon: AppImages.bookmark,
    color: AppColors.whiteWithOpacity88,
    backgroundColor: null,
    backgroundGradient: LinearGradient(
      begin: Alignment(-1.5, 0.0),
      end: Alignment(1.5, 0.0),
      colors: <Color>[
        AppColors.green,
        AppColors.blue,
      ],
    ),
  );

  const _AddToFavoriteConfiguration({
    required this.text,
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.backgroundGradient,
  });
}

class _AddToFavorite extends StatelessWidget {
  final isFavorite = false;
  const _AddToFavorite({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12.0);
    final configuration = isFavorite
        ? _AddToFavoriteConfiguration.isFavorite
        : _AddToFavoriteConfiguration.isNotFavorite;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          elevation: MaterialStateProperty.all(0),
          minimumSize: MaterialStateProperty.all(Size.zero),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: borderRadius)),
        ),
        onPressed: () {},
        child: Ink(
          height: 48,
          decoration: BoxDecoration(
            gradient: configuration.backgroundGradient,
            color: configuration.backgroundColor,
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageIcon(
                  AssetImage(configuration.icon),
                  color: configuration.color,
                ),
                const SizedBox(width: 16),
                Text(configuration.text, style: AppTextStyle.button),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: Image.asset(
            AppImages.speakerBackground,
            fit: BoxFit.fill,
          ),
        ),
        const _SpeakerInfoWidget(),
      ],
    );
  }
}

class _SpeakerInfoWidget extends StatelessWidget {
  const _SpeakerInfoWidget();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 375 / 312,
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 124),
              Flexible(
                flex: 56,
                child: Text(
                  'Alexey\nChulpin',
                  style: AppTextStyle.speakerName.copyWith(
                    color: AppColors.whiteWithOpacity88,
                  ),
                ),
              ),
              const Spacer(flex: 24),
              Flexible(
                flex: 40,
                child: Text(
                  'Lead\ndeveloper MTS',
                  style: AppTextStyle.bookTextItalic.copyWith(
                    color: AppColors.whiteWithOpacity88.withOpacity(0.6),
                  ),
                ),
              ),
              const Spacer(flex: 68)
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FractionallySizedBox(
              widthFactor: 208 / 375,
              child: Image.asset(
                AppImages.photoMock,
                fit: BoxFit.fill,
              )),
        )
      ]),
    );
  }
}

class _SessionTitleWidget extends StatelessWidget {
  const _SessionTitleWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 32, right: 20),
      child: Text(
        'Субьективность в оценке дизайна',
        style: AppTextStyle.steinbeckText.copyWith(
          color: AppColors.whiteWithOpacity88,
        ),
      ),
    );
  }
}

class _SessionDescWidget extends StatelessWidget {
  const _SessionDescWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 16, right: 20),
      child: Text(
        'Текст описание краткое лекции. Что будет, раскрытие темы. Думаю, что на три или четыре строки. текста нет, так что пишу, что думаю бла бла бла...',
        style: AppTextStyle.bookText.copyWith(
          color: AppColors.whiteWithOpacity88,
        ),
      ),
    );
  }
}

class _ScheduleInfoWidget extends StatelessWidget {
  const _ScheduleInfoWidget();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20.0, top: 24),
      child: Row(
        children: [
          _ScheduleInfoElementWidget(
            title: 'Старт',
            info: '8:00',
          ),
          SizedBox(width: 20),
          _ScheduleInfoElementWidget(
            title: 'Секция',
            info: '№ 1',
          ),
        ],
      ),
    );
  }
}

class _ScheduleInfoElementWidget extends StatelessWidget {
  final String title;
  final String info;
  const _ScheduleInfoElementWidget({
    Key? key,
    required this.title,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 60,
      decoration: BoxDecoration(
          color: AppColors.darkSecondary,
          borderRadius: BorderRadius.circular(16)),
      child: GradientBorderContainer(
        radius: 16,
        borderWidth: 2,
        gradient: const RadialGradient(
          center: Alignment(0.3, -1.3),
          radius: 1,
          colors: [
            Color(0xff50AF64),
            Color(0xff3d734d),
            Color(0xff3d734d),
            // Color(0xff0B77C5),
            Color(0xff206d82),
          ],
          stops: [0.35, 0.59, 0.74, 0.91],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12, top: 12, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title,
                  style: AppTextStyle.snackText.copyWith(
                    color: AppColors.darkText,
                  )),
              Text(info,
                  style: AppTextStyle.timeText.copyWith(
                    color: AppColors.whiteWithOpacity88,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientBorderContainer extends StatelessWidget {
  final double radius;
  final double borderWidth;
  final Gradient gradient;
  final Widget child;

  const GradientBorderContainer({
    Key? key,
    required this.radius,
    required this.borderWidth,
    required this.gradient,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GradientPainter(
        borderWidth: borderWidth,
        radius: radius,
        gradient: gradient,
      ),
      child: child,
    );
  }
}

class _GradientPainter extends CustomPainter {
  final double radius;
  final double borderWidth;
  final Gradient gradient;

  _GradientPainter({
    required this.borderWidth,
    required this.radius,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final outerRect = Offset.zero & size;
    final outerRRect = RRect.fromRectAndRadius(
      outerRect,
      Radius.circular(radius),
    );

    final innerRect = Rect.fromLTWH(
      borderWidth,
      borderWidth,
      size.width - borderWidth * 2,
      size.height - borderWidth * 2,
    );
    final innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - borderWidth));

    final paint = Paint()..shader = gradient.createShader(outerRect);

    final outerPath = Path()..addRRect(outerRRect);
    final innerPath = Path()..addRRect(innerRRect);
    final path = Path.combine(PathOperation.difference, outerPath, innerPath);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
