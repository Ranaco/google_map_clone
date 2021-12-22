import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_map_clone/ui/home_page/home_page_view.dart';
import 'package:injectable/injectable.dart';
part 'app.router.gr.dart';
@MaterialAutoRouter(
  replaceInRouteName: "View,Route",
  routes:<AutoRoute>[
    AutoRoute(
      page: HomePageView,
      initial: true,
    )
  ]
)
@singleton
class AppRouter extends _$AppRouter{}