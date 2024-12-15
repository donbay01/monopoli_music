import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:monopoli/models/audio/album.dart';
import 'package:monopoli/services/spotify.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';

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
      backgroundColor: scaffoldBlack,
      appBar: AppBar(
        backgroundColor: scaffoldBlack,
        title: Text(
          "Trending Album",
          style: mediumSemiBold(primaryWhite),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: primaryWhite,
            )),
      ),
      body: InfiniteListView(
        delegate: PaginationDelegate(
          itemCount: _items.length,
          itemBuilder: (_, index) {
            var item = _items[index];

            return ListTile(
              leading: Text(
                '${index + 1}',
                style: mediumText(primaryWhite),
              ),
              title: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(46),
                    child: CachedNetworkImage(
                      imageUrl: item.cover?.first.url ?? item.images!.first.url,
                      width: 46,
                      height: 46,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    item.name ?? 'N/A',
                    style: mediumText(primaryWhite),
                  ),
                ],
              ),
            );
          },
          isLoading: _isLoading,
          onFetchData: _fetchData,
        ),
      ),
    );
  }
}
