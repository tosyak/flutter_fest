// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_fest/application/ui/themes/app_colors.dart';
import 'package:flutter_fest/application/ui/themes/app_text_style.dart';

class TopNotificationOverlayWidget extends StatefulWidget {
  const TopNotificationOverlayWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TopNotificationOverlayWidget> createState() =>
      TopNotificationOverlayWidgetState();
}

class TopNotificationOverlayWidgetState
    extends State<TopNotificationOverlayWidget> {
  static const _showedOffset = Offset(0, 0);
  static const _hidedOffset = Offset(0, -1);
  var _offset = _hidedOffset;

  Timer? _timer;

  final List<String> _textQueue = <String>[];
  bool get isHidden => _offset == _hidedOffset;
  var _text = '';

  void show(String text) {
    if (!isHidden) {
      _timer?.cancel;
      _timer = null;
      _textQueue.add(text);
      _hideWidget();
    } else {
      _showWidget(text);
    }
  }

  void _showWidget(String text) {
    setState(() {
      _text = text;
      _offset = _showedOffset;
    });
    _timer = Timer(const Duration(seconds: 1), () {
      _timer = null;
      _hideWidget();
    });
  }

  void _hideWidget() {
    setState(() {
      _offset = _hidedOffset;
    });
  }

  void onAnimationEnd() {
    if (_textQueue.isEmpty || !isHidden) {
      return;
    }
    final text = _textQueue.first;
    _textQueue.removeAt(0);
    _showWidget(text);
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedSlide(
        duration: isHidden
            ? const Duration(milliseconds: 50)
            : const Duration(milliseconds: 150),
        offset: _offset,
        onEnd: onAnimationEnd,
        child: Material(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: topPadding),
            color: AppColors.green,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                _text,
                style: AppTextStyle.snackText.copyWith(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
