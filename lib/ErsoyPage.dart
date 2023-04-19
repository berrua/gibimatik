import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ErsoyPage extends StatefulWidget {
  const ErsoyPage({super.key});

  @override
  State<ErsoyPage> createState() => _ErsoyPageState();
}

class _ErsoyPageState extends State<ErsoyPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  AudioCache _audioCache = AudioCache();
  Random _random = Random();
  AudioPlayer? _audioPlayer;
  int? _lastPlayedIndex;

  final List<String> ersoySounds = [
    'ersoy01.mp3',
    'ersoy02.mp3',
    'ersoy03.mp3',
    'ersoy04.mp3',
    'ersoy05.mp3',
    'ersoy06.mp3',
    'ersoy07.mp3',
    'ersoy08.mp3',
  ];

  void _playSound() async {
    if (_audioPlayer != null) {
      // Bir ses çalıyorsa, herhangi bir işlem yapmadan çık
      return;
    }

    int index = _random.nextInt(ersoySounds.length);
    String soundPath = 'sounds/${ersoySounds[index]}';

    _audioPlayer = await _audioCache.play(soundPath);
    print('Ses çalıyor: $soundPath');

    // Animasyonu başlat ve sürekli tekrar et
    _animationController?.repeat(reverse: true);

    // Ses çalma durumunu dinle ve ses durduğunda animasyonu durdur
    _audioPlayer?.onPlayerCompletion.listen((event) {
      _stopSound();
      setState(() {}); // durumu değiştirerek yeniden yapılandırmayı tetikle
    });

    // Durumu değiştirerek yeniden yapılandırmayı tetikleyin
    setState(() {});
  }

  void _stopSound() {
    if (_audioPlayer != null) {
      _audioPlayer!.stop();
      _audioPlayer = null;

      // Animasyonu durdur
      _animationController?.stop(
          canceled: false); // animasyonu tamamla ama tersine oynatma
    }

    // Durumu değiştirerek yeniden yapılandırmayı tetikle
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // Animasyon kontrolörünü oluştur
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    // Animasyon kontrolörünü dispose et
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _stopSound();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "ersoy",
            style: TextStyle(
              fontFamily: 'RubikVinyl',
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xffddb51f),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () {
              if (_audioPlayer != null) {
                _stopSound();
              } else {
                _playSound();
              }
            },
            child: AnimatedBuilder(
              animation: _animationController!,
              builder: (BuildContext context, Widget? child) {
                return Transform.scale(
                  scale: 1 + 0.2 * _animationController!.value,
                  child: Image.asset(
                    'assets/images/ersoy.png',
                    height: 225,
                    width: 175,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
