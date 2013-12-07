# [Queensland Kids](http://www.queenslandkids.org)

## Concept names:

* **Concierge**
* **Beacon of Hope**
* **Big Warm Hug**

## What is this project?

queenslandkids.org.au - The biggest problem that Queensland Kids and their families are facing is being able to access the services and information available to them.

Our aim is to create a mobile or general web site for families allowing family to shine a beacon in the positive direction towards seeking help and finding resources. The problems today is a lot of those resources are scattered in various parts of the internet or medical services will hand you a info sheet, which may of completely irrelevant.

Second challenge is how do we share the information on the site accessible and securely/confidentially to family members, emergency services, doctors, nurses and service providers

## who's involved in the project 

Dan Sowter
Bruce Stronge
Mark Dunn
Andy Fitzsimon
Balinder
Homan
Clinton Roy
Christpherys Alva
Robert Dickie
Neil Estandarte
Brett
Danny Johnson
Jaya
Matt Riley
Boris S
Justin Douglas
Paul tasked
Paul Quilliam
Oli
Lucas Caton
Richardo Bernardell
Brad Parker
Erik Ecoologic
Rowan Hogan

=======

The biggest problem that **Queensland Kids** ([queenslandkids.org.au](http://www.queenslandkids.org)) and their families are facing is being able to access the services and information available to them.

Our aim is to create a mobile or general web site for families allowing family to shine a beacon in the positive direction towards seeking help and finding resources. The problems today is a lot of those resources are scattered in various parts of the internet or medical services will hand you a info sheet, which may of completely irrelevant.

Second challenge is how do we share the information on the site accessible and securely/confidentially to family members, emergency services, doctors, nurses and service providers.

## Who's involved in the project:

* Andy Fitzsimon
* Balinder
* Boris S
* Brad Parker
* Brett
* Bruce Stronge
* Christpherys Alva
* Clinton Roy
* Dan Sowter
* Danny Johnson
* Erik Ecoologic
* Homan
* Jaya
* Justin Douglas
* Lucas Caton
* Mark Dunn
* Matt Riley
* Neil Estandarte
* Olivier Pichon
* Paul Quilliam
* Paul Tasked
* Richardo Bernardell
* Robert Dickie
* Rowan Hogan

([http://rhokbrisbane.org](http://rhokbrisbane.org))

## Servers

Facebook App credentials to be inputted at server startup in `ENV["APP_ID"], ENV["APP_SECRET"]`

### Development

To get our [sass](http://sass-lang.com/) framework you need [node](http://nodejs.org/) and [bower](http://bower.io/)

    bower install

Access it through `http://lvh.me`, site url is a requirement for Facebook Authentication

Start the server passing the Facebook credentials (the length below is correct, the values are not):

    export APP_ID=123456789012345
    export APP_SECRET=c77777777777777777777777777777777
    rails s
