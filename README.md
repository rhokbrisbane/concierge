One-pager for the Brisbane chapter of RHOK 2013

[http://rhokbrisbane.org](http://rhokbrisbane.org)

Facebook App credentials to be inputted at server startup in `ENV["APP_ID"], ENV["APP_SECRET"]`


** Development

Access it through `lvh.me`, site url is a requirement for Facebook Authentication
Start the server passing the fb credentials (the length below is correct, the values are not):

    export APP_ID=123456789012345
    export APP_SECRET=c77777777777777777777777777777777
    rails s

