import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:monopoli/models/audio/album.dart';
import 'package:monopoli/services/spotify.dart';

class AllAlbum extends StatefulWidget {
  final String token;

  const AllAlbum({
    super.key,
    required this.token,
  });

  @override
  State<AllAlbum> createState() => _AllAlbumState();
}

class _AllAlbumState extends State<AllAlbum> {
  List<Album> _items = [];
  var offset = 0;
  bool _isLoading = true;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    print(offset);

    var albums = await Spotify.getTrendingAlbums(
      accessToken: widget.token,
      offset: offset,
    );

    offset = offset + 1;

    setState(() {
      _isLoading = false;
      _items.addAll(albums.items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending Album"),
      ),
      body: InfiniteListView(
        delegate: PaginationDelegate(
          itemCount: _items.length,
          itemBuilder: (_, index) => ListTile(
            title: Text(_items[index].name ?? 'N/A'),
          ),
          isLoading: _isLoading,
          onFetchData: _fetchData,
        ),
      ),
    );
  }
}
