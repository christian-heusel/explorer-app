# Teilprojekt: Die Explorer App

Die Dateneingabe und Synchronisation der Ergebnisse an den einzelnen Stationen soll über eine App funktionieren, die die Daten erst lokal speichert und dann an geeigneten Stationen dann mit dem Backend synchronisiert.

Die App ist mit dem [Flutter-Framework](https://flutter.dev/) geschrieben, da man so einen sehr produktiven Workflow sicher stellen kann, die App auf vielen Plattformen (Android, iOS, Web) läuft und eine integration mit GraphQL besteht.  

Alle zugehörigen Issues sollten mit dem Label ["App"](https://github.com/christian-heusel/explorer-app/labels/App) gekennzeichnet.

## Ausführen

Die Assetdatei richtig ausfüllen und umbenennen / kopieren:

```
cp assets/cfg/config_settings.json.example assets/cfg/config_settings.json
```

Die App mit flutter ausführen:

```
flutter run
```

## Typengenerierung aus der GraphQL API

Die Typengenerieung funktioniert mit [graphql-flutter](https://github.com/zino-app/graphql-flutter) und [artemis](https://github.com/comigor/artemis).

```
flutter pub run build_runner build
```