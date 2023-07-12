import 'package:cat_tinder/screens/home_page.dart';
import 'package:cat_tinder/screens/liked_page.dart';
import 'package:cat_tinder/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_tinder/state_management/bloc.dart';

final CatBloc catBloc = CatBloc();

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    catBloc.add(UpdateCat());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: BlocProvider(
          create: (_) => catBloc,
          child: BlocListener<CatBloc, CatState>(
            listener: (context, state) {
              if (state is CatError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                  ),
                );
              }
            },
            child: BlocBuilder<CatBloc, CatState>(builder: (context, state) {
              bool loading = true;
              if (state is CatLoaded) {
                loading = false;
              } else if (state is CatError) {
                return Container();
              }
              return TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    likedPage(liked: false),
                    HomePage(loading: loading),
                    likedPage(liked: true),
                  ]);
            }),
          ),
        ),
        bottomNavigationBar: myBottomNavBar(_tabController));
  }
}
