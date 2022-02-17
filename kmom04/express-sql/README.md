# Krav
- Dina klienter kommer att testas mot den databas som finns i exemplet “Transaktioner i databas”. Du kan alltså inte göra ändringar i databasens struktur. []

- Flytten av pengar skall alltid utföras inom ramen för en transaktion. []

- Din webbklient skall startas utifrån skriptet index.js med node index.js. []

- Inloggningsdetaljer till databasen skall sparas i config/db/bank.json och delas mellan webbklient och terminalklient. []

- Din webbklient har en sida bank/index som hälsar välkommen till banken och visar en meny över de saker man kan göra. []

- Din webbklient har en sida bank/balance som visar en kontoöversikt. []

- Bygg vidare på din webbklient och lägg till en sida bank/move-to-adam. Varje gång man går in på den sidan skall det flyttas 1.5 pengar från Eva till Adam. Sidan visar bara ett tackmeddelande från Adam som tackar för pengarna. []

- Sidlayouten skall vara gemensam header och footer för samtliga sidor. []

- Det skall finnas en meny i header som ger en navigeringsmöjlighet mellan de sidor som är relaterade till banken. []

- Bygg ett terminalprogram och spara main-funktionen i cli.js. Terminalprogrammet skall startas med node cli.js. []

- Kod, funktioner, moduler och klasser som delas mellan webbklienten och terminalklienten placerar du i katalogen src/ och de skall sedan importeras till de mainprogram som använder dem. []

- Ditt terminalprogram skall fungera som en oändlig kommandoloop där man kan skriva in kommandon som programmet utför. Det skall finnas ett kommando menu som visar menyn med samtliga kommandon. När man skriver kommandot exit skall programmet avslutas. []

- I terminalprogrammet, skapa kommandot move som flyttar 1.5 pengar från Adam till Eva (notera att webbklienten flyttar pengar i motsatt riktning). TIPS: se första extrauppgiften nedan, det kan förenkla din implementation. []

- I terminalprogrammet, skapa kommandot balance som visar en översikt av de konton som finns och kontobehållningen. []

- Validera din kod. []

# Flytta till kurskatalogen
```
dbwebb validate express-sql

dbwebb test express-sql
```
Rätta eventuella fel som dyker upp och publisera igen. När det ser grönt ut så är du klar.

------------------
# Extrauppgift
Gör följande om du har tid och ro.

- Se till att skriva en funktion som flyttar pengarna och dela den mellan webbklienten och terminalklienten. Funktionen kan ta parametrar för fromAccount, toAccount och amount. Då får du en god kodstruktur. []

- Lägg till kommandot move <amount> i din terminalklient, eller gör det ännu mer flexibelt med move <amount> <from> <to>. []

- Snygga till din webklient med CSS och se över så att navigeringen är smidig mellan sidorna. []