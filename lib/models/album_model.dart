class Song {
  final String title;
  final String artist;
  final String imageUrl;

  Song({required this.title, required this.artist, required this.imageUrl});
}

class Album {
  final String title;
  final String imageAssetPath;
  final List<Song> songs;

  Album({required this.title, required this.imageAssetPath, required this.songs});
}

final List<Album> albums = [
  Album(
    title: 'Timeless',
    imageAssetPath: 'assets/davido.png',
    songs: [
      Song(title: 'Feel', artist: 'Davido', imageUrl: 'assets/davido.png'),
      Song(title: 'Kante', artist: 'Davido Featuring Fave', imageUrl: 'assets/davido.png'),
      Song(title: 'Unavailable', artist: 'Davido', imageUrl: 'assets/davido.png'),
      Song(title: 'Over dem', artist: 'Davido', imageUrl: 'assets/davido.png'),
      Song(title: 'Away', artist: 'Davido', imageUrl: 'assets/davido.png'),
    ],
  ),
  Album(
    title: 'Wave',
    imageAssetPath: 'assets/album1.png',
    songs: [
      Song(title: 'Song 1', artist: 'Artist 1', imageUrl: 'assets/davido.png'),
      Song(title: 'Song 2', artist: 'Artist 1', imageUrl: 'assets/davido.png'),
      Song(title: 'Song 3', artist: 'Artist 1', imageUrl: 'assets/davido.png'),
      Song(title: 'Song 4', artist: 'Artist 1', imageUrl: 'assets/davido.png'),
      Song(title: 'Song 5', artist: 'Artist 1', imageUrl: 'assets/davido.png'),
    ],
  ),
  Album(
    title: 'Boy Alone',
    imageAssetPath: 'assets/album3.png',
    songs: [
      Song(title: 'Song 1', artist: 'Artist 3', imageUrl: 'assets/davido.png'),
      Song(title: 'Song 2', artist: 'Artist 3', imageUrl: 'assets/davido.png'),
      Song(title: 'Song 3', artist: 'Artist 3', imageUrl: 'assets/davido.png'),
      Song(title: 'Song 4', artist: 'Artist 3', imageUrl: 'assets/davido.png'),
      Song(title: 'Song 5', artist: 'Artist 3', imageUrl: 'assets/davido.png'),
    ],
  ),
];

final List<Map<String, String>> genres = [
  {'name': 'Rock', 'image': 'assets/afrobeats.png'},
  {'name': 'Pop', 'image': 'assets/hiphop.png'},
  {'name': 'Jazz', 'image': 'assets/jazz.png'},
  {'name': 'Hip-Hop', 'image': 'assets/soul.png'},
  {'name': 'Classical', 'image': 'assets/randb.png'},
  {'name': 'Electronic', 'image': 'assets/country.png'},
];

