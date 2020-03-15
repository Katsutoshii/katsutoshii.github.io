import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

class ParticlesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularParticle(
      key: UniqueKey(),
      awayRadius: 100,
      numberOfParticles: 50,
      speedOfParticles: 1,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      onTapAnimation: true,
      particleColor: Colors.grey.withAlpha(100),
      awayAnimationDuration: Duration(milliseconds: 600),
      maxParticleSize: 10,
      isRandSize: true,
      isRandomColor: true,
      randColorList: [
        Colors.blueGrey.withAlpha(100),
        Colors.white.withAlpha(100),
        Colors.lightBlue.withAlpha(100),
      ],
      awayAnimationCurve: Curves.easeInOutBack,
      enableHover: true,
      hoverColor: Colors.white,
      hoverRadius: 90,
      connectDots: true, //not recommended
    );
  }
}
