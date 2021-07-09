import 'package:flutter/material.dart';
import 'package:music_app/englishSongs.dart';

class categoriesScroller extends StatefulWidget {
  final List musicList = [];
  categoriesScroller({Key key, musicList}) : super(key: key);

  @override
  _categoriesScrollerState createState() => _categoriesScrollerState();
}

class _categoriesScrollerState extends State<categoriesScroller> {
  List musicListCopy = [];
  List musicList=[];
  @override
  void initState() {
    super.initState();
    musicList.add(musicList);
  }
  void openPage(String option) {
    setState(() {
      musicListCopy = [];
      if (option=="engbest") {
        for (int i = 0; i < musicList.length; i++) {
          if (musicList[i]["language"] == "eng") {
            musicListCopy.add(musicListCopy[i]);
          }
        }
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => EnglishSongsList()));///////////
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 480,
        margin: EdgeInsets.only(top: 0, left: 20, right: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  openPage("engbest");
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
              Container(
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
              Container(
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
            ],
          ),
        ),
      ),
    );
  }
}
