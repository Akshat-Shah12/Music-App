import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//adding new movie names
void setMusicNames(String x) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String names = pref.getString("singer");
  List<String> namesList = <String>[];
  int initial = 0;
  for (int m = 0; m < names.length; m++) {
    if (names[m] == "|") {
      namesList.add(names.substring(initial, m));
      initial = m + 1;
    }
  }
  if (!namesList.contains(x)) {
    names = "${names}${x}|";
  }
  pref.setString("singer", names);
}

//removing name from the local database
void removeMusicName(String x) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String names = pref.getString("singer");
  int initial = 0;
  List<String> namesList = <String>[];
  // names = "${names}${x}|";
  for (int m = 0; m < names.length; m++) {
    if (names[m] == "|") {
      String sub = names.substring(initial, m);
      if (sub.toString().trim() != x.toString().trim()) {
        namesList.add(sub);
      }
      initial = m + 1;
    }
  }
  names = "";
  for (int i = 0; i < namesList.length; i++) {
    names = "${names}${namesList[i]}|";
  }
  pref.setString("singer", names);
}

// Option that comes when 3 dots button is clicked
Widget SongPopUpMenuButton(String t) {
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
          value: "playlist",
          child: Row(
            children: [
              Text(
                "Add to Playlist",
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
      if (val == "playlist") {
        setMusicNames(t);
      }
    },
  );
}

//Option that comes when 3 dot button is clicked in My PlayList
Widget RemoveFromPlaylistPopUpButton(String t,Function elementRemove) {
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
          value: "remove",
          child: Row(
            children: [
              Text(
                "Remove from Playlist",
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
      if (val == "remove") {
        elementRemove(t);
        removeMusicName(t);
      }
    },
  );
}

Widget customListTile(
    {String title, String singer, String cover, onTap, String playList,Function elementRemove}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.only(left: 10, bottom: 8),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    image: DecorationImage(image: NetworkImage(cover)),
                  ),
                ),
                SizedBox(
                  width: 13,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      singer,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            playList == "My Playlist"
                ? RemoveFromPlaylistPopUpButton(title,elementRemove)
                : SongPopUpMenuButton(title),
          ],
        ),
      ),
    ),
  );
}
