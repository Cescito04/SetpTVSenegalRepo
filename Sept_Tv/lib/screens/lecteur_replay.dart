import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:http/http.dart' as http;
import 'package:sept_tv/screens/replayTv.dart';
import 'package:sept_tv/screens/shimmer.dart';
import '../models/apiAlaUne.dart';

class LectReplay extends StatefulWidget {
  LectReplay(
      {super.key,
      this.getVidUrl,
      this.getRelated,
      this.getTitle,
      this.getTime,
      this.index});

  String? getVidUrl;
  String? getRelated;
  String? getTime;
  String? getTitle;
  var index;

  @override
  State<LectReplay> createState() => _LectReplayState();
}

class _LectReplayState extends State<LectReplay> {
  var _isLoading = false;
  ApiAlaUne? datum5;
  var video;
  var related;
  var time;
  var title;

  Future<ApiAlaUne?> fetchApiReplay() async {
    final response = await http.get(Uri.parse(widget.getRelated!));
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        datum5 = ApiAlaUne.fromJson(jsonDecode(response.body));
        _isLoading = true;
      });
      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network, video!);
      log("Player ${video}");
      _betterPlayerController = BetterPlayerController(
          BetterPlayerConfiguration(autoPlay: true),
          betterPlayerDataSource: betterPlayerDataSource);
      print("Api Replay");
      log('${datum5!.allitems?[0].videoUrl}');
    } else {
      throw Exception('Failed to load ApiSeptTv');
    }
  }

  BetterPlayerController? _betterPlayerController;

  @override
  void initState() {
    super.initState();
    fetchApiReplay();
    setState(() {
      video=widget.getVidUrl;
      log("initVideo ${video}");
      related=widget.getRelated;
      log("initRelated ${related}");
      time=widget.getTime;
      title=widget.getTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("object ${widget.index}");
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
      body: _isLoading
          ? Container(
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
                  height: MediaQuery.of(context).size.height + 600,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: BetterPlayer(
                          controller: _betterPlayerController!,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (title != null)
                                Text(
                                  title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              if (time != null)
                                Text(
                                  time,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 28.0),
                              child: Container(
                                height: 40,
                                width: 5,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Videos Similaires',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ReplayTv();
                                }));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 138.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),

                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: CustomScrollView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            slivers: [
                              SliverPadding(
                                padding: EdgeInsets.all(20),
                                sliver: SliverGrid(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 30,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      log('messageLog VideoUrl ${datum5!.allitems![index].videoUrl}');
                                      if (datum5 != null &&
                                          datum5!.allitems != null &&
                                          index < datum5!.allitems!.length) {
                                        return InkWell(
                                          onTap: () {

                                            setState(() {

                                             video = datum5!
                                                  .allitems![index].videoUrl;
                                             log('Video ${video}');
                                             related = datum5!
                                                  .allitems![index]
                                                  .relatedItems;
                                             log('related ${related}');
                                            title =  datum5!
                                                  .allitems![index].title;
                                             log("title ${title}");
                                            time =   datum5!
                                                  .allitems![index].time;
                                            log("time${time}");
                                             fetchApiReplay();

                                              widget.index=index;
                                            });
                                          },
                                          child: Column(
                                            children: [
                                          Stack(
                                          children: [
                                          Container(
                                          height: 100,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:widget.index==index ? Color(0xffFFFFFF):Colors.transparent, width: 4),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                              '${datum5!.allitems![index].logo}',
                                              placeholder: (context, url) =>
                                                  Image.asset('assets/imgCache.png'),
                                              errorWidget: (context, url, error) =>
                                                  Image.asset('assets/imgCache.png',fit: BoxFit.cover),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                            Transform.translate(
                                                offset: Offset(100, 50),
                                                child: Icon(Icons.play_circle_fill_outlined,size: 40.0,color: Color(0xff007CD3),)
                                            ),
                                          ],
                                        ),
                                              Text(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                ' ${datum5!.allitems![index].title}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                    childCount: datum5?.allitems?.length ?? 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : ShimmerList(),
    );
  }
}
