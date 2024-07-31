import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone_flutter/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone_flutter/common/widgets/appbar/basic_app_bar.dart';
import 'package:spotify_clone_flutter/core/configs/assets/app_images.dart';
import 'package:spotify_clone_flutter/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone_flutter/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_flutter/core/routing/app_router.dart';
import 'package:spotify_clone_flutter/presentation/home/widgets/news_songs.dart';
import 'package:spotify_clone_flutter/presentation/home/widgets/play_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBackButton: true,
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
        action: IconButton(
            onPressed: () {
              context.pushNamed(AppRoute.profile.name);
            },
            icon: const Icon(Icons.person)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _tabs(context),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                children: [
                  const NewsSongs(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const PlayList(),
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVectors.homeTopCard),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Image.asset(AppImages.homeArtist),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs(BuildContext context) {
    TextStyle tabTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        // width: MediaQuery.of(context).size.width / 1.1,
        child: TabBar(
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColors.primary,
          labelColor: context.isDarkMode ? Colors.white : Colors.black,
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 16,
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 19),
          tabs: [
            Text(
              'News',
              style: tabTextStyle,
            ),
            Text(
              'Videos',
              style: tabTextStyle,
            ),
            Text(
              'Artists',
              style: tabTextStyle,
            ),
            Text(
              'Podcasts',
              style: tabTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
