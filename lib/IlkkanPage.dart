import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class IlkkanPage extends StatefulWidget {
  const IlkkanPage({super.key});

  @override
  State<IlkkanPage> createState() => _IlkkanPageState();
}

class _IlkkanPageState extends State<IlkkanPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  AudioCache _audioCache = AudioCache();
  Random _random = Random();
  AudioPlayer? _audioPlayer;
  int? _lastPlayedIndex;

  final List<String> ilkkanSounds = [
    'ilkkan01.mp3',
    'ilkkan02.mp3',
    'ilkkan03.mp3',
    'ilkkan04.mp3',
    'ilkkan05.mp3',
    'ilkkan06.mp3',
    'ilkkan07.mp3',
    'ilkkan08.mp3',
    'ilkkan09.mp3',
    'ilkkan10.mp3',
    'ilkkan11.mp3',
    'ilkkan12.mp3',
    'ilkkan13.mp3',
    'ilkkan14.mp3',
    'ilkkan15.mp3',
    'ilkkan16.mp3',
    'ilkkan17.mp3',
    'ilkkan18.mp3',
    'ilkkan19.mp3',
    'ilkkan20.mp3',
    'ilkkan21.mp3',
  ];

  void _playSound() async {
    if (_audioPlayer != null) {
      // Bir ses çalıyorsa, herhangi bir işlem yapmadan çık
      return;
    }

    int index = _random.nextInt(ilkkanSounds.length);
    String soundPath = 'sounds/${ilkkanSounds[index]}';

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
            "ilkkan",
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
                    'assets/images/ilkkan.png',
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
