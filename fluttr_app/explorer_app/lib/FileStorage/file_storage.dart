// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:explorer_app/FileStorage/station_entity.dart';

/// Loads and saves a List of Stations using a text file stored on the device.
///
/// Note: This class has no direct dependencies on any Flutter dependencies.
/// Instead, the `getDirectory` method should be injected. This allows for
/// testing.
class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
    this.tag,
    this.getDirectory,
  );

  Future<List<StationEntity>> loadStations() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    print('\n test- LOAD: ' + string);
    final stations = (json['stations'])
        .map<StationEntity>((station) => StationEntity.fromJson(station))
        .toList();

    return stations;
  }

  Future<File> saveStations(List<StationEntity> stations) async {
    final file = await _getLocalFile();
    print('\n TESt -Save: ' +
        JsonEncoder().convert({
          'stations': stations.map((station) => station.toJson()).toList(),
        }));
    return file.writeAsString(JsonEncoder().convert({
      'stations': stations.map((station) => station.toJson()).toList(),
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/ArchSampleStorage__$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}
