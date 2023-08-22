import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sept_tv/screens/shimmer.dart';
import 'package:sept_tv/screens/youtube_grid.dart';
import 'package:sept_tv/screens/youtube_player.dart';

import '../models/Video_model.dart';
import '../models/channel_model.dart';
import '../service/api_service.dart';

class VoirPlusYoutube extends StatefulWidget {
  const VoirPlusYoutube({super.key});

  @override
  State<VoirPlusYoutube> createState() => _VoirPlusYoutubeState();
}

class _VoirPlusYoutubeState extends State<VoirPlusYoutube> {
  Channel? _channel;
  bool _isLoading = false;
  var isLoading = false;

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UC32mUY43bA0yIrLfqcCNwww');
    setState(() {
      _channel = channel;
      isLoading = true;
    });
  }

  _buildProfileInfo() {
    return Column(
      children: [
        Container(
          height: 110,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffFFFFFF), width: 4),
          ),
          child: CachedNetworkImage(
            imageUrl: _channel!.profilePictureUrl,
            placeholder: (context, url) => Image.asset('assets/imgCache.png'),
            errorWidget: (context, url, error) =>
                Image.asset('assets/imgCache.png'),
            fit: BoxFit.cover,
          ),
        ),
        Text(
          _channel!.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ],
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VideoScreen(
                  id: video.id,
                  title: video.title,
                  desc: video.description,
                ),
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffFFFFFF), width: 4),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: video.thumbnailUrl,
                      placeholder: (context, url) =>
                          Image.asset('assets/imgCache.png'),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/imgCache.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                    Transform.translate(
                        offset: Offset(100, 50),
                        child: Icon(Icons.play_circle_fill_outlined,size: 40.0,color: Color(0xff007CD3),)
                    ),
            ]
                ),
                Text(
                  video.title, // Provide a default value or handle null
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ],
            ),
          ),
        ));
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel!.uploadPlaylistId);
    List<Video> allVideos = _channel!.videos..addAll(moreVideos);
    setState(() {
      _channel!.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff007CD3),
        leading: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return YouTube();
                }),
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Image.asset(
            'assets/logo.png',
            height: 40,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    _channel!.videos.length !=
                        int.parse(_channel!.videoCount) &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  _loadMoreVideos();
                }
                return false;
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg1.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: CustomScrollView(
                    slivers: [
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 30,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            Video video = _channel!.videos[index];
                            return _buildVideo(video);
                          },
                          childCount: _channel!.videos.length,
                        ),
                      ),
                    ],
                  )),
            )
          :ShimmerList(),
    );
  }
}
