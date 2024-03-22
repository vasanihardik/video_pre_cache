import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_preload_videos/bloc/preload_bloc.dart';
import 'package:flutter_preload_videos/main.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatelessWidget {
  const VideoPage(this.isHorizontalModel);

  final bool isHorizontalModel;


  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: BlocBuilder<PreloadBloc, PreloadState>(
        builder: (context, state) {

          return PageIndicatorContainer(
            length: state.urls.length,
            child: PageView.builder(
              key: navigationService.navigationKey,
              itemCount: state.urls.length,
              scrollDirection: isHorizontalModel ? Axis.horizontal : Axis.vertical,

              onPageChanged: (index) =>
                  BlocProvider.of<PreloadBloc>(context, listen: false)
                      .add(PreloadEvent.onVideoIndexChanged(index)),
              itemBuilder: (context, index) {
                // Is at end and isLoading
                print("IsLoading ==> ${state.isLoading}");
                final bool _isLoading =
                    (state.isLoading && index == state.urls.length - 1);

                return state.focusedIndex == index
                    ? VideoWidget(
                        isLoading: _isLoading,
                        controller: state.controllers[index]!,
                      )
                    : const SizedBox();
              },
            ),
          );
        },
      ),
    );
  }
}

/// Custom Feed Widget consisting video
class VideoWidget extends StatelessWidget {
  const VideoWidget({
    Key? key,
    required this.isLoading,
    required this.controller,
  });

  final bool isLoading;
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        !isLoading
            ? FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Chewie(
                      controller: getChewieController(),
                    )),
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Loading...122')
                ],
              ),
      ],
    );
    //return getVideoView(context);
  }

  ChewieController getChewieController() {
    return ChewieController(
      videoPlayerController: controller,
      autoInitialize: true,
      autoPlay: true,
      showControls: false,
      allowMuting: true,
      looping: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.purple,
        handleColor: Colors.purple,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.purple,
      ),
      placeholder: Container(
        color: Colors.green,
      ),
    );
  }

  Widget getVideoView(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        controller.value.isInitialized
            ? FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Chewie(
                      controller: getChewieController(),
                    )),
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Loading...122')
                ],
              ),
      ],
    );
  }

/*  @override
  Widget build(BuildContext context) {
    return Column(
     crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Expanded(child: VideoPlayer(controller)),
        Center(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              height: controller.value.size.height ?? 0,
              width: controller.value.size.width ?? 0,
              child: VideoPlayer(controller),
            ),
          ),
        ),
        AnimatedCrossFade(
          alignment: Alignment.bottomCenter,
          sizeCurve: Curves.decelerate,
          duration: const Duration(milliseconds: 400),
          firstChild: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CupertinoActivityIndicator(
              color: Colors.white,
              radius: 8,
            ),
          ),
          secondChild: const SizedBox(),
          crossFadeState:
              isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ],
    );
  }*/
}
