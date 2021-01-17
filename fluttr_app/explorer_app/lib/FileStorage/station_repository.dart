// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'package:explorer_app/models/station.dart';

abstract class StationsRepository {
  Future<void> addNewStation(Station station);

  Future<void> deleteStation(Station station);

  Stream<List<Station>> stations();

  Future<void> updateStation(Station station);
}
