# [Queensland Kids](http://www.queenslandkids.org)

**Concierge**

## What is this project?

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
* Ricardo Bernardeli
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

    export HH_FACEBOOK_APP_ID=560486987363815
    export HH_FACEBOOK_APP_SECRET=f1dc56416a941b380c1410f44b39f446
    export HH_DEVISE_SECRET_KEY=62caa77c37f8e92d7562e06427766ce1a8e71d7c92f2ce26e46a6f3f035f6a0f197a4be64a33483d79b39d7c675c4ecfc39bbcc12d9631b084e2fc16a4fff18e
    export HH_SECRET_KEY_BASE=54e42d09f9198aad975e6d504dbf436483bc032311f6ed55735273ce9910f245ed220badddde98cd1926ee02c7e75fad15ac657e5953706fc898622aee8ffcb0
    rails s

