import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:lottie/lottie.dart';


Color? getColor(int hour) {
  switch (hour){
    case 0: return Colors.blue[900];
    case 1: return Colors.blue[900];
    case 22: return Colors.blue[900];
    case 23: return Colors.blue[900];
    case 2: return Colors.blue[800];
    case 3: return Colors.blue[800];
    case 21: return Colors.blue[800];
    case 20: return Colors.blue[800];
    case 4: return Colors.blue[700];
    case 5: return Colors.blue[700];
    case 19: return Colors.blue[700];
    case 18: return Colors.blue[700];
    case 6: return Colors.blue[600];
    case 7: return Colors.blue[600];
    case 17: return Colors.blue[600];
    case 16: return Colors.blue[600];
    case 8: return Colors.blue[500];
    case 9: return Colors.blue[500];
    case 10: return Colors.blue[500];
    case 11: return Colors.blue[500];
    case 15: return Colors.blue[500];
    case 14: return Colors.blue[500];
    case 13: return Colors.blue[500];
    case 12: return Colors.blue[500];

  }
  return Colors.blue;
}

Widget weatherAnimation(int id, TickerProvider tp, bool fullscreen) {
  if (800 < id && id < 805) {return wave(id, fullscreen);}
  if (700 < id && id < 782) {return atmosphere(id);}
  if (599 < id && id < 623) {return snow(tp);}
  if (499 < id && id < 532) {return rain(tp, id);}
  if (299 < id && id < 322) {return drizzle(tp);}
  if (199 < id && id < 233) {
    return Stack(
      children: [
        wave(id, fullscreen),
        rain(tp, id),
        thunder(),
      ],
    );
  }
  return SizedBox.shrink();
}

Widget wave(int id, bool fullscreen) {
  double height;
  if (fullscreen) {height = (id-800).toDouble()/5;}
  else {height = (id-800).toDouble()/12;}
  return WaveWidget(
      config: CustomConfig(
        gradients: [
          [Colors.grey.shade200, Colors.grey.shade300],
          [Colors.grey.shade400, Colors.grey.shade500],
        ],
        durations: [10000, 20000],
        heightPercentages: [0.9-height, 1-height],
        blur: MaskFilter.blur(BlurStyle.solid, 2),
      ),
      size: const Size(double.infinity, double.infinity),
      waveAmplitude: 10,
    );
}

Widget snow(TickerProvider tp) {
  return AnimatedBackground(
          behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
            baseColor: Colors.white,
            spawnMinSpeed: 10.0,
            spawnMaxSpeed: 20.0,
            spawnMaxRadius: 3.0,
            particleCount: 100,
            ),
          ),  
        vsync: tp,
        child: const SizedBox.expand(),
      );
}

Widget rain(TickerProvider tp, int id){
  int amount = 1;
  if (499 < id && id < 505) {amount = id - 499;}
  return AnimatedBackground(
          behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
            baseColor: Colors.white,
            minOpacity: 0.6,
            maxOpacity: 1,
            spawnMaxRadius: 3.0,
            particleCount: 50 * amount,
            ),
          ),  
        vsync: tp,
        child: const SizedBox.expand(),
      );
}

Widget drizzle(TickerProvider tp){
  return AnimatedBackground(
          behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
            baseColor: const Color.fromARGB(255, 175, 196, 213),
            minOpacity: 0.4,
            maxOpacity: 0.8,
            spawnMaxRadius: 1.0,
            particleCount: 100,
            ),
          ),  
        vsync: tp,
        child: const SizedBox.expand(),
      );
}

Widget thunder() {
  return Lottie.asset(
    'assets/lottie_animations/lightning.json',
    repeat: true, 
    reverse: false,
    animate: true,
  );
}

Widget atmosphere(int id) {
  var color;
  if (id < 742) {color = Colors.grey;}
  else if (id < 762) {color = Colors.orangeAccent;}
  else {color = Colors.blueGrey;}
  return WaveWidget(
      config: CustomConfig(
        gradients: [
          [color.shade200.withOpacity(0.5), color.shade300.withOpacity(0.5)],
          [color.shade400.withOpacity(0.5), color.shade500.withOpacity(0.5)],
        ],
        durations: [10000, 20000],
        heightPercentages: [0.6, 0.8],
        blur: MaskFilter.blur(BlurStyle.solid, 2),
      ),
      size: const Size(double.infinity, double.infinity),
      waveAmplitude: 10,
    );
}


