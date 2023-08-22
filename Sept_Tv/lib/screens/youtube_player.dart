import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sept_tv/screens/shimmer.dart';
import 'package:sept_tv/screens/yt_grid_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/Video_model.dart';
import '../models/channel_model.dart';
import '../service/api_service.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({super.key, this.id, this.title, this.desc});

  String? id;
  String? title;
  String? desc;


  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  var getId;
  var getTitle;
  var getDesc;

  var isLoading = false;
  YoutubePlayerController? _controller;
  Channel? _channel;
  bool _isLoading = false;

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UC32mUY43bA0yIrLfqcCNwww');
    setState(() {
      _channel = channel;
      isLoading = true;
    });
  }

  _buildVideo(Video video) {
    return GestureDetector(
        onTap: (){
          setState(() {
            _controller!.load(video.id);

            getId = video.id;
            log("Id video Youtube : ${getId}");
            getTitle = video.title;
            getDesc = video.description;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                    children:[ Container(
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
        )
    );
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
    setState(() {
      getId = widget.id;
      log("Id Youtube ${getId}");
      getTitle = widget.title;
      log("Titre Youtube ${getTitle}");
      getDesc = widget.desc;
      log("Description ${getDesc}");
    });

    _controller = YoutubePlayerController(
      initialVideoId: getId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff007CD3),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
              _channel?.videos.length !=
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
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height + 80,
              child: Column(
                children: [
                  YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                    onReady: () {
                      print('Player is ready.');
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (getTitle!= null)
                    Text(
                      getTitle!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  SizedBox(
                    height: 15,
                  ),
                  if (getDesc != null)
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          getDesc!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CustomScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        slivers: [
                          SliverGrid(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 30,
                            ),
                            delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                // Check if _channel is not null before accessing its properties
                                if (_channel != null && index < _channel!.videos.length) {
                                  Video video = _channel!.videos[index];
                                  return _buildVideo(video);
                                } else {
                                  // Handle the case when _channel is null or index is out of range
                                  return Container(); // Placeholder or error handling
                                }
                              },
                              childCount: 4,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 270.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return VoirPlusYoutube();
                                    }),
                                  );
                                },
                                child: Text(
                                  'Voir Plus ...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      )
          : ShimmerList(),
    );
  }
}