// ignore: import_of_legacy_library_into_null_safe
import 'dart:convert';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/custom_list_tiles.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicApp(),
    );
  }
}

class MusicApp extends StatefulWidget {
  const MusicApp({Key key}) : super(key: key);

  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  IconData btnIcon = Icons.pause;
  List musicList = [];
  List musicListCopy = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  String currentCover = "";
  String currentTitle = "";
  String currentSinger = "";
  Duration duration = new Duration();
  String du = "0:00";
  String pos = "0:00";
  Duration position = new Duration();
  AudioPlayer audio = new AudioPlayer();
  bool isPlaying = false;
  String currSong = "";
  Icon firstIcon = Icon(Icons.search);
  Widget firstSearchBar = Text(
    "Music App",
    style: TextStyle(color: Colors.black),
  );
  void searchText(String value) {
    setState(() {
      int len = value.length;
      musicList=[];
      if (value.length == 0) {
        musicList = musicListCopy;
      } 
      else {
        for(int i=0;i<musicListCopy.length;i++){
          if(musicListCopy[i]["singer"].toString().substring(0,len).toLowerCase()==value.toLowerCase() || musicListCopy[i]["title"].toString().substring(0,len).toLowerCase()==value.toLowerCase()){
            musicList.add(musicListCopy[i]);
          }
        }
      }
    });
  }

  Future getData() async {
    var data = await http.get(Uri.http('akshatshah12.pythonanywhere.com', ""));
    print(musicList);
    setState(() {
      musicList = jsonDecode(data.body);
    });
  }

  void setDuration() {
    setState(() {
      if ((audio.duration.inSeconds % 60) <= 9) {
        du = ((audio.duration.inSeconds / 60).floor().toString() +
            ":0" +
            (audio.duration.inSeconds % 60).toString());
      } else {
        du = ((audio.duration.inSeconds / 60).floor().toString() +
            ":" +
            (audio.duration.inSeconds % 60).toString());
      }
    });
  }

  void setPosition() {
    setState(() {
      if ((position.inSeconds % 60) <= 9) {
        pos = ((position.inSeconds / 60).floor().toString() +
            ":0" +
            (position.inSeconds % 60).toString());
      } else {
        pos = ((position.inSeconds / 60).floor().toString() +
            ":" +
            (position.inSeconds % 60).toString());
      }
    });
  }

  void playNextSong(int index) {
    setState(() {
      if (index <= (musicList.length - 1)) {
        //currSong=musicList[index]["url"];
        currentCover = musicList[index]["cover_url"];
        currentSinger = musicList[index]["singer"];
        currentTitle = musicList[index]["title"];
        playMusic(musicList[index]["url"], index);
      } else {
        currentCover = musicList[0]["cover_url"];
        currentSinger = musicList[0]["singer"];
        currentTitle = musicList[0]["title"];
        playMusic(musicList[0]["url"], 0);
      }
    });
  }

  void playMusic(String url, int index) async {
    if (isPlaying && currSong != url) {
      audio.stop();
      setState(() {
        isPlaying = false;
        position = Duration(seconds: 0);
      });
      await audio.play(url);

      setState(() {
        setDuration();
        isPlaying = true;
        btnIcon = Icons.pause;
        currSong = url;
      });
    } else if (!isPlaying) {
      await audio.play(url);
      setDuration();
      setState(() {
        isPlaying = true;
      });
    }
    audio.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
        setPosition();
        setDuration();
        if (du == pos && du != "0:00") {
          playNextSong(index + 1);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          color: Colors.black,
        ),
        actions: [
          IconButton(
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (firstIcon.icon == Icons.search) {
                    firstIcon = Icon(Icons.cancel);
                    musicListCopy = musicList;
                    firstSearchBar = TextField(
                      textInputAction: TextInputAction.go,
                      onChanged: (value) {
                        searchText(value);
                      },
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    );
                  } else {
                    musicList=musicListCopy;
                    musicListCopy=[];
                    firstIcon = Icon(Icons.search);
                    firstSearchBar = Text(
                      "Music App",
                      style: TextStyle(color: Colors.black),
                    );
                  }
                });
              },
              icon: firstIcon),
          IconButton(
              color: Colors.black,
              onPressed: () {},
              icon: Icon(Icons.more_vert)),
        ],
        title: firstSearchBar,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: musicList.length,
              itemBuilder: (context, index) => customListTile(
                title: musicList[index]['title'],
                singer: "by " + musicList[index]['singer'],
                onTap: () {
                  playMusic(musicList[index]['url'], index);
                  setState(() {
                    currentCover = musicList[index]['cover_url'];
                    currentSinger = musicList[index]['singer'];
                    currentTitle = musicList[index]['title'];
                  });
                },
                cover: musicList[index]['cover_url'],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x55212121),
                    blurRadius: 22.0,
                  ),
                ]),
            child: currentSinger.length == 0
                ? Container()
                : Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Slider(
                              value: position.inSeconds.toDouble(),
                              min: 0.0,
                              max: audio.duration.inSeconds.toDouble(),
                              onChanged: (value) {
                                audio.seek(value);
                              })),
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pos,
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              du,
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                image: DecorationImage(
                                    image: NetworkImage(currentCover)),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentTitle,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    currentSinger,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              iconSize: 32,
                              icon: Icon(btnIcon),
                              onPressed: () {
                                if (isPlaying) {
                                  audio.pause();
                                  setState(() {
                                    isPlaying = false;
                                    btnIcon = Icons.play_arrow;
                                  });
                                } else {
                                  audio.play(currSong);
                                  btnIcon = Icons.pause;
                                  setState(() {
                                    isPlaying = true;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
