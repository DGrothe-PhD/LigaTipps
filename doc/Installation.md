# Installation

## Prerequisites
This database was first developed on Windows 8 using the following 
* [SQL Server Express 2019](https://learn.microsoft.com/en-us/sql/sql-server/what-s-new-in-sql-server-2019?view=sql-server-ver15) 
* SQL Server Management Studio (SQL database editor)
[SSMS2019](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15)

Newer Windows or SQL &hellip;  versions are supported as well.

## Skripte
Ausführen folgender Skripte (jeweils in SSMS öffnen und ausführen)

1. `sql/SQL1_CreateDatabase.sql`
2. Falls Probleme auftauchen, so eine Meldung erscheint, dass der aktive Benutzer die Datenbank nicht ändern oder ein Diagramm erstellen dürfte, muss einmalig in einem frisch geöffneten leeren Skriptfenster<br>
  <span><pre>use [Bundesliga] EXEC sp_changedbowner 'sa'</pre></span> eingegeben und ausgeführt werden.
3. Skripte aus `spiele` in der nummerierten Reihenfolge ausführen.
4. (optional) Skripte aus `tipper` ebenfalls in der nummerierten Reihenfolge ausführen.
5. Teams und Spieltage anlegen.
6. Begegnungen der einzelnen Spieltage den Teams und den Spieltagen zuweisen.
7. (optional) Tipps eintragen
8. Spielergebnisse eintragen - Ligatabelle wird automatisch aktualisiert
9. (optional) Punktauswertung für die Tipps machen

Schritte, die die Tippfunktion betreffen, sind optional, die Datenbank funktioniert auch als reine Ergebnisdatenbank.

# Unerledigte Funktionen

1. Tippfunktionalität implementieren: Punkte für Bedingungen (richtige Differenz usw.)
2. Tipperpunkte automatisch ausrechnen und zusammenfassen lassen (Trigger)
