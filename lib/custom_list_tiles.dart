import 'package:flutter/material.dart';

Widget customListTile({String title, String singer, String cover, onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.only(left: 10,bottom: 8),
          child: Container(
        // decoration: BoxDecoration(color: Colors.grey,),
        child: Row(
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  singer,
                  style: TextStyle(color: Colors.grey, fontSize: 16,),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
