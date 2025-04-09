import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class AudioPlayerHome extends StatefulWidget {
  const AudioPlayerHome({Key? key}) : super(key: key);

  @override
  State<AudioPlayerHome> createState() => _AudioPlayerHomeState();
}

class _AudioPlayerHomeState extends State<AudioPlayerHome> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<FileSystemEntity> _audioFiles = [];
  String? _currentFilePath;
  String _currentFileName = "No file selected";
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _requestPermission();

    // Listen to player state changes
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
    });

    // Listen to duration changes
    _audioPlayer.durationStream.listen((newDuration) {
      setState(() {
        _duration = newDuration ?? Duration.zero;
      });
    });

    // Listen to position changes
    _audioPlayer.positionStream.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });
  }

  Future<void> _requestPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
    }
  }

  Future<void> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      setState(() {
        _currentFilePath = result.files.single.path;
        _currentFileName = result.files.single.name;
      });
      await _loadAudio(_currentFilePath!);
    }
  }

  Future<void> _loadAudio(String filePath) async {
    try {
      await _audioPlayer.setFilePath(filePath);
      setState(() {
        _isPlaying = false;
      });
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  Future<void> _browseLocalAudio() async {
    try {
      // This is a simplified approach - in a real app, you'd want to scan
      // common directories or use MediaStore on Android
      String? directoryPath = await FilePicker.platform.getDirectoryPath();

      if (directoryPath != null) {
        final directory = Directory(directoryPath);
        final List<FileSystemEntity> files = directory.listSync();

        setState(() {
          _audioFiles =
              files.where((file) {
                final path = file.path.toLowerCase();
                return path.endsWith('.mp3') ||
                    path.endsWith('.wav') ||
                    path.endsWith('.aac') ||
                    path.endsWith('.m4a') ||
                    path.endsWith('.flac');
              }).toList();
        });

        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Select Audio File'),
                content: SizedBox(
                  width: double.maxFinite,
                  height: 300,
                  child: ListView.builder(
                    itemCount: _audioFiles.length,
                    itemBuilder: (context, index) {
                      final file = _audioFiles[index];
                      final fileName = file.path.split('/').last;

                      return ListTile(
                        title: Text(fileName),
                        onTap: () async {
                          setState(() {
                            _currentFilePath = file.path;
                            _currentFileName = fileName;
                          });
                          await _loadAudio(file.path);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
        );
      }
    } catch (e) {
      print("Error browsing audio: $e");
    }
  }

  void _playPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Audio Player'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Album art placeholder
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(Icons.music_note, size: 100, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),

            // Song title
            Text(
              _currentFileName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Progress bar
            Slider(
              value: _position.inSeconds.toDouble(),
              min: 0,
              max: _duration.inSeconds.toDouble(),
              onChanged: (value) {
                final position = Duration(seconds: value.toInt());
                _audioPlayer.seek(position);
              },
            ),

            // Duration indicators
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatDuration(_position)),
                  Text(_formatDuration(_duration)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Playback controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.skip_previous),
                  onPressed: () {
                    _audioPlayer.seek(Duration.zero);
                  },
                ),
                const SizedBox(width: 16),
                IconButton(
                  iconSize: 64,
                  icon: Icon(
                    _isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                  ),
                  onPressed: _currentFilePath != null ? _playPause : null,
                ),
                const SizedBox(width: 16),
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.skip_next),
                  onPressed: () {
                    // In a real app, this would play the next song
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ElevatedButton.icon(
              //   icon: const Icon(Icons.folder_open),
              //   label: const Text('Browse'),
              //   onPressed: _browseLocalAudio,
              // ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Pick File'),
                onPressed: _pickAudioFile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
