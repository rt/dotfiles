# Payload data. 

We can add any JSON data in the payload but these are some standard keys that
should be added for the universality of the structure.

- iss (Issuer): This identifies the issuing authority of the token. In most of
the cases, it is the name of the authentication server "example.com".

- aud (Audience): This identifies the recipients of the token who will process
the JWT and use the information stored in the token. "example.com"

- sub (Subject): It identifies the end-user of the token. It usually contains the
database user id.

- iat (Issued At): It defines the time when the token was issued.

- exp (Expiration Time): It defines the time after which the token is considered
expired and is deemed invalid.

*custom field*

- prm (Param): identify the token for the user so that we can force invalidate
- that token when needed.
