// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:core';

import 'package:meta/meta.dart';
import 'package:explorer_app/FileStorage/station_entity.dart';
import 'package:explorer_app/FileStorage/ServerAccess.dart';
import 'file_storage.dart';
import 'web_client.dart';

abstract class StationsRepository {
  /// Loads stations first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Stations from a Web Client.
  Future<List<StationEntity>> loadStations();

  // Persists stations to local disk and the web
  Future saveStations(List<StationEntity> stations);
}

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Stations and Persist stations.
class StationsRepositoryFlutter implements StationsRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const StationsRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  /// Loads stations first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Stations from a Web Client.
  @override
  Future<List<StationEntity>> loadStations() async {
    ServerAccess server = ServerAccess();
    try {
      return await fileStorage.loadStations();
    }  catch (e) {
      final stations = await server.fetchStations();
      fileStorage.saveStations(stations);
      return stations;
    }
  }

// Persists stations to local disk and the web
  @override
  Future saveStations(List<StationEntity> stations) {
    return Future.wait<dynamic>([
      fileStorage.saveStations(stations),
      webClient.postStations(stations),
    ]);
  }
}
