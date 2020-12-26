# Teilprojekt: Das Backend

Das Backend ist in Go geschrieben und speichert seine Daten in einer PostgreSQL Datenbank.

Alle zugehörigen Issues sollten mit dem Label ["Backend"](https://github.com/christian-heusel/explorer-app/labels/Backend) gekennzeichnet.

## Ausführen

```
sudo docker-compose up --build
```

## Zurücksetzen 
Achtung: Das Kommando löscht alle Daten in der DB!
```
sudo docker-compose down --volumes
```

## Typengenerierung aus der GraphQL API
Die Typengenerierung funktioniert mit [glqgen](https://github.com/99designs/gqlgen) und kann wie folgt genutzt werden:

```
go run github.com/99designs/gqlgen generate
```