# JWT

https://afteracademy.com/blog/implement-json-web-token-jwt-authentication-using-access-token-and-refresh-token

Base64 encoded json and has three parts separated by a dot..

1. Header: It contains the metadata for the signing method and the encryption
   method applied to the token.

2. Payload: It contains information about the authenticated user. The RFC
   defines and recommends some standard keys for this JSON object but it is not
   mandatory and we can add any data in this payload.

3. Signature: This part is very important. We can ask this question that if all
   the information is in base64 and anyone can decode this data. So, it does
   not prevent from creating a fake token on behalf of someone else with this
   information and access his personal data. Then how can it be a secure way of
   authentication?

We encrypt the hash of the contents of the token, i.e. Header and Payload using
the encryption algorithms like RS256 (RSA Signature with SHA-256), HS256 (HMAC
with SHA-256), etc. The third part of the token contains this encrypted hash
string.

the RS256 approach is useful as the client can verify the authenticity of the
token using the public key.

In RS256 we have a private key and a public key pair. The data hash can be
encrypted using the private key and can only be decrypted using the public key.
This private key needs to be kept secure on the server filesystem. The public
key can be shared with the client if required.

To validate the authenticity of the token, the Header, and the Payload (base64
string parts of the token) are combined and hashed together and the hash is
then validated using the public key to test whether it was actually encrypted
using its private key. This ensures that no one else can either change the
original data in the token or send false data. Because the hash value will not
match the originally issued token.

```javascript
// create a header64
const headerStr = '{"alg":"RS256","typ":"JWT"}';
const buff = Buffer.from(headerStr, 'utf-8');
const header64 = buff.toString('base64');
console.log(header64);

const buff64 = Buffer.from(header64, 'base64');
console.log(buff64.toString('utf-8'));

// create payload64
const payloadStr = '{"iss":"example.com","aud":"example","sub":"5e7b95923085872d3c378f35","iat":1585158878,"exp":1587750878,"prm":"3ed723cbb27bef65d6e032550e43f90af736ac42c951c0f69c316e5854ef78473b3d374f28ecbe1d7afa3eb49b5cb36269eb47f220197484bdd247871879181a"}';
...

// create the signature
const signature = rs256hash(privateKey, header64 + payload64)

// string them together with '.'
const jwt = [header64, payload64, signature].join('.');
```
