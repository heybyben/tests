import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import '../models/models.dart';

class PlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  Song? _currentSong;
  List<Song> _queue = [];
  int _currentIndex = 0;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _shuffle = false;
  LoopMode _loopMode = LoopMode.off;

  Song? get currentSong => _currentSong;
  List<Song> get queue => _queue;
  bool get isPlaying => _isPlaying;
  Duration get position => _position;
  Duration get duration => _duration;
  bool get shuffle => _shuffle;
  LoopMode get loopMode => _loopMode;
  AudioPlayer get player => _player;

  double get progress {
    if (_duration.inMilliseconds == 0) return 0;
    return _position.inMilliseconds / _duration.inMilliseconds;
  }

  PlayerProvider() {
    _player.playingStream.listen((playing) {
      _isPlaying = playing;
      notifyListeners();
    });
    _player.positionStream.listen((pos) {
      _position = pos;
      notifyListeners();
    });
    _player.durationStream.listen((dur) {
      _duration = dur ?? Duration.zero;
      notifyListeners();
    });
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        next();
      }
    });
  }

  Future<void> playSong(Song song, {List<Song>? queue}) async {
    _currentSong = song;
    if (queue != null) {
      _queue = queue;
      _currentIndex = queue.indexOf(song);
    }
    try {
      await _player.setUrl(song.streamUrl);
      await _player.play();
    } catch (e) {
      debugPrint('Error playing: $e');
    }
    notifyListeners();
  }

  Future<void> togglePlay() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  Future<void> seek(double progress) async {
    final pos = Duration(
        milliseconds: (progress * _duration.inMilliseconds).round());
    await _player.seek(pos);
  }

  Future<void> next() async {
    if (_queue.isEmpty) return;
    _currentIndex = (_currentIndex + 1) % _queue.length;
    await playSong(_queue[_currentIndex]);
  }

  Future<void> previous() async {
    if (_queue.isEmpty) return;
    if (_position.inSeconds > 3) {
      await _player.seek(Duration.zero);
      return;
    }
    _currentIndex = (_currentIndex - 1 + _queue.length) % _queue.length;
    await playSong(_queue[_currentIndex]);
  }

  void toggleShuffle() {
    _shuffle = !_shuffle;
    _player.setShuffleModeEnabled(_shuffle);
    notifyListeners();
  }

  void toggleLoop() {
    switch (_loopMode) {
      case LoopMode.off:
        _loopMode = LoopMode.all;
        break;
      case LoopMode.all:
        _loopMode = LoopMode.one;
        break;
      case LoopMode.one:
        _loopMode = LoopMode.off;
        break;
    }
    _player.setLoopMode(_loopMode);
    notifyListeners();
  }

  void toggleFavorite() {
    if (_currentSong == null) return;
    _currentSong = _currentSong!.copyWith(isFavorite: !_currentSong!.isFavorite);
    notifyListeners();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
