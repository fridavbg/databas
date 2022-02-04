# Node.js terminalprogram mot MySQL med kommandoloop

[Uppgift](https://dbwebb.se/uppgift/nodejs-terminalprogram-mot-mysql-med-kommandoloop)


## Krav
- [x] Skapa din main-funktion för programmet i filen index.js. Detta är ditt mainprogram och det skall vara så litet som möjligt, resten av koden fördelar du i moduler eller klasser som du importerar till mainprogrammet.

- [x] Skapa katalogen src/ och placera där de moduler/klasser du använder i ditt program. Du skall minst använda en modul, gärna flera.

- [x] Inloggningsdetaljer till databasen skall sparas i config.json och läsas in av programmet.

- [] Om du använder externa moduler för att skriva ut texttabeller så måste modulen finnas i din me/package.json.

- [x] Ditt program skall fungera som en oändlig kommandoloop där man kan skriva in kommandon som programmet utför. Det skall finnas ett kommando menu som visar menyn med samtliga kommandon. När man skriver kommandot exit skall programmet avslutas. Du skall använda readline.prompt med callbackhanterare.

- [] I din meny, skapa kommandot larare som visar all information om lärare, inklusive deras ålder. Minns att du har en vy för detta.

- [] Skapa kommandot kompetens som visar en rapport hur kompetensen ändrats i senaste lönerevisionen.

- [] Skapa kommandot lon som visar en rapport hur lönen ändrats i senaste lönerevisionen.

- []kapa kommandot sok <sokstrang> som söker bland all information hos läraren och visar de lärare som matchar söksträngen.

- [] Skapa kommandot nylon <akronym> <lon> som tar argumenten för lärarens akronym samt den nya lönen och uppdaterar lärarens lön.

- [] Validera din kod och testa din inlämning.

# Flytta till kurskatalogen

```
dbwebb validate terminal2

dbwebb test terminal2
```
Rätta eventuella fel som dyker upp och publisera igen. När det ser grönt ut så är du klar.