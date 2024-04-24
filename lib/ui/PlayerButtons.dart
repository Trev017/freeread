import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
//Class where a button widgets are developed.
class PlayerButtons extends StatelessWidget {

  //Class variables
  final AudioPlayer? audioPlayer;

  //Class constructor
  const PlayerButtons({
    super.key,
    this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(),
        //Play the previous track
        StreamBuilder<SequenceState?>(
          stream: audioPlayer!.sequenceStateStream,
          builder: (context, snapshot) {
            return Center(
              child: previousButton(),
            );
          },
        ),
        //Rewind back to the previous fifteen seconds
        StreamBuilder<SequenceState?>(
          stream: audioPlayer!.sequenceStateStream,
          builder: (context, snapshot) {
            return Center(
              child: rewindFifteenButton(),
            );
          },
        ),
        //Plays or pauses the current track
        StreamBuilder<PlayerState?>(
          stream: audioPlayer!.playerStateStream,
          builder: (context, snapshot) {
            final ps = snapshot.data;
            return Center(
              child: playPauseButton(ps!),
            );
          },
        ),
        //Proceed to the next fifteen seconds
        StreamBuilder<SequenceState?>(
          stream: audioPlayer!.sequenceStateStream,
          builder: (context, snapshot) {
            return Center(
              child: forwardFifteenButton(),
            );
          },
        ),
        //Play the next track
        StreamBuilder<SequenceState?>(
          stream: audioPlayer!.sequenceStateStream,
          builder: (context, snapshot) {
            return Center(
              child: nextButton(),
            );
          },
        ),
        const Spacer(),
      ],
    );
  }

  Widget playPauseButton(PlayerState ps) {
    final processState = ps.processingState;
    if (processState == ProcessingState.loading || processState == ProcessingState.buffering) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        height: 40,
        width: 40,
        child: const CircularProgressIndicator(),
      );
    } else if (audioPlayer?.playing != true) {
      return IconButton(
        icon: const Icon(Icons.play_arrow),
        iconSize: 40,
        onPressed: () {
          audioPlayer?.play();
        },
      );
    } else if (processState != ProcessingState.completed) {
      return IconButton(
        icon: const Icon(Icons.pause),
        iconSize: 40,
        onPressed: () {
          audioPlayer?.pause();
        },
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.play_arrow),
        iconSize: 40,
        onPressed: () {
          audioPlayer?.seek(
            Duration.zero,
            index: audioPlayer?.effectiveIndices?.first,
          );
        },
      );
    }
  }

  Widget previousButton() {
    return IconButton(
      icon: const Icon(Icons.fast_rewind),
      iconSize: 40,
      onPressed: () {
        audioPlayer!.hasPrevious ? audioPlayer?.seekToPrevious() : null;
      },
    );
  }

  Widget rewindFifteenButton() {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
            icon: const Icon(Icons.rotate_left),
            iconSize: 40,
            onPressed: () {
              audioPlayer!.seek(Duration(seconds: audioPlayer!.position.inSeconds - 15));
            }
        ),
        const Text("15"),
      ],
    );
  }

  Widget nextButton() {
    return IconButton(
      icon: const Icon(Icons.fast_forward),
      iconSize: 40,
      onPressed: () {
        audioPlayer!.hasNext ? audioPlayer?.seekToNext() : null;
      },
    );
  }

  Widget forwardFifteenButton() {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
            icon: const Icon(Icons.rotate_right),
            iconSize: 40,
            onPressed: () {
              audioPlayer!.seek(Duration(seconds: audioPlayer!.position.inSeconds + 15));
            }
        ),
        const Text("15"),
      ],
    );
  }
}