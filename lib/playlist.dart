import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_list_tiles.dart';

class PlayList extends StatefulWidget {
  // final String heading;
  // const PlayList({Key key, this.heading}) : super(key: key);
  final String heading;
  final List data1;
  const PlayList({@required this.heading, @required this.data1});

  @override
  _PlayListState createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkEmpty();
    data = widget.data1;
    dataCopy = [];
    heading = widget.heading;
    //dataCopy = widget.data1;
    filter(heading);
    firstSearchBar = Text(
      heading,
      style: TextStyle(color: Colors.black),
    );
  }


  //This function is passes is custom_tile using callback function
  void removeMusicName(String x) async { 
    setState(() {
      for(int i=0;i<data.length;i++){
        if(data[i]["title"]==x){
          data.remove(data[i]);///or data[i]
        }
      }
      for(int i=0;i<dataCopy.length;i++){
        if(dataCopy[i]["title"]==x){
          dataCopy.remove(data[i]);///or data[i]
        }
      }
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    String names = pref.getString("singer");
    int initial = 0;
    List<String> namesList = List<String>();
    for (int m = 0; m < names.length; m++) {
      if (names[m] == "|") {
        String sub = names.substring(initial, m);
        if (sub != x) {
          namesList.add(sub);
        }
        initial = m + 1;
      }
    }
    pref.setString("singer", names);
  }

  //initializing the data with "" if there is no data present
  void checkEmpty() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String names = pref.getString("singer") ?? "";
    pref.setString("singer", names);
  }

  //To get all data from the mobile which is personally stored
  void getMusicNames() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String names = pref.getString("singer");
    List<String> namesList = List<String>();
    int initial = 0;
    for (int m = 0; m < names.length; m++) {
      if (names[m] == "|") {
        namesList.add(names.substring(initial, m));
        initial = m + 1;
      }
    }
    setState(() {
      for (int i = 0; i < namesList.length; i++) {
        for (int j = 0; j < data.length; j++) {
          if (namesList[i].toString().trim() ==
              data[j]["title"].toString().trim()) {
            dataCopy.add(data[j]);
          }
        }
      }
      data = dataCopy;
    });
  }

  //storing the playlist on the phone
  void setMusicNames(String x) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String names = pref.getString("singer");
    names = names + x + '|';
    pref.setString("singer", names);
  }

  //checking which playlist you have clicked on
  void filter(String type) {
    setState(() {
      if (type == "English best music") {
        for (int i = 0; i < data.length; i++) {
          if (data[i]["language"] == "eng") {
            dataCopy.add(data[i]);
          }
        }
        data = dataCopy;
      } else if (type == "Party Music") {
        for (int i = 0; i < data.length; i++) {
          if (data[i]["language"] == "hindi" && data[i]["mush"] == "F") {
            dataCopy.add(data[i]);
          }
        }
        data = dataCopy;
      } else if (type == "Bollywood Mush") {
        for (int i = 0; i < data.length; i++) {
          if (data[i]["language"] == "hindi" && data[i]["mush"] == "T") {
            dataCopy.add(data[i]);
          }
        }
        data = dataCopy;
      } else if (type == "My Playlist") {
        getMusicNames();
      }
    });
  }

  IconData btnIcon = Icons.pause;
  String heading = "";
  List data = [];
  List dataCopy = [];
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
    "",
    style: TextStyle(color: Colors.black),
  );
  void searchText(String value) {
    setState(() {
      int len = value.length;
      data = [];
      if (value.length == 0) {
        data = dataCopy;
      } else {
        for (int i = 0; i < dataCopy.length; i++) {
          if (dataCopy[i]["singer"]
                      .toString()
                      .substring(0, len)
                      .toLowerCase() ==
                  value.toLowerCase() ||
              dataCopy[i]["title"].toString().substring(0, len).toLowerCase() ==
                  value.toLowerCase()) {
            data.add(dataCopy[i]);
          }
        }
      }
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
      if (index <= (data.length - 1)) {
        //currSong=data[index]["url"];
        currentCover = data[index]["cover_url"];
        currentSinger = data[index]["singer"];
        currentTitle = data[index]["title"];
        playMusic(data[index]["url"], index);
      } else if (data.length > 0) {
        currentCover = data[0]["cover_url"];
        currentSinger = data[0]["singer"];
        currentTitle = data[0]["title"];
        playMusic(data[0]["url"], 0);
      }
    });
  }

  void playPreviousSong(int index) {
    setState(() {
      if (index >= 0) {
        //currSong=data[index]["url"];
        currentCover = data[index]["cover_url"];
        currentSinger = data[index]["singer"];
        currentTitle = data[index]["title"];
        playMusic(data[index]["url"], index);
      } else if (data.length > 0) {
        currentCover = data[data.length - 1]["cover_url"];
        currentSinger = data[data.length - 1]["singer"];
        currentTitle = data[data.length - 1]["title"];
        playMusic(data[data.length - 1]["url"], data.length - 1);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(Icons.menu),
        //   color: Colors.black,
        // ),
        title: firstSearchBar,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              //Navigator.pop(context,false);
              Navigator.pop(context,
                  PageTransition(type: PageTransitionType.bottomToTop));
            }),
        actions: [
          IconButton(
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (firstIcon.icon == Icons.search) {
                    firstIcon = Icon(Icons.cancel);
                    dataCopy = data;
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
                    data = dataCopy;

                    ///dataCopy = []; kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                    firstIcon = Icon(Icons.search);
                    firstSearchBar = Text(
                      heading,
                      style: TextStyle(color: Colors.black),
                    );
                  }
                });
              },
              icon: firstIcon),
          SizedBox(
            width: 5,
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            data.length==0?Container(child: Column(
              children: [
                SizedBox(height: 20,),
                Text("Your playlist is Empty"),
              ],
            ),):
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: data.length,
                itemBuilder: (context, index) => customListTile(
                  elementRemove: removeMusicName,
                  playList: heading,
                  title: data[index]['title'],
                  singer: "by " + data[index]['singer'],
                  onTap: () {
                    playMusic(data[index]['url'], index);
                    setState(() {
                      currentCover = data[index]['cover_url'];
                      currentSinger = data[index]['singer'];
                      currentTitle = data[index]['title'];
                    });
                  },
                  cover: data[index]['cover_url'],
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
                          padding:
                              EdgeInsets.only(bottom: 8, left: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    );
  }
}
