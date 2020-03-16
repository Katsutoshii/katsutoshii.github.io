import 'package:katsutoshii/models/project.dart';
import 'assets.dart';

final List<Project> projects = [
  Project(
      name: 'Laundry Folding AI',
      image: Assets.laundryfolding,
      description: 'Robotics Research Project.',
      link: 'http://www.cs.dartmouth.edu/~trdata/reports/TR2018-852.pdf'),
  Project(
      name: 'Hamono 刃物',
      image: Assets.hamono,
      description: 'Unity mobile action video game',
      link: 'http://hamono.surge.sh/'),
  Project(
      name: 'PLR',
      image: Assets.plr,
      description: 'Piecewise linear regressions for robot motion planning.',
      link: 'https://arxiv.org/ftp/arxiv/papers/2002/2002.12466.pdf'),
  Project(
      name: 'JPCFG',
      image: Assets.jpcfg,
      description: 'Japanese Language grammar parsing using Probabilistic Context-Free Grammars',
      link: 'https://github.com/Katsutoshii/JPCFG'),
  Project(
      name: 'PlanarMaxCut.jl',
      image: Assets.planarmaxcut,
      description: 'Juilia implementation of polynomial-time max cut on planar graphs.',
      link: 'https://gitlab.com/dartmouthrobotics/PlanarMaxCut.jl'
  ),
  Project(name: 'MotionPlanning.jl',
    image: Assets.mpl,
    description: 'Open-source motion planning library in Julia',
    link: 'https://gitlab.com/dartmouthrobotics/MotionPlanning.jl')
];
