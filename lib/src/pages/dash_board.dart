import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bucks/src/dashboard/pages/dashboard/dashboardPage.dart';
import 'package:bucks/src/repository/bucks_db_repository.dart';
import 'package:flutter/material.dart';

class DashboardMateriaisModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => BucksDBRepository()),
      ];

  @override
  Widget get view => DashboardMateriaisPage();

  static Inject get to => Inject<DashboardMateriaisModule>.of();
}
