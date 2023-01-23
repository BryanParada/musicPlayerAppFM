import 'package:flutter/material.dart';
import 'package:music_player/src/widgets/custom_appbar.dart';


class MusicPlayerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          
          CustomAppBar(),

          ImageDiscDuration(),

          TitlePlay(),


        ],
      )
   );
  }
}

class TitlePlay extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 45),
      margin: EdgeInsets.only(top: 50),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text('Dear Someone', style: TextStyle( fontSize: 30, color: Colors.white.withOpacity(0.8))),
              Text('-Mystery-', style: TextStyle( fontSize: 15, color: Colors.white.withOpacity(0.8))),
            ],
          ),

          Spacer(),

          FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: Color(0xffF8CB51),
            child: Icon(Icons.play_arrow),
            onPressed: (){}
            ),

        ],
      ),
    );
  }
}

class ImageDiscDuration extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only( top: 70),
      child: Row(
        children: [
 
          ImageDisc(),
          SizedBox(width: 20,),

          ProgressBar(),
          SizedBox(width: 20,),

        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final style = TextStyle(color: Colors.white.withOpacity(0.4));

    return Container(
      child: Column(
        children: [

          Text('00:00', style: style),
          SizedBox( height: 10,),
          Stack(
            children: <Widget>[

              Container(
                width: 3,
                height: 230,
                color: Colors.white.withOpacity(0.1)
              ),

               Positioned(
                bottom: 0,
                 child: Container(
                  width: 3,
                  height: 150,
                  color: Colors.white.withOpacity(0.8)
                             ),
               ),  

            ],
          ),

          Text('00:00', style: style),

        ],
      ),
    );
  }
}

class ImageDisc extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 220,
      height: 220,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image( image: AssetImage('assets/Cover.jpg')),

            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.black38, 
                borderRadius: BorderRadius.circular(100)
              ),
            ),

            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Color(0xff1C1C25), 
                borderRadius: BorderRadius.circular(100)
              ),
            ),


          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            Color(0xff484750),
            Color(0xff11C24),
          ]
        )
      ),
    );
  }
}