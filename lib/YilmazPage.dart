import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class YilmazPage extends StatefulWidget {
  const YilmazPage({super.key});

  @override
  State<YilmazPage> createState() => _YilmazPageState();
}

class _YilmazPageState extends State<YilmazPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  AudioCache _audioCache = AudioCache();
  Random _random = Random();
  AudioPlayer? _audioPlayer;
  int? _lastPlayedIndex;

  final List<String> yilmazSounds = [
    'yilmaz01.mp3',
    'yilmaz02.mp3',
    'yilmaz03.mp3',
    'yilmaz04.mp3',
    'yilmaz05.mp3',
    'yilmaz06.mp3',
    'yilmaz07.mp3',
    'yilmaz08.mp3',
    'yilmaz09.mp3',
    'yilmaz10.mp3',
    'yilmaz11.mp3',
    'yilmaz12.mp3',
    'yilmaz13.mp3',
    'yilmaz14.mp3',
    'yilmaz15.mp3',
    'yilmaz16.mp3',
    'yilmaz17.mp3',
    'yilmaz18.mp3',
    'yilmaz19.mp3',
    'yilmaz20.mp3',
    'yilmaz21.mp3',
    'yilmaz22.mp3',
    'yilmaz23.mp3',
    'yilmaz24.mp3',
    'yilmaz25.mp3',
    'yilmaz26.mp3',
    'yilmaz27.mp3',
    'yilmaz28.mp3',
    'yilmaz29.mp3',
    'yilmaz30.mp3',
    'yilmaz31.mp3',
    'yilmaz32.mp3',
    'yilmaz33.mp3',
    'yilmaz34.mp3',
    'yilmaz35.mp3',
    'yilmaz36.mp3',
    'yilmaz37.mp3',
    'yilmaz38.mp3',
  ];

  void _playSound() async {
    if (_audioPlayer != null) {
      // Bir ses çalıyorsa, herhangi bir işlem yapmadan çık
      return;
    }

    int index = _random.nextInt(yilmazSounds.length);
    String soundPath = 'sounds/${yilmazSounds[index]}';

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
            "yılmaz",
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
                    'assets/images/yilmaz.png',
                    height: 300,
                    width: 200,
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
