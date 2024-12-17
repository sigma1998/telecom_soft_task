import 'package:flutter/cupertino.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../app/values/colors.dart';
import '../../../../app/values/text_styles.dart';

class CustomYouTubePlayer extends StatefulWidget {
  const CustomYouTubePlayer({super.key});

  @override
  State<CustomYouTubePlayer> createState() => _CustomYouTubePlayerState();
}

class _CustomYouTubePlayerState extends State<CustomYouTubePlayer> {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'PLHddf-1MHY',
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: Container(
        height: 230,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: YoutubePlayer(
                controller: _controller,
              ),
            ),
            const SizedBox(height: 8),
            const Expanded(
              child: Text(
                'Fotiha surasida yo‘l qo‘yilishi mumkin bo‘lgan xatolar ',
                style: AppTextStyles.s14w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
