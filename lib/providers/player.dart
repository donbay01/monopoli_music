import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:monopoli/models/audio/index.dart';
import 'package:monopoli/models/audio/track.dart';

final player = StateProvider((ref) => AudioPlayer());
final trackProvider = StateProvider<Track?>((ref) => null);
final audioProvider = StateProvider<AudioApiResponse?>((ref) => null);

final isExpanded = StateProvider((ref) => false);
