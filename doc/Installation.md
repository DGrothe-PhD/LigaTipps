# Installation

## Prerequisites
This database was first developed on Windows 8 using the following 
* [SQL Server Express 2019](https://learn.microsoft.com/en-us/sql/sql-server/what-s-new-in-sql-server-2019?view=sql-server-ver15) 
* SQL Server Management Studio (SQL database editor)
[SSMS2019](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15)

Newer Windows or SQL &hellip;  versions are supported as well.

## Skripte
Am einfachsten ist es per Master-Skript. \
Dies umfasst auch die Punktupdatefunktion, soweit ich das bereits implementiert habe. \
Für 2024/25 sind bereits alle Spieltage und teilnehmenden Vereine angelegt, nicht jedoch die Begegnungen, da bis dato noch nicht bekannt.

Installation geht folgendermaßen:
1. Sicherstellen, dass es einen Pfad `C:\SQL-Kurs\DB\Bundesliga\` gibt bzw. diesen anlegen.
2. Falls dort, etwa vom Vorjahr, noch eine Datenbank liegen sollte, diese über SQL Server Management Studio (SSMS) von Hand löschen.
3. Im Verzeichnis `sql/` liegt ein Masterskript für die nächste Bundesligasaison.
   
# Unerledigte Funktionen

1. Tippfunktionalität implementieren: Punkte für Bedingungen (richtige Differenz usw.)
2. Tipperpunkte automatisch ausrechnen und zusammenfassen lassen
