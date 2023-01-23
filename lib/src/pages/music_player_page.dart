import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/src/helpers/helpers.dart';
import 'package:music_player/src/models/audioplayer_model.dart';
import 'package:music_player/src/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';


class MusicPlayerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Background(),

              Column(
              children: <Widget>[
                
                CustomAppBar(),
          
                ImageDiscDuration(),
          
                TitlePlay(),
          
                Expanded(
                  child: Lyrics()
                )
          
          
              ],
            ),
        ]
      )
   );
  }
}

class Background extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: screenSize.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(60)),
        gradient: LinearGradient(

          begin: Alignment.centerLeft,
          end: Alignment.center,

          colors: [
            Color(0xff33333E),
            Color(0xff201E28),
          ]
        )
      ),
    );
  }
}

class Lyrics extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {

    final lyrics = getLyrics();

    return Container(
      child: ListWheelScrollView(
        physics: BouncingScrollPhysics(),
        itemExtent: 42,
        diameterRatio: 1.5,
        children: lyrics.map(
          (line) => Text(line, style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.6)))
        ).toList(),
      ),
    );
  }
}

class TitlePlay extends StatefulWidget { 

  @override
  State<TitlePlay> createState() => _TitlePlayState();
}

class _TitlePlayState extends State<TitlePlay> with SingleTickerProviderStateMixin{

  bool isPlaying = false;
  bool firstTime = true;
  late AnimationController playAnimation;


  final assetAudioPlayer = new AssetsAudioPlayer();

  @override
  void initState() {

    playAnimation = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    
    super.initState();
  }

  @override
  void dispose() {
    this.playAnimation.dispose();
    super.dispose();
  }

  void open(){

    final audioPlayerModel = Provider.of<AudioPlayerModel>(context, listen: false);

    //assetAudioPlayer.open('assets/Dear_Someone.mp3');
    assetAudioPlayer.open(Audio('assets/Dear_Someone.mp3'));

    assetAudioPlayer.currentPosition.listen((duration){
      audioPlayerModel.current = duration;
    });

    assetAudioPlayer.current.listen((playingAudio) {
      audioPlayerModel.songDuration = playingAudio.audio.duration;
      //audioPlayerModel.songDuration = playingAudio?.audio.duration ?? Duration(seconds: 0);
    });
  }

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
            child: AnimatedIcon( 
              icon: AnimatedIcons.play_pause,
              progress: playAnimation,
              ),
            onPressed: (){

              final audioPlayerModel = Provider.of<AudioPlayerModel>(context, listen: false);

              if (this.isPlaying){
                playAnimation.reverse();
                this.isPlaying = false;
                audioPlayerModel.controller.stop();
              }else{
                playAnimation.forward();
                this.isPlaying = true;
                audioPlayerModel.controller.repeat();
              }

              if (firstTime){
                this.open();
                firstTime = false;
              }else{
                assetAudioPlayer.playOrPause();
              }
            }
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
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    final percentage = audioPlayerModel.percentage;

    return Container(
      child: Column(
        children: [

          Text('${audioPlayerModel.songDuration}', style: style),
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
                  height: 230 * percentage,
                  color: Colors.white.withOpacity(0.8)
                             ),
               ),  

            ],
          ),
          SizedBox(height: 10,),
          Text('${audioPlayerModel.currentSecond}', style: style),

        ],
      ),
    );
  }
}

class ImageDisc extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {

    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);

    return Container(
      padding: EdgeInsets.all(20),
      width: 220,
      height: 220,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: [

            SpinPerfect(
              duration: Duration( seconds: 10),
              infinite: true,

              manualTrigger: true,
              controller: (AnimationController) => audioPlayerModel.controller = AnimationController,

              child: Image( image: AssetImage('assets/Cover.jpg'))
              ),

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