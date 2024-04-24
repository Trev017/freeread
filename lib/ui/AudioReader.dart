import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:provider/provider.dart';
import 'AudioProvider.dart';
import 'PlayerButtons.dart';
import 'PlaylistBuilder.dart';
//Class where audio of books could be played.
class AudioReader extends StatefulWidget {

  //Class variables
  final String? audioBookTitle;
  final String? audioBookAuthor;
  final String? audioBookChapter;
  final int? audioBookDuration;

  //Class constructor
  const AudioReader({
    super.key,
    this.audioBookTitle,
    this.audioBookAuthor,
    this.audioBookChapter,
    this.audioBookDuration,
  }
  );

  @override
  State<StatefulWidget> createState() => _MyAudioReaderPageState();
}

class _MyAudioReaderPageState extends State<AudioReader> {

  late AudioPlayer audioPlayer;
  double speedValue = 1;
  String textValue = "Current Speed";

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.setAudioSource(
      //Currently utilizing data taken from API and hard-coded for demonstration of audio features.
      ConcatenatingAudioSource(
          children: [
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_00_livy_64kb.mp3"),
              tag: "Book 01 Preface",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_01_livy_64kb.mp3"),
              tag: "Book 01 pt 01",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_02_livy_64kb.mp3"),
              tag: "Book 01 pt 02",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_03_livy_64kb.mp3"),
              tag: "Book 01 pt 03",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_04_livy_64kb.mp3"),
              tag: "Book 01 pt 04",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_05_livy_64kb.mp3"),
              tag: "Book 01 pt 05",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_06_livy_64kb.mp3"),
              tag: "Book 01 pt 06",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_07_livy_64kb.mp3"),
              tag: "Book 01 pt 07",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_08_livy_64kb.mp3"),
              tag: "Book 01 pt 08",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_09_livy_64kb.mp3"),
              tag: "Book 01 pt 09",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_10_livy_64kb.mp3"),
              tag: "Book 02 pt 01",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_11_livy_64kb.mp3"),
              tag: "Book 02 pt 02",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_12_livy_64kb.mp3"),
              tag: "Book 02 pt 03",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_13_livy_64kb.mp3"),
              tag: "Book 02 pt 04",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_14_livy_64kb.mp3"),
              tag: "Book 02 pt 05",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_15_livy_64kb.mp3"),
              tag: "Book 02 pt 06",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_16_livy_64kb.mp3"),
              tag: "Book 02 pt 07",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_17_livy_64kb.mp3"),
              tag: "Book 02 pt 08",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_18_livy_64kb.mp3"),
              tag: "Book 02 pt 09",
            ),
            AudioSource.uri(
                Uri.parse("https://www.archive.org/download/foundation_city_vol1_1001_librivox/foundationofcity01_19_livy_64kb.mp3"),
              tag: "Book 02 pt 10",
            ),
          ]
      ),
    ).catchError((e) {
      print("Error: $e");
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //
      ),
      body: Padding(
        //Builds view for the audio player
        padding: const EdgeInsets.all(20),
        child: Flexible(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(context.watch<AudioProvider>().audioBookTitle ?? "From the Foundation of the City Vol. 01"),
                Expanded(
                  child: PlaylistBuilder(audioPlayer: audioPlayer,),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.bookmark_add_outlined),
                      iconSize: 40,
                      selectedIcon: const Icon(Icons.bookmark_added_sharp),
                      onPressed: () {
                        setState(() {
                          //
                        });
                      },
                    ),
                    const Spacer(),
                    IconButton(
                      //Alert dialog to display the speed configuration option.
                      icon: const Icon(Icons.flash_on_sharp),
                      iconSize: 40,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Change Speed"),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("$textValue: $speedValue"),
                                    StatefulBuilder(
                                        builder: (context, state) {
                                          return Slider(
                                            min: 0,
                                            max: 2,
                                            value: speedValue,
                                            onChanged: (value) {
                                              speedValue = value;
                                              audioPlayer.setSpeed(speedValue);
                                            },
                                          );
                                        }
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'Continue');
                                    },
                                    child: const Text("Continue"),
                                  ),
                                ],
                              );
                            }
                        );
                      },
                    ),
                  ],
                ),
                ProgressBar(progress: Duration.zero, total: Duration(seconds: widget.audioBookDuration ?? 5)),
                PlayerButtons(audioPlayer: audioPlayer,),
              ],
            ),
          ),
        ),
    ),
    resizeToAvoidBottomInset: true,
    );
  }
}
