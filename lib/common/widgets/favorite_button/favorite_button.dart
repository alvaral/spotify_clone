import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_flutter/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify_clone_flutter/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify_clone_flutter/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_flutter/domain/entities/song/song_entity.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;
  const FavoriteButton({
    super.key,
    required this.songEntity,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          bool isFavorite = songEntity.isFavorite;
          if (state is FavoriteButtonUpdated) {
            isFavorite = state.isFavorite;
          }

          return IconButton(
            onPressed: () {
              context
                  .read<FavoriteButtonCubit>()
                  .favoriteButtonUpdated(songEntity.songId);
              if (function != null) {
                function!();
              }
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_outline_outlined,
              size: 25,
              color: AppColors.darkGrey,
            ),
          );
        },
      ),
    );
  }
}
