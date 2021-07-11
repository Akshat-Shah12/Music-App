import 'dart:convert';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/custom_list_tiles.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/notLoaded.dart';
import 'package:music_app/playlist.dart';
import 'package:share/share.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:page_transition/page_transition.dart';

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
  // void initializeFlutterFire() async {
  //   try {
  //     // Wait for Firebase to initialize and set `_initialized` state to true
  //     setState(() {
  //       _initialized = true;
  //     });
  //   } catch (e) {
  //     // Set `_error` state to true if Firebase initialization fails
  //     setState(() {
  //       _error = true;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    //initializeFlutterFire();
    getData();
    controller.addListener(() {
      setState(() {
        closeTopContainer = controller.offset.toInt() > 60;
      });
    });
  }

  void getMovieNames() {
    print("object");
    print(musicListCopy.length);
    setState(() {
      for (int i = 0; i < musicList.length; i++) {
        if (!movies.contains(musicList[i]["movie"])) {
          movies.add(musicList[i]["movie"].toString());
        }
      }
      movies.remove("None");
      movies.add("None");
      moviesCopy = movies;
      print(movies);
    });
  }

  List<String> movies = <String>[];
  List<String> moviesCopy = <String>[];

  bool aboutUs = false;
  int _currentIndex = 0;
  String myPlaylist = "My Playlist";
  String english = "English best music";
  String bollywoodMush = "Bollywood Mush";
  String partyMusic = "Party Music";
  String currentCover = "";
  String currentTitle = "";
  String currentSinger = "";
  Duration duration = new Duration();
  String du = "0:00";
  String appLink = "";
  String pos = "0:00";
  Duration position = new Duration();
  AudioPlayer audio = new AudioPlayer();
  bool isPlaying = false;
  int indexPlaying = 0;
  String currSong = "";
  Icon firstIcon = Icon(Icons.search);
  bool notLoaded = true;
  ScrollController controller = new ScrollController();
  bool closeTopContainer = false;
  Widget firstSearchBar = Text(
    "Music App",
    style: TextStyle(color: Colors.black),
  );
  void searchText(String value) {
    setState(() {
      int len = value.length;
      if (value.length == 0) {
        musicList = musicListCopy;
      } else {
        musicList = [];
        for (int i = 0; i < musicListCopy.length; i++) {
          if (musicListCopy[i]["singer"]
                      .toString()
                      .substring(0, len)
                      .toLowerCase() ==
                  value.toLowerCase() ||
              musicListCopy[i]["title"]
                      .toString()
                      .substring(0, len)
                      .toLowerCase() ==
                  value.toLowerCase()) {
            musicList.add(musicListCopy[i]);
          }
        }
      }
    });
  }

  void searchMovieName(String value) {
    setState(() {
      int len = value.length;
      if (len == 0) {
        movies = moviesCopy;
      } else {
        movies = [];
        for (int i = 0; i < moviesCopy.length; i++) {
          if (moviesCopy[i].toString().substring(0, len).toLowerCase() ==
              value.toLowerCase()) {
            movies.add(moviesCopy[i]);
          }
        }
      }
    });
  }

  Future getData() async {
    var data = await http.get(Uri.http('akshatshah12.pythonanywhere.com', ""));
    setState(() {
      musicList = jsonDecode(data.body);
      musicListCopy = musicList;
      print(musicList);
      notLoaded = false;
      appLink = musicList[0]["link"];
    });
    getMovieNames();
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
      } else if (musicList.length > 0) {
        currentCover = musicList[0]["cover_url"];
        currentSinger = musicList[0]["singer"];
        currentTitle = musicList[0]["title"];
        playMusic(musicList[0]["url"], 0);
      }
    });
  }

  void playPreviousSong(int index) {
    setState(() {
      if (index >= 0) {
        //currSong=musicList[index]["url"];
        currentCover = musicList[index]["cover_url"];
        currentSinger = musicList[index]["singer"];
        currentTitle = musicList[index]["title"];
        playMusic(musicList[index]["url"], index);
      } else if (musicList.length > 0) {
        currentCover = musicList[musicList.length - 1]["cover_url"];
        currentSinger = musicList[musicList.length - 1]["singer"];
        currentTitle = musicList[musicList.length - 1]["title"];
        playMusic(musicList[musicList.length - 1]["url"], musicList.length - 1);
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
        indexPlaying = index;
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

  void launchingApk() {
    Share.share(
      "Hey, I am using this music app. It provides best songs with no ads. Moreover the app keeps playing music even when the phone screen is off which can save your battery. Do install this app. Get it on " +
          appLink.toString(),
      subject:
          "Hey, I am using an amazing music app. You should definitly try it out",
    );
  }

  Widget popUpMenuButton() {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        // PopupMenuItem<String>(
        //   value: "one",
        //   child: Text("two"),
        // ),
        PopupMenuItem<String>(
            value: "share",
            child: Row(
              children: [
                Text(
                  "Share",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.share,
                  color: Colors.black,
                )
              ],
            )),
        PopupMenuItem<String>(
            value: "About",
            child: Row(
              children: [
                Text(
                  "About us",
                  style: TextStyle(color: Colors.black),
                ),
                // SizedBox(
                //   width: 10,
                // ),
                // Icon(
                //   Icons.share,
                //   color: Colors.black,
                // )
              ],
            )),
      ],
      onSelected: (val) {
        if (val == "share") {
          launchingApk();
        } else if (val == "About") {
          setState(() {
            aboutUs = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.21;

    final tabs = [
      Stack(
        children: [
          Container(
            height: size.height,
            child: Column(
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: closeTopContainer ? 0 : 1,
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: size.width,
                      alignment: Alignment.topCenter,
                      height: closeTopContainer
                          ? 0
                          : categoryHeight, //////////////////////////////////////
                      child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: 640,
                          margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            alignment: Alignment.topCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.topToBottom,
                                            child: PlayList(
                                              heading: english,
                                              data1: musicListCopy,
                                            )));
                                  },
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://m6dhpa.by.files.1drv.com/y4mfzd6KJsY08Lzumyxqt7nE36wjIym0SZoMp8bbYDMzx3OxkPly6tTGSJBCZHd6pasG4NYe_csdF2VqA-PgMtAl9sHkZkdKzuSn_hIUy5wvXoihE5KsvUGYdHd6wgbzfrSm9CbJgCIE4OyJzLxYJFJRP_sQXvti9G6qvKKq1FV_0ueuHrpPSQDC_M_0aVYTvK-7JeZqfG1yT4VQZvLmnqEXQ")),
                                    ),
                                    // child: Center(
                                    //   child: Text(
                                    //     "English Top Hits",
                                    //     textAlign: TextAlign.center,
                                    //     style: TextStyle(color: Colors.white, fontSize: 30),
                                    //   ),
                                    // ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.topToBottom,
                                            child: PlayList(
                                              heading: bollywoodMush,
                                              data1: musicListCopy,
                                            )));
                                  },
                                  child: Container(
                                    width: 200,
                                    margin: EdgeInsets.only(right: 10),
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://m6d2eq.by.files.1drv.com/y4m_qbTJY1uRQtD0wwpv2PDq93JsonR75_2OoGtZV1h_G5Is7fMf4ue3Pk8zo39eFev0VKvtpLbfZA2dfT9MfICuSb1DOYjsn4f61S_z5digNSj8VkTBTqBtt1MmsPve8-mCoQgYI-xtMCQQc2hyk-MIHHgTzoyyxlbWogXgSqUQP0IFnlfRd72ZGPU2cxeKrlxCBWc-QUmLcjzXT11dEronA")),
                                    ),
                                    // child: Center(
                                    //   child: Center(
                                    //     child: Text(
                                    //       "Bollywood Mush",
                                    //       textAlign: TextAlign.center,
                                    //       style: TextStyle(color: Colors.white, fontSize: 30),
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.topToBottom,
                                            child: PlayList(
                                              heading: partyMusic,
                                              data1: musicListCopy,
                                            )));
                                  },
                                  child: Container(
                                    width: 200,
                                    margin: EdgeInsets.only(right: 10),
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://m6bbnq.by.files.1drv.com/y4mC-8YmelzSQRbgUIm3QK-l0BUL9XiS0XJGUOAyYuLnzMeGO5-brH2QMI82pk_5XhuO5xasFVy06rBG3IccDYhawgPXcV_wwxYITYI3ph3DrmaEq3B0WMeW0x47pPNubd-XaQcuvZSByV8e4n56YnVSp3laWS3hjKZjBZFmXP42D1-XsJtVISrz4a473i49TvRYPx9WkExz8plQcmSGQqE8Q")),
                                    ),
                                    // child: Center(
                                    //   child: Center(
                                    //     child: Text(
                                    //       "Party Music",textAlign: TextAlign.center,
                                    //       style: TextStyle(color: Colors.white, fontSize: 30),
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.topToBottom,
                                            child: PlayList(
                                              heading: myPlaylist,
                                              data1: musicListCopy,
                                            )));
                                  },
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.black,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "My Playlist",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: controller,
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
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.white,
                            Colors.blue,
                          ]),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x55212121),
                          blurRadius: 22.0,
                        ),
                      ]),
                  child: currentTitle.length == 0
                      ? Container()
                      : Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                child: Slider(
                                    inactiveColor: Colors.grey[500],
                                    activeColor: Colors.black,
                                    value: position.inSeconds.toDouble(),
                                    min: 0.0,
                                    max: audio.duration.inSeconds.toDouble(),
                                    onChanged: (value) {
                                      audio.seek(value);
                                    })),
                            Padding(
                              padding: EdgeInsets.only(left: 40, right: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              padding:
                                  EdgeInsets.only(bottom: 8, left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      image: DecorationImage(
                                          image: NetworkImage(currentCover)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                    onPressed: () {
                                      playPreviousSong(indexPlaying - 1);
                                    },
                                    icon: Icon(Icons.skip_previous),
                                    iconSize: 32,
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
                                  IconButton(
                                    onPressed: () {
                                      playNextSong(indexPlaying + 1);
                                    },
                                    icon: Icon(Icons.skip_next),
                                    iconSize: 32,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
          aboutUs
              ? Center(
                  child: Container(
                    width: 300,
                    height: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Colors.black, width: 2),
                        color: Colors.green),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          child: SelectableText(
                            "This app is made for fun by Akshat Shah...If you want any particular song to be added then you can message on 9167156963 or mail on avshah2001@gmail.com  *(long press to copy details)",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  aboutUs = false;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Text(
                                    "Close",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),

      ////////////////////////////////////////LIBRARY
      // Center(
      //   child: Text("jdkkkkkk"),
      // ),
      Column(
        children: [
          Container(
              child: Text(
            "Movie Names",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          )),
          Expanded(
            child: GridView.builder(
                itemCount: movies.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, item) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.topToBottom,
                                child: PlayList(
                                  heading: movies[item],
                                  data1: musicListCopy,
                                )));
                      },
                      child: movies[item] == "None"
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.lightBlue),
                              margin: EdgeInsets.all(10),
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Text(
                                    "From different Music Albums",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue),
                              margin: EdgeInsets.all(10),
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Text(
                                    movies[item],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                    )),
          ),
        ],
      )
    ];
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
                        if (_currentIndex == 1) {
                          print("barney");
                          searchMovieName(value);
                        } else {
                          searchText(value);
                        }
                      },
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    );
                  } else {
                    musicList = musicListCopy;

                    ///musicListCopy = []; kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                    firstIcon = Icon(Icons.search);
                    firstSearchBar = Text(
                      "Music App",
                      style: TextStyle(color: Colors.black),
                    );
                  }
                });
              },
              icon: firstIcon),
          popUpMenuButton(),
        ],
        title: firstSearchBar,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: (notLoaded) ? Center(child: NotLoaded()) : tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add),
            label: "Library",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
