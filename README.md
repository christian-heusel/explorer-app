# Explorer 2023 App

Diese App soll für den [Explorer 2023](https://www.ejwue.de/arbeitsbereiche/jungenarbeit) die Auswertung erleichtern. Der Explorer soll vom 08. Juni - 011. Juni auf der [Dobelmühle](http://www.dobelmuehle.de/) in Aulendorf stattfinden.

Problem bei der Auswertung ist, dass die alle Teams zum Ende der 33 Stunden gleichzeitig ihre Tourbücher abgeben und die Ergebnisse dann von den Aufschrieben digitalisiert werden müssen, was sehr viel Arbeit und Stress für das Auswertungsteam bedeutet.


## Teilprojekte

### App

Die Dateneingabe und Synchronisation der Ergebnisse an den einzelnen Stationen soll über eine App funktionieren:  
[`fluttr_app/explorer_app/`](./fluttr_app/explorer_app/)


### Backend

Die Speicherung der Eingaben funktioniert über ein in Go geschriebenes Backend mit PostgreSQL:  
[`server/`](./server/)

Dieses Backend soll dann später auch für die Auswertung die Daten bereit stellen, indem ein CSV-File erstellt wird.


### GraphQL-API

Die Datentypen zur Kommunikation werden in einer GraphQL Schittstelle spezifiziert, die dann die Grundlage für die Codegenerierung in App und Backend liefert.
Weiterhin sind hier auch die ER-Diagramme für die einzelnen Teilprojekte hinterlegt.  
[`api/`](./api/)


## Lizenz

Das Projekt ist unter der [GPLv3-Lizenz](https://choosealicense.com/licenses/gpl-3.0/) verlinkt, für mehr Informationen schaut einfach in das [`LICENSE`-File](./LICENSE).


## Mitmachen

Stelle gernen einen [Pullrequest](https://github.com/christian-heusel/explorer-app/pulls) mit neuem Code, macht ein [Issue](https://github.com/christian-heusel/explorer-app/issues) hinsichtlich eines Problems/Verbesserungsvorschlags auf oder schreibt eine Mail an christian@heusel.eu, falls ihr eine Einführung in die Projektstuktur braucht!
