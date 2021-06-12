import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NotLoaded extends StatefulWidget {
  const NotLoaded({Key key}) : super(key: key);

  @override
  _NotLoadedState createState() => _NotLoadedState();
}

class _NotLoadedState extends State<NotLoaded> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitWave(
            color: Colors.grey[700],
            itemCount: 12,
            type: SpinKitWaveType.center,
            size: 60,
          ),
          SizedBox(height: 50,),
          Text("Made with ❤️ from India",style: TextStyle(color: Colors.black,fontSize: 24,fontFamily: 'RobotoMono'),)
        ],
      );
    
  }
}
