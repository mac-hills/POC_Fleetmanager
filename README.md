# fleetmanager

Dit is een POC applicatie die tools biedt voor het beheer van voertuigreserveringen.

## Programmeertaal

Flutter

## Link naar filmpje

[Bekijk de demo](https://youtu.be/yTeLTykJVqc)

## Github link en branch

- [GitHub Repository](https://github.com/PXLTINMobDev/opdracht-mobile-development-machielsjohannes.git)
- **Branch:** main


## Korte beschrijving

Deze applicatie is een hulpmiddel voor vlootbeheerders om voertuigreserveringen efficiënt te beheren. 
Ze stelt voertuigbestuurders in staat om toegang te krijgen tot hun werkschema's 
en ze biedt een gebruiksvriendelijke interface voor anderen om informatie op te vragen over de beschikbaarheid van voertuigen.

## Minimale eisen

*Is er voldaan aan alle minimale eisen? Indien niet, licht dit hier kort toe. Een aantal zaken worden elders nog meer in detail toegelicht.*
Alle minimale vereisten zijn voldaan.

## Schermen

## Aantal schermen

Het aantal schermen in de app bedraagt **7**

### Lijst van schermen

*Lijst hier de verschillende schermen van de app op:*

* Login / register
* Calendar / welcome
* Show Vehicles (vehicles + details)
* Settings
* About
* Log Out 
* Reservations 

## Lokale opslag / Shared Preferences

Om de keuze van de gebruiker voor een bepaald UI thema (licht of donker) te bewaren heb ik gekozen om gebruik te maken van lokale opslag.
Dit heb ik als volgt geïmplementeerd:
Ik heb het uitzicht van de thema's licht en donker gedefinieerd in een aparte dart-file met de toepasselijke naam app-theme.dart. Dit bestand is terug te vinden in de "resources" folder van het project.
In de "services" folder van het project heb ik een service dart-file aangemaakt (theme_provider_service.dart). 
Deze service werkt als volgt:

**Initialisatie** (_loadThemeSettings in de constructor):
Wanneer een instantie van ThemeProvider wordt gemaakt, wordt onmiddellijk de _loadThemeSettings-methode aangeroepen tijdens de initialisatie.
De _loadThemeSettings-methode controleert Shared Preferences om te zien of de gebruiker eerder een voorkeur voor een thema heeft ingesteld (bijvoorbeeld lichte modus of donkere modus).
Als er een voorkeur bestaat, worden de thema-instellingen geladen op basis van de opgeslagen waarde. Zo niet, dan wordt er standaard voor lichte modus gekozen.

**Getters** (themeData en isDarkMode):
themeData retourneert het momenteel geselecteerde thema, dat _themeData is.
isDarkMode retourneert een boolean-waarde die aangeeft of de applicatie zich in de donkere modus bevindt, dat _isDarkMode is.

**Methode toggleTheme:**
Deze methode wordt gebruikt om te schakelen tussen lichte en donkere thema's.
Deze accepteert een bool-parameter, isDarkMode, die aangeeft of de donkere modus moet worden ingeschakeld.
Wanneer deze methode wordt aangeroepen, worden _isDarkMode en _themeData dienovereenkomstig bijgewerkt op basis van de parameter isDarkMode.
Vervolgens wordt _saveThemeSettings aangeroepen om de nieuwe thema-instellingen op te slaan in Shared Preferences.
Tot slot wordt **notifyListeners** aangeroepen om eventuele luisteraars (zoals UI-componenten) op de hoogte te stellen dat het thema is gewijzigd.

**Methode _loadThemeSettings:**
Deze methode haalt de opgeslagen themavoorkeur op uit Shared Preferences.
Het gebruikt SharedPreferences.getInstance() om de Shared Preferences-instantie te verkrijgen.
Het controleert of er een boolean-waarde met de naam 'isDarkMode' bestaat. Als dat het geval is, wordt de opgeslagen waarde opgehaald. Zo niet, dan wordt er standaard voor false gekozen.
Vervolgens wordt toggleTheme aangeroepen met de opgehaalde waarde om het thema dienovereenkomstig in te stellen.

**Methode _saveThemeSettings:**
Deze methode wordt aangeroepen wanneer het thema wordt gewijzigd (in toggleTheme).
Het verkrijgt de Shared Preferences-instantie met SharedPreferences.getInstance().
Het stelt een boolean-waarde met de naam 'isDarkMode' in met de huidige waarde van _isDarkMode, wat de voorkeur van de gebruiker voor het thema weerspiegelt.

De hierboven beschreven methodes uit deze service gebruik ik in de views van de app om het ingestelde thema te tonen.


## Extra's

*Beschrijf hieronder de verschillende extra's die in je app aan bod komen, telkens in een aparte sectie*

### Extra 1
Custom app launcher icon
### Beschrijving extra 1
Ik heb een custom app launcher icon gemaakt in plaats van de standaard flutter "F" app launcher

### Extra 2 
Custom splash screen
### Beschrijving extra 2
Tijdens het laden van de app is de standaard Flutter "F" ook vervangen door mijn eigen app icon

### Extra 3
Welkomst boodschap in appbar
### Beschrijving extra 3
In de appbar verschijnt afhankelijk van de gebruikers rol een andere boodschap:
* rol "driver": "Welcome" + de naam van de aangemelde gebruiker + This is your schedule:
* rol "guest" of "admin": boodschap -> "Welcome" + de naam van de aangemelde gebruiker
 
### Extra 4
Menu items in het appbar menu zijn afhankelijk van de rol van de aangemelde gebruiker
### Beschrijving extra 4
* rol "driver" of "guest": slechts 4 menu items -> "Show vehicles", "Settings", "About", "Log out"
* rol "admin": 6 menu items -> "Show vehicles", "Add vehicle", "Settings", "About", "Log out", "Reservations"

### Extra 5
Aangepaste appbar op de "Log Out" pagina
### Beschrijving extra 5
Zolang de gebruiker aangemeld is, staat er een menu aan de rechterkant in de appbar van de "Log Out" pagina en een melding "Go back" aan de linkerkant met een pijl om terug te keren naar de vorige pagina.
Als de gebruiker op de "Log out" knop klikt, dan verdwijnt het menu aan de rechterkant en veranderd de melding naar "Go to the log in page".

### Extra 6
Loading indicator
### Beschrijving extra 6
Als gegevens worden opgehaald uit de database (Cloud Firestore) dan verschijnt er een loading indicator tijdens het laden.

### Extra 7
De welkomstpagina is anders afhankelijk van de rol van de gebruiker
### Beschrijving extra 7
* Een admin heeft een werkweek overzicht in de kalender van de welkomstpagina
* Een gebruiker heeft een week overzicht in de kalender van de welkomstpagina
* Een chauffeur heeft een lijstoverzicht van zijn planning bij de kalender van de welkomstpagina

### Extra 8
De "Add Vehicle" pagina haalt relevante gegevens uit de database
### Beschrijving extra 8
Om het voor de admin iets gemakkelijker te maken, worden de namen van chauffeurs en van garages opgehaald uit de database om ze in een dropdown selectie menu te kunnen presenteren.
De admin kan dan zo een chauffeur uit de Cloud Firestore collectie "fleetmanagerusers" selecteren. Enkel "fleetmanagerusers" met de rol "driver" worden getoond in de dropdownlijst.
De admin kan dan ook een garage uit de Cloud Firestore collectie "address" selecteren. Enkel "address"-en met de rol "garage" worden in de dropdownlijst getoond. 

### Extra 9
De "Add Vehicle" pagina gebruikt input validatie voor het verzenden van de gegevens 
### Beschrijving extra 9
Als een admin een voertuig wilt toevoegen, maar niet al de velden zijn ingevuld of er zijn foutieve gegevens ingevuld, dan verschijnt er een foutmelding als hij op "Add vehicle" klikt.

### Extra 10
Aangepaste icoontjes    
### Beschrijving extra 10
In heel de app worden de icoontjes van de voertuigen aangepast aan he ttype voertuig dat ze representeren.
Een bus heeft een bus-icoontje, een vrachtwagen heeft een vrachtwagen icoontje...
Naast de kalender view krijgen deze voertuig icoontjes ook de kleur van de reservatiekalender van het voertuig waarbij ze horen.

## Ondersteuning landscape en portrait / correct gebruik van Fragments

*Ondersteunt de app zowel landscape als portrait mode? Wordt er correct gebruik gemaakt van Fragments? Beschrijf kort wat de stand van zaken is en hoe dit gerealiseerd werd.*

Ja, de app ondersteunt zowel landscape als portrait mode.
Er wordt door de app afhankelijk van de oriëntatie van het toestel een andere samenstelling van **components** gebruikt voor de opbouw van de weergegeven pagina. 
In Flutter zijn er geen fragments. Om de opbouw van de verschillende oriëntaties te differentiëren heb ik daarom gewerkt met verschillende.dart files per view component.
De naam van deze files heb ik laten eindigen op *view.dart en ze zijn terug te vinden in de directory "components".
Daarnaast heb ik per pagina van de app een apart .dart file gemaakt waarin de voor die weergave vereiste view component worden samengevoegd 
Deze files hun namen eindigen op *page.dart en zin terug te vinden in de directory "pages".
Deze benadering laat de app toe om afhankelijk van de oriëntatie van het toestel de juiste view componenten weer te geven voor elke pagina.

## Web service / API

*Beschrijf hier van welke web service / API er gebruik gemaakt wordt, indien van toepassing. Dit kan bijvoorbeeld ook Firebase zijn.*
* **Firebase Authentication**
Deze API heb ik gebruik om het aanmelden en registreren van gebruikers te implementeren.

* **Cloud Firestore**
Deze API heb ik gebruikt als database voor de app.

## Extra informatie

*Als er nog bepaalde informatie nuttig is om toe te voegen, is daar hier ruimte voor. Je wil bijvoorbeeld aangeven dat bepaalde zaken niet werken zoals voorzien, of niet helemaal zijn afgeraakt.
Of je weet dat er nog een bepaalde bug in de code zit die je niet tijdig opgelost kreeg.*
