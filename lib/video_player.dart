import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_preload_videos/bloc/preload_bloc.dart';
import 'package:flutter_preload_videos/injection.dart';
import 'package:flutter_preload_videos/video_page.dart';

class VideoPlayer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (_) => getIt<PreloadBloc>()
                        ..add(
                          PreloadEvent.getVideosFromApi(),
                        ),
                      child: VideoPage(true,),
                    )),
              );
            },
            child: Text(
              'Video Player Horizontal Mode',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (_) => getIt<PreloadBloc>()
                            ..add(
                              PreloadEvent.getVideosFromApi(),
                            ),
                          child: VideoPage(false),
                        )),
              );
            },
            child: Text(
              'Video Player Vertical Mode',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
