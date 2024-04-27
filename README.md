# LigaTipps

Für Fans von SQL und der (1., 2., 3.) Fußball-Bundesliga ⚽⚽.

## Länderspezifika
Es gelten die Regeln der deutschen Fußball-Bundesliga. Die Datenbank ist aber im Wesentlichen kompatibel zu einigen anderen europäischen Ligen mit einem ähnlichen System. Am wichtigsten ist die Punktevergabe: 3 Punkte für Siege, 1 Punkt für Unentschieden, 0 Punkte für Niederlagen.

Siehe auch ![Premier League](https://en.wikipedia.org/wiki/2018%E2%80%9319_Premier_League)

## Datenbankstruktur und Installation
Siehe doc-Verzeichnis, dort ist eine Installationsanleitung.
![Relationen siehe doc/assets/relations_matches.png](doc/assets/relations_matches.png "Datenbank-Übersicht")

## Eintragen
Man trägt die für die Spieltage angesetzten Begegnungen ein. Derzeit erfolgt das unkomfortabel über eine reine Zahlentabelle.<br>
Eine Eingabeprozedur oder gar eine Formularanwendung mit Drop-Down-Auswahlliste gibt es derzeit (noch) nicht...<br>
Dafür berechnet SQL automatisch die Punkte und Tore der beteiligten Mannschaften, sobald man ein Spielergebnis ausgefüllt hat.

## Sichten
Ansichten der Spieltage und die Ligatabelle<br>
Wer wissen möchte, auf welchem Platz sein Club gerade steht, erfährt das über die Query_Ligatabelle.<br>
Diese geordnete Abfrage der Ligatabellansicht zeigt die aktuelle Platzierung nach Punkten und Tordifferenz.

## Tippspiel
Eine Tippfunktion wird es auch geben, steckt momentan in den Anfängen 👩‍💻
