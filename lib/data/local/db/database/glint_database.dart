import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';

part 'glint_database.g.dart';

@Database(version: 1, entities: [ProfileEntity])
abstract class GlintDatabase extends FloorDatabase {
  ProfileDao get profileDao;
}