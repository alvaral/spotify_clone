import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_flutter/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone_flutter/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_flutter/domain/entities/song/song_entity.dart';
import 'package:spotify_clone_flutter/presentation/home/bloc/play_list_cubit.dart';
import 'package:spotify_clone_flutter/presentation/home/bloc/play_list_state.dart';
import 'package:spotify_clone_flutter/presentation/song_player/pages/song_player_page.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayListCubit()..getPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          log(state.toString());
          if (state is PlayListLoading) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          } else if (state is PlayListLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 16,
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Playlist',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'see More',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _songs(state.songs),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                SongPlayerPage(songEntity: songs[index]),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.isDarkMode
                        ? AppColors.darkGrey
                        : AppColors.grey,
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: context.isDarkMode
                        ? AppColors.grey
                        : AppColors.darkGrey,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      songs[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      songs[index].artist,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
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
                Text(
                  songs[index].duration.toString().replaceAll('.', ':'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_rounded,
                    color: AppColors.darkGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      itemCount: songs.length,
    );
  }
}
