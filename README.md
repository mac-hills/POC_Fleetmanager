# fleetmanager

Dit is een POC applicatie die tools biedt voor het beheer van voertuigreserveringen.

## Programmeertaal

Flutter

## Link naar filmpje

[Bekijk de demo](https://youtu.be/yTeLTykJVqc)

## Korte beschrijving

Deze applicatie is een hulpmiddel voor vlootbeheerders om voertuigreserveringen efficiënt te beheren. 
Ze stelt voertuigbestuurders in staat om toegang te krijgen tot hun werkschema's 
en ze biedt een gebruiksvriendelijke interface voor anderen om informatie op te vragen over de beschikbaarheid van voertuigen.

## Lijst van schermen

* Login / register
* Calendar / welcome
* Show Vehicles (vehicles + details)
* Settings
* About
* Log Out 
* Reservations 

## Extra info

### Custom app launcher icon
Custom app launcher icon in plaats van de standaard flutter "F" 

### Custom splash screen
Tijdens het laden van de app is de standaard Flutter "F" ook vervangen door een custom app icon

### Welkomst boodschap in appbar
In de appbar verschijnt afhankelijk van de gebruikers rol een andere boodschap:
* rol "driver": "Welcome" + de naam van de aangemelde gebruiker + This is your schedule:
* rol "guest" of "admin": boodschap -> "Welcome" + de naam van de aangemelde gebruiker
 
### Menu items in het appbar menu zijn afhankelijk van de rol van de aangemelde gebruiker
* rol "driver" of "guest": slechts 4 menu items -> "Show vehicles", "Settings", "About", "Log out"
* rol "admin": 6 menu items -> "Show vehicles", "Add vehicle", "Settings", "About", "Log out", "Reservations"

### Aangepaste appbar op de "Log Out" pagina
Zolang de gebruiker aangemeld is, staat er een menu aan de rechterkant in de appbar van de "Log Out" pagina en een melding "Go back" aan de linkerkant met een pijl om terug te keren naar de vorige pagina.
Als de gebruiker op de "Log out" knop klikt, dan verdwijnt het menu aan de rechterkant en veranderd de melding naar "Go to the log in page".

### Loading indicator
Als gegevens worden opgehaald uit de database (Cloud Firestore) dan verschijnt er een loading indicator tijdens het laden.

### De welkomstpagina is anders afhankelijk van de rol van de gebruiker
* Een admin heeft een werkweek overzicht in de kalender van de welkomstpagina
* Een gebruiker heeft een week overzicht in de kalender van de welkomstpagina
* Een chauffeur heeft een lijstoverzicht van zijn planning bij de kalender van de welkomstpagina

### De "Add Vehicle" pagina haalt relevante gegevens uit de database
Om het voor de admin iets gemakkelijker te maken, worden de namen van chauffeurs en van garages opgehaald uit de database om ze in een dropdown selectie menu te kunnen presenteren.
De admin kan dan zo een chauffeur uit de Cloud Firestore collectie "fleetmanagerusers" selecteren. Enkel "fleetmanagerusers" met de rol "driver" worden getoond in de dropdownlijst.
De admin kan dan ook een garage uit de Cloud Firestore collectie "address" selecteren. Enkel "address"-en met de rol "garage" worden in de dropdownlijst getoond. 

### De "Add Vehicle" pagina gebruikt input validatie voor het verzenden van de gegevens 
Als een admin een voertuig wilt toevoegen, maar niet al de velden zijn ingevuld of er zijn foutieve gegevens ingevuld, dan verschijnt er een foutmelding als hij op "Add vehicle" klikt.

### Aangepaste icoontjes    
In heel de app worden de icoontjes van de voertuigen aangepast aan het type voertuig dat ze representeren.
Een bus heeft een bus-icoontje, een vrachtwagen heeft een vrachtwagen icoontje...
Naast de kalender view krijgen deze voertuig icoontjes ook de kleur van de reservatiekalender van het voertuig waarbij ze horen.

### Ondersteuning landscape en portrait mode

### Web service / API

* **Firebase Authentication**
wordt gebruikt voor het aanmelden en registreren van gebruikers.

* **Cloud Firestore**
wordt gebruikt als database voor de app.
