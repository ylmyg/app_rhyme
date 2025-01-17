import 'dart:io';

import 'package:app_rhyme/src/rust/api/mirror.dart';
import 'package:app_rhyme/types/music.dart';
import 'package:app_rhyme/util/helper.dart';
import 'package:app_rhyme/util/audio_controller.dart';
import 'package:app_rhyme/util/pull_down_selection.dart';
import 'package:app_rhyme/util/time_parse.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:pull_down_button/pull_down_button.dart';

class QualityTime extends StatefulWidget {
  final double padding;
  final double fontHeight;
  const QualityTime({super.key, this.padding = 20.0, required this.fontHeight});

  @override
  State<StatefulWidget> createState() => QualityTimeState();
}

class QualityTimeState extends State<QualityTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: widget.padding, right: widget.padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => Text(
                formatDuration(
                    globalAudioUiController.position.value.inSeconds),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: CupertinoColors.systemGrey6,
                  fontWeight: FontWeight.w300,
                  fontSize: widget.fontHeight,
                ),
              )),
          // 音质信息按钮
          GestureDetector(
            onTapDown: (details) {
              List<Quality>? qualityOptions =
                  globalAudioHandler.playingMusic.value?.info.qualities;
              if (qualityOptions != null && qualityOptions.isNotEmpty) {
                showPullDownMenu(
                    context: context,
                    items: qualitySelectPullDown(context, qualityOptions,
                        (selectQuality) async {
                      var playingMusic = globalAudioHandler.playingMusic.value;
                      if (playingMusic != null) {
                        var displayData = DisplayMusic(playingMusic.ref,
                            info_: playingMusic.info);
                        var newPlayMusic =
                            await display2PlayMusic(displayData, selectQuality);
                        if (newPlayMusic == null) return;
                        await globalAudioHandler
                            .replacePlayingMusic(newPlayMusic);
                      }
                    }),
                    position: details.globalPosition & Size.zero);
              }
            },
            child: Obx(() {
              return GlassContainer(
                  shadowColor: Platform.isIOS
                      ? CupertinoColors.black.withOpacity(0.1)
                      : CupertinoColors.black.withOpacity(0.2),
                  shadowStrength: Platform.isIOS ? 3 : 8,
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, top: 2, bottom: 2),
                    child: Text(
                      playingMusicQualityShort,
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: widget.fontHeight,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ));
            }),
          ),
          Obx(() => Text(
                formatDuration(
                    globalAudioUiController.duration.value.inSeconds),
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: CupertinoColors.systemGrey6,
                  fontWeight: FontWeight.w300,
                  fontSize: widget.fontHeight,
                ),
              )),
        ],
      ),
    );
  }
}
