// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_flutter/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone_flutter/common/widgets/appbar/basic_app_bar.dart';
import 'package:spotify_clone_flutter/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotify_clone_flutter/core/configs/constants/app_urls.dart';
import 'package:spotify_clone_flutter/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_flutter/domain/entities/song/song_entity.dart';
import 'package:spotify_clone_flutter/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify_clone_flutter/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerPage extends StatelessWidget {
  const SongPlayerPage({super.key, required this.songEntity});
  final SongEntity songEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: BasicAppBar(
        title: const Text(
          'Now Playing',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ),
      body: BlocProvider(
        create: (context) => SongPlayerCubit()
          ..loadSong(
            AppURLs.songFirestorage +
                songEntity.artist +
                ' - ' +
                songEntity.title +
                '.mp3?' +
                AppURLs.mediaAlt,
          ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(height: 20),
              _songDetail(context),
              const SizedBox(height: 20),
              _songPlayer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            // ignore: prefer_interpolation_to_compose_strings
            AppURLs.coverFirestorage +
                songEntity.artist +
                ' - ' +
                songEntity.title +
                ' - cover.jpg?' +
                AppURLs.mediaAlt,
          ),
        ),
      ),
    );
  }

  Widget _songDetail(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  songEntity.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  songEntity.artist,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 20),
            FavoriteButton(songEntity: songEntity),
          ],
        ),
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const CircularProgressIndicator();
        }
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                  value: context
                      .read<SongPlayerCubit>()
                      .songPosition
                      .inSeconds
                      .toDouble(),
                  min: 0.0,
                  max: context
                      .read<SongPlayerCubit>()
                      .songDuration
                      .inSeconds
                      .toDouble(),
                  onChanged: (value) {}),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(
                      context.read<SongPlayerCubit>().songPosition)),
                  Text(formatDuration(
                      context.read<SongPlayerCubit>().songDuration))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  context.read<SongPlayerCubit>().playOrPauseSong();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary),
                  child: Icon(
                      context.read<SongPlayerCubit>().audioPlayer.playing
                          ? Icons.pause
                          : Icons.play_arrow),
                ),
              )
            ],
          );
        }

        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
