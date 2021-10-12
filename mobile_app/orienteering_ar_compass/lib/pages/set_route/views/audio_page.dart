import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/main_button.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_wrapper.dart';

// ignore: must_be_immutable
class AudioPage extends StatefulWidget {
  var setSound;
  var name;

  AudioPage(this.name, this.setSound);

  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  String audioName = "";
  String path = "";
  bool _isPlaying = false;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    if (widget.name != null) {
      audioName = (widget.name.split("/") as List).last;
      path = widget.name;
    }
  }

  playAudioFromLocalStorage(path) async {
    int response = await audioPlayer.play(path, isLocal: true);
    if (response == 1) {
      // success

    } else {
      print('Some error occured in playing from storage!');
    }
  }

  pauseAudio() async {
    int response = await audioPlayer.pause();
    if (response == 1) {
      // success

    } else {
      print('Some error occured in pausing');
    }
  }

  stopAudio() async {
    int response = await audioPlayer.stop();
    if (response == 1) {
      // success

    } else {
      print('Some error occured in stopping');
    }
  }

  resumeAudio() async {
    int response = 0;
    try {
      response = await audioPlayer.resume();
    } catch (e) {
      playAudioFromLocalStorage(path);
    }
    if (response == 1) {
      // success

    } else {
      print('Some error occured in resuming');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      header: Header(
        middleWidget: Text(
          "Audio file".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
      ),
      children: [
        SizedBox(
          height: 40.0,
        ),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              InkWell(
                onTap: () async {
                  var _path =
                      await FilePicker.platform.pickFiles(type: FileType.audio);
                  try {
                    setState(() {
                      audioName = _path!.files[0].name;
                      path = _path.files[0].path;
                      widget.setSound(path);
                    });
                  } catch (e) {
                    setState(() {
                      audioName = "";
                      widget.setSound(audioName);
                    });
                    return;
                  }
                },
                child: SvgPicture.asset(
                  "assets/icons/audio_doted_border.svg",
                ),
              ),
              audioName.length == 0
                  ? Column(
                      children: [
                        SvgPicture.asset("assets/icons/voice_icon.svg"),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Add audio file".tr,
                          style: MAIN_TEXT_STYLE_BLACK.copyWith(
                              color: LIGHT_GRAY_TEXT),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                if (_isPlaying == true) {
                                  pauseAudio();
                                  setState(() {
                                    _isPlaying = false;
                                  });
                                } else {
                                  resumeAudio();
                                  setState(() {
                                    _isPlaying = true;
                                  });
                                }
                              },
                              child: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                color: DARK_BROWN,
                              ),
                            ),
                            SizedBox(
                              width: 40.0,
                            ),
                            InkWell(
                              onTap: () {
                                stopAudio();
                                setState(() {
                                  _isPlaying = false;
                                });
                              },
                              child: Icon(
                                Icons.stop,
                                color: DARK_BROWN,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: Get.width / 2,
                          child: Text(
                            audioName,
                            overflow: TextOverflow.ellipsis,
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                color: DARK_BROWN),
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        audioName.length == 0
            ? Container()
            : MainButton(
                text: "Remove sound",
                onPressed: () {
                  setState(() {
                    audioName = "";
                    widget.setSound(audioName);
                  });
                },
                isActive: true,
              ),
      ],
    );
  }
}
