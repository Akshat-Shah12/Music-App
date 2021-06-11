// ignore: import_of_legacy_library_into_null_safe
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/custom_list_tiles.dart';

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
  //const MusicApp({Key key}) : super(key: key);

  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  IconData btnIcon = Icons.play_arrow;
  List musicList = [
    {
      "title": "Tera Ban Jauga",/////
      "singer": "Tulsi-Akhil",
      "url":
          "https://0ykvgg.by.files.1drv.com/y4m-AhC1uwhXAutZPgInusdG0A85_8Qw15OliHeU1D__aUrbwsgRxU9lmx6HP6Tw4Q0Mx0hQAZitni5uwxFUh99Pc_7IcJrKqxKmb3EqgY5VZIxU9OdB3h17PH2K3aTem83pJuf1c4Vo8MqDhQi7X1JyGVuOc2CAvQtr3ItXPwMsihlYX1POtHmTYBN4xq3ZPtjjR8UZMntCiIJR5dN4M228w",
      "cover_url": "https://0yka4a.by.files.1drv.com/y4mU7tUUVV3aPog5beyYNgOXgyBFZnBRHetrBW1vQPohjQSixmiQExDZiK_-lK-2MZK55_lZtf3XUKfUXW8Mo55vEO3Tt7PSGCJwUvheSNh-gc3NiJjKpMY7zBVWPOe7Fu8bqSbLeKIvKY888LIf2s0uUrfFW8PxTDIrIPqTE5ABipRVvaQdcOXWVg84UWxKt0i40oF2KDTJKRNyGAUybyCxw",
    },
    {
      "title": "Suraj Hua Maddham",////////////////
      "singer": "Sonu-Alka-Sandesh",
      "url":
          "https://0yllaw.by.files.1drv.com/y4mgE9ZiY10hNwJqSOpw-uuEin3IaIYNvTLKMZ4g6ul388AhhPzimgpGz6IiPOFIJ893_rmwgXM2RBv2ZedLpkE_m0EiYg3iZrqVLWUOKnceHA2dTXZN3BdK0aOqdppPNEN7owbXSEJN0H92l3PluWxQ4188TgQxayYS17K_Kj1FxMKJ4PbHSfF4brcGs39Z0qJjm-YCP6l51sok-EHGY1zDw",
      "cover_url":
          "https://0ynk9g.by.files.1drv.com/y4m-bbPXjGEV958ECG6TLOlQtKBpBejD0iuIeFiFUefR7LmxyAeEbvCfxko8mjNWnpCAUo3C4FaXHlS7M89Enh3qu6sP5W2PcJMX3A-032-sNOa6FOaCuCEKFP5hNycPItafB1Kemf22j72qhQqpPzHMCDX_WBJ-oscBnXVaKnbvJuQrykRyvP7AoWiigkn4fiTqrF9gp2Hl-zc70TDYuF7ng", //correct
    },
    {
      "title": "Le Challang",////////////
      "singer": "Daler Mehndi",
      
      "url":
          "https://nhuqmw.by.files.1drv.com/y4mQmhcD8QCPCPWDIQdv4V_81AaX8vjadiLI580OuXwRjb0vEyJdd4f2CagSweg00hv3PSSDClAAW9Zlo3CPJO9DXFr53zrwMku0nBdEgfuvt58oSjvI9k0lkr6zTRRl80mFRS2NwfrsSJVxbPc7fUa67diquAUCXPA5TL7oCQTKtyt6kZh03s6rMzDjYk7f1auE-YL4r4JRJRy0vQyx1m-RQ",
      "cover_url": "https://nhwpjg.by.files.1drv.com/y4mZCkF76twKaedv_8ha-b_meQzMiCTnDQLaHS1siv0Rzdn3qo-Y2suzGTomJKCLj4G-Smn3807sJqGHQAc9DDFYmy_RsiDwynRzyXdDwUkSxb9F888KwFxSB9FQj2NYFnMdyASwxgvKMe3JR02QmAO2wjKDfxMbP0E3Gd0TfB8A80tPJRA0MLZL4WSa59z8VLuF1DPk92nuNGYQlAHDlghzQ",
    },
    {
      "title": "Nazm Nazm",/////////////
      "singer": "Arko Pravo Mukherjee",
      "url":
          "https://bp5c9w.by.files.1drv.com/y4m4N3yEvl5EP2jaSa269eNAq71RsIB6QSTuib0Blm3UVPjTlv_pKLFqs3FiMsJAw_DXcICbQ9v7fgEeE7IJrbNM09_buFCXPGxuiQZmUUf8FdZlo6lWuNLQiJ0Yfr825cef-wKIKrueC8O-cho2Kmr7IVst_dUaEOXpnNYt67FjWjahx81kr5CDosrlMWxR9XCgulPueNmoWuO8aHB0MPywA",
      "cover_url": "https://nhwi3w.by.files.1drv.com/y4mF-S3pU9Y31yMG45njvPDcqlh1OvX59_qDtbjHJPkoKuSvO9Ui_7EFq-bIT3v7NwvSnJw-zyArF40DQH8QWmA8vlhi5WLb_4-1ACi6KcjleZHdij68owdOTJrKfJfjd8nugmSs9N4EBG4kzDEHknbQdjOj2TI1Q_v3FjfcVXXh3srmEQVFgh-KMmqZtXGXjqUtuvvOYQfIgrr_xqprcfbqw",
    },
    {
      "title": "Wakhra Swag",
      "singer": "Eugenio Mininni",
      "url":
          "https://0ymp4g.by.files.1drv.com/y4m8ca5TXxNPyDRdsJmVzjcN4ZLhbbNx1fJoPXi2-LHQmV8Fk5qXwGVS8VeBiPK3K8JUCFbh6fw-Yli-7Ic7oYD5sigJDdfzbiwW4zhjgrOlMzZQMpdTZcZTYOJFbnw2F0WgSHyY3Cffpg-GMm1RdCzI3Tmjhoa-l7bnlIbdyQy8xpzcXQ2s8kZpbNL8m69880CNIR4-RqePTy0Ia-sknhnTA",
      "cover_url": "https://0ylevw.by.files.1drv.com/y4mAuJjPhVOIQPhHlmaWMqigSHMnuyXF82PGg4pNtn9p2yC8cl6DUeOMUa-ZhUOn1cozk2Vx4XTtiwssryPN5cqo1eCtN7Q-YBl5f8H5oPGzrA3lpL264ZybJjTEmNaqQzg2mk4mT2cm0TPnqpHSilOjNCpcj7MmwAhvbPhuStHH85BdLbrVPCVS6I-a6qhxxzjQZXiRkqwW7QZVkqe_BldSQ",
    },
    {
      "title": "Ek Tarfa",///////
      "singer": "Darshan Raval",
      "url":
          "https://nhxfdw.by.files.1drv.com/y4mT9blZz6MSmkZR-oShRTu20BVPGMrRa-xMmDVC_pJuo1aTM5gxQMTCdXw6Gouvms3yBPXfXgDYmMPQ7hqGU8MAoSB649SeLReZKdJ_RTwjG0FnAcM0_9Qu0okb2Dl11OByVevKtw2K5evWG--6xASNqCSxtccmqUI3LH-chYXnarRXkQ-SeDXvlrw6SgEvMz0kIcy7R2vZ1F9ExECp70-MA" ,
         
      "cover_url": "https://bp544a.by.files.1drv.com/y4mtQ09DowFS8-6qWpCzVfLiF4CB3o374tEY3LkYTZvWUWMH_jThoWrM3e3JWY-YMmRrvyNdj9eEP6rmq0ebBQfivoZMAD10REeICXG3kyj0keabXsMMmp9SZuUc3nu2HVTkSY8ekIOPg8uNxqENKa81RsSgGzdkPHF7HrpS4BwFd68-DZ0SqwA-dQIpr8HAKbSej55njXjGijKlETmEsRRfA",
    },
    {
      "title": "Namo Namo",///////////////////
      "singer": "Amit Trivedi",
      "url":
          "https://bp7daw.by.files.1drv.com/y4mzMHWIir_PH1JwxQ4fOFXaSZU3-qAtvRLRIVvhLWIVqKT0CsbUlhwbm6BRW9AwScvQqZrJFAWQWLqIfS0l7QZsSo_2c3ph_b2dwrmFNR-oVh0thMJymvORDlSUpUtzyB3e8nyJJgiVukRLh4ZFFY8PRb3_NBi_9f6oFhatCrGy5q-Z5bC9FQ27c0YZRptrtbxCfe4p3w8CM93-8opXlk3bA",
      "cover_url": "https://0ymbva.by.files.1drv.com/y4mzzk_acdaxxYEREVSyTY6sDpp6bCDJZE0FnF_Zi71gSgtY1MqRpXUExum6dXFzYQ8xLkdRG9Q-p3kMhjKBNccCvJQ-SAyGzIunrml-foYGUFUH0vyi-tItBqQL-2XjiiJGHE4G2REyja7bEsl4cD3Mlnk_Z-GXF6_W4e5XwVjowXhzGG2-xhK4OLfDPi7I-WRPm86-auSlaRj6HuVkihUhw",
    },
    // {
    //   "title": "Le Challang",//////////////////////
    //   "singer": "Daler Mehndi",
    //   "url":
    //       "https://nhuqmw.by.files.1drv.com/y4mxQHzmDEscAryl-fGWSFJdukJ1eoh9hfVEt2kOSbbUn01NOnPwbwcnpkhcWB9z_G6cUl08EMDz5BLuGajNsPkK0UI1Mtpj776HTTluB-VGbXw9d9YqDbIno54djWXoLkX50Dt11N8IsTmY5YWksFR-x5xQv5FzRkVKqr7LUfTci93hlPiyoZkAmqvh2j3bMyc8t0bDBIwYbhMCE-uykfN0w",
    //   "cover_url": "https://nhwpjg.by.files.1drv.com/y4m-QytbKvxhjYo8witYPkI7fUkqDFnsGg7uY9PlIT_giUf8tMBgbHp-h11qC2YyVcE05UHOjfVjBehx1qnYKvbm4hSB0H9iAysCpBwUtA8jj-3ghbOG1l54pD75BVALR2IYixH4LDIIn7lF1lkUv7jzEo-cIVQ0Coxtn0TOweh_NJMJcVBNIAr3kVSu35FByDaE_xYuCb1hw-MYvEAibEeLA",
    // },
    {
      "title": "Agar Tum Sath HO",///////////////////////
      "singer": "Arijit-Alka",
      "url":
          "https://0yk2yq.by.files.1drv.com/y4mfyD1C3x_WqdZ3tBvwAbIoR5WJlo6In1QWDbPdqbGrt1xSECc9o1lBBrcWqcMWhZ-kw4OHqkmEpCt9cTt_Bd-MrJT9ZEsMd57oFgvQ04inuO6fI3ZhJgTWN4CIJNAy29k3MA_tisp7OoZFJjdTJ4_CRXS8TUGFSlTp2R9ePTLCcJmAb1L-f2mUCW14P3R5qjZ0zwRORjzkIzfU4QUJerTSQ",
      "cover_url": "https://0ylssg.by.files.1drv.com/y4mges7dud69ABm6ACAgvncNcBhgwWtdKes75utRkGOGDjQxNqOeHY7bKNzAX_1zh7ocbr4MPl5RY9fmdFPXciHRZzV7jO2Az3tYU_Ykgnxk2gzz-fTh2oIxs-holRTZYas4iUGTtLa9bh6z01YGYB0eB_IzVapyYHUv7ied4E8FaGQcO12f0vnD7GA1JcZ0xRvTyXjLGlBAeTQuxOrCBdX5Q",
    },
  ];
  
  String currentCover = "";
  String currentTitle = "";
  String currentSinger = "";
  Duration duration = new Duration();
  String du = "0:0 ";
  String pos="0:0";
  Duration position = new Duration();
  AudioPlayer audio = new AudioPlayer();
  bool isPlaying = false;
  String currSong = "";
  void setDuration(){
    setState(() {
        if((audio.duration.inSeconds % 60) <=9){
          du = ((audio.duration.inSeconds / 60).floor().toString() +
            ":0" +
            (audio.duration.inSeconds % 60).toString());
        }
        else{
        du = ((audio.duration.inSeconds / 60).floor().toString() +
            ":" +
            (audio.duration.inSeconds % 60).toString());
        }
      });
  }
  void setPosition(){
    setState(() {
        if((position.inSeconds % 60) <=9){
          pos = ((position.inSeconds / 60).floor().toString() +
            ":0" +
            (position.inSeconds % 60).toString());
        }
        else{
        pos = ((position.inSeconds / 60).floor().toString() +
            ":" +
            (position.inSeconds % 60).toString());
        }
      });
  }
  void playMusic(String url) async {
    if (isPlaying && currSong != url) {
      audio.stop();
      setState(() {
        isPlaying = false;
        position= Duration(seconds: 0);
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
        print(position.inSeconds.toString()+" gfjfjhkjbhljbljninliblubliblubljbublkib");
        setPosition();
        setDuration();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Music App",
          style: TextStyle(color: Colors.black),
        ),
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
                  playMusic(musicList[index]['url']);
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
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Color(0x55212121),
                blurRadius: 8.0,
              ),
            ]),
            child:
            currSong.length==0?Container(): 
            Column(
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
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              currentSinger,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
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
