# [QLD Kids](http://www.queenslandkids.org)

[http://rhokbrisbane.org](http://rhokbrisbane.org)

* **Concierge**
* **Beacon of Hope**
* **Big Warm Hug**

* Servers

Facebook App credentials to be inputted at server startup in `ENV["APP_ID"], ENV["APP_SECRET"]`

** Development

Access it through `lvh.me`, site url is a requirement for Facebook Authentication
Start the server passing the fb credentials (the length below is correct, the values are not):

    export APP_ID=123456789012345
    export APP_SECRET=c77777777777777777777777777777777
    rails s

