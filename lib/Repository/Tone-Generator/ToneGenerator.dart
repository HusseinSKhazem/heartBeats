import 'package:audioplayers/audioplayers.dart';

class ToneGenerator {
  final AudioPlayer audioPlayer = AudioPlayer();

  void playTone(double bpm) async{
    String audioPath = selectAudioFileBasedOnBpm(bpm);
    await audioPlayer.setSource(AssetSource(audioPath)); 
    await audioPlayer.resume(); 
  }
  void stopTone() async{
    await audioPlayer.stop();
  }

 String selectAudioFileBasedOnBpm(double bpm) {
  const lowBpmThreshold = 70;
  const highBpmThreshold = 120;

const lowBpmTone = 'tones/low-bpm-music.mp3';
const midBpmTone = 'tones/mid-bpm-music.mp3';
const highBpmTone = 'tones/high-bpm-music.mp3';


  if (bpm < lowBpmThreshold) {
    return lowBpmTone;
  } else if (bpm >= lowBpmThreshold && bpm < highBpmThreshold) {
    return midBpmTone;
  } else {
    return highBpmTone;
  }
}
}
