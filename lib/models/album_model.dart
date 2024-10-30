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
      Song(title: 'Juju', artist: 'Asake', imageUrl: 'assets/album1.png'),
      Song(title: 'Lonely at the top', artist: 'Asake', imageUrl: 'assets/album1.png'),
      Song(title: 'Soapy', artist: 'Asake', imageUrl: 'assets/album1.png'),
      Song(title: 'Madness fire', artist: 'Asake', imageUrl: 'assets/album1.png'),
      Song(title: 'Beginning', artist: 'Asake', imageUrl: 'assets/album1.png'),
    ],
  ),
  Album(
    title: 'Pink Print',
    imageAssetPath: 'assets/album3.png',
    songs: [
      Song(title: 'Missing you', artist: 'Nicki Minaj', imageUrl: 'assets/album3.png'),
      Song(title: 'Believe', artist: 'Nicki Minaj', imageUrl: 'assets/album3.png'),
      Song(title: 'High Rise', artist: 'Nicki Minaj', imageUrl: 'assets/album3.png'),
      Song(title: 'Hot Bitch', artist: 'Nicki Mina', imageUrl: 'assets/album3.png'),
      Song(title: 'WAP', artist: 'Nicky Minaj', imageUrl: 'assets/album3.png'),
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

