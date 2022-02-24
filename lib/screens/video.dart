import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final asset = 'assets/surge.mp4';
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.asset(asset)
      ..addListener(() => setState(() {}))
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(controller: controller);
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;
  const VideoPlayerWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) => controller.value.isInitialized
      ? Container(alignment: Alignment.topCenter, child: buildVideo())
      : Container(
          height: 200, child: Center(child: CircularProgressIndicator()));

  Widget buildVideo() => Stack(
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(child: BasicOverlayWidget(controller: controller))
        ],
      );
  Widget buildVideoPlayer() => Center(
        child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller)),
      );
}
class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;
  const BasicOverlayWidget({ Key? key,required this.controller }) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Positioned(
        bottom: 30 ,
        left: 0,
        right:  0,
        child: buildIndicator(),)
    ],
  );

 Widget buildIndicator() => VideoProgressIndicator(controller, allowScrubbing: true);
}