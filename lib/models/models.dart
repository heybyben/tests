class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String? albumArtUrl;
  final Duration duration;
  final String streamUrl;
  final bool isFavorite;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    this.albumArtUrl,
    required this.duration,
    required this.streamUrl,
    this.isFavorite = false,
  });

  Song copyWith({bool? isFavorite}) => Song(
        id: id,
        title: title,
        artist: artist,
        album: album,
        albumArtUrl: albumArtUrl,
        duration: duration,
        streamUrl: streamUrl,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  factory Song.fromJson(Map<String, dynamic> json, String baseUrl) {
    return Song(
      id: json['Id'] ?? '',
      title: json['Name'] ?? 'Unknown',
      artist: json['AlbumArtist'] ?? json['Artists']?.first ?? 'Unknown',
      album: json['Album'] ?? '',
      albumArtUrl: json['ImageTags']?['Primary'] != null
          ? '$baseUrl/Items/${json['Id']}/Images/Primary'
          : null,
      duration: Duration(
          microseconds: ((json['RunTimeTicks'] ?? 0) / 10).round()),
      streamUrl: '$baseUrl/Audio/${json['Id']}/stream?static=true',
    );
  }
}

class Album {
  final String id;
  final String title;
  final String artist;
  final String? artUrl;
  final int songCount;
  final int year;

  const Album({
    required this.id,
    required this.title,
    required this.artist,
    this.artUrl,
    required this.songCount,
    required this.year,
  });

  factory Album.fromJson(Map<String, dynamic> json, String baseUrl) {
    return Album(
      id: json['Id'] ?? '',
      title: json['Name'] ?? 'Unknown',
      artist: json['AlbumArtist'] ?? 'Unknown',
      artUrl: json['ImageTags']?['Primary'] != null
          ? '$baseUrl/Items/${json['Id']}/Images/Primary'
          : null,
      songCount: json['ChildCount'] ?? 0,
      year: json['ProductionYear'] ?? 0,
    );
  }
}

class Mix {
  final String id;
  final String label;
  final String title;
  final String subtitle;
  final MixType type;

  const Mix({
    required this.id,
    required this.label,
    required this.title,
    required this.subtitle,
    required this.type,
  });
}

enum MixType { daily, chill, focus, newMix, energy }

class UserProfile {
  final String id;
  final String name;
  final String? avatarUrl;
  final bool isPremium;
  final String serverUrl;

  const UserProfile({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.isPremium,
    required this.serverUrl,
  });
}
