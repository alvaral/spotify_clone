import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_flutter/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify_clone_flutter/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify_clone_flutter/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_flutter/domain/entities/song/song_entity.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  const FavoriteButton({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
                onPressed: () async {
                  await context
                      .read<FavoriteButtonCubit>()
                      .favoriteButtonUpdated(songEntity.songId);
                },
                icon: Icon(
                  songEntity.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_outline_outlined,
                  size: 25,
                  color: AppColors.darkGrey,
                ));
          } else if (state is FavoriteButtonUpdated) {
            return IconButton(
              onPressed: () {
                context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdated(songEntity.songId);
              },
              icon: Icon(
                state.isFavorite // reads the state, not the songEntity (!)
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                color: AppColors.darkGrey,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
