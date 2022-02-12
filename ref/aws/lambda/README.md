# AWS Lambda notes (http://serverless-stack.com)

1. Create IAM New User (console)
- username:admin > Programmatic Access (This will be used by AWS CLI and Serverless Framework)
- permissions: Could use groups, but for now Use existing template Administrator Access (this ok for now)
- Take note of both Access key ID (AKIAJZ2XWLKZGR452STQ) and Secret access key (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)

2. Configure AWS CLI
- install (sudo pip install awscli) 
- $ aws configure (add Access key ID and Secret access key)  (~/.aws) 

3. Create Dynamo Table
- Create table (console) > ie notes 
- - partition key (userId: string)
- - add sort key (noteId: string)

    Each Dynamo Table has a primary key (which cannot be changed once set).  There are 2 types of primary keys
    - Partition key
    - Partition key and sort key (composite)  >  composite allows us to get all notes by userId, and get one note by userId and noteId

You can use the Default Settings (5 reads, 5 writes, SNS alarm at 80% (SNS topic "dynamodb")), but each table will have provisioned throughput capacity (Dynamo will reserve resources to meet you throughput needs.
- one read capacity can read up to 8KB per second 
- one write capacity can write up to 1KB per second


4. Create S3 Bucket (in this case becase each note can have a file attachment)
Amazon S3 (Simple Storage Service) provides storage service through web services interfaces like REST. You can store any object on S3, including images, videos, files, etc. Objects are organized into buckets, and identified within each bucket by a unique, user-assigned key.
- Create bucket (console)
- - "notes-app-uploads-ryan" / US West (Oregon)  
- Accept defaults
- Enable CORS (Permissions > CORS configuration)
- <CORSConfiguration>
-   <CORSRule>
      <AllowedOrigin>*</AllowedOrigin>
      <AllowedMethod>GET</AllowedMethod>
      <AllowedMethod>PUT</AllowedMethod>
      <AllowedMethod>POST</AllowedMethod>
      <AllowedMethod>HEAD</AllowedMethod>
      <MaxAgeSeconds>3000</MaxAgeSeconds>
      <AllowedHeader>*</AllowedHeader>
    </CORSRule>
  </CORSConfiguration>


5. Create Cognito User Pool
Amazon Cognito User Pool makes it easy for developers to add sign-up and sign-in functionality to web and mobile applications. It serves as your own identity provider to maintain a user directory. It supports user registration and sign-in, as well as provisioning identity tokens for signed-in users.
- Create User Pool: notes-user-pool
- Note your Pool Id (us-west-2_15fkcxuGp) and Pool ARN (arn:aws:cognito-idp:us-west-2:467293231502:userpool/us-west-2_15fkcxuGp)
- Add App
- - unselect Generate client secret (user pool apps with a client secret are not supported by JavaScript SDK)
- - select Enable sign-in API for server-based authentication (required by AWS CLI when managing the pool users via command line interface)
- note the App client id (1n77bvl57hbmd24d2akv5q32lt)
- Create a Test User
- aws cognito-idp sign-up \
    --region us-west-2 \
    --client-id 1n77bvl57hbmd24d2akv5q32lt \
    --username admin@example.com \
    --password Passw0rd! \
    --user-attributes Name=email,Value=admin@example.com
- verify that accout
aws cognito-idp admin-confirm-sign-up \
    --region us-west-2 \
    --user-pool-id us-west-2_15fkcxuGp \
    --username admin@example.com

6. Setup Cognito Identity Pools to secure S3 Bucket for file uploads
Amazon Cognito Federated Identities enables developers to create unique identities for your users and authenticate them with federated identity providers. With a federated identity, you can obtain temporary, limited-privilege AWS credentials to securely access other AWS services such as Amazon DynamoDB, Amazon S3, and Amazon API Gateway.

we are going to create a federated Cognito identity pool using the User Pool acting as the federated identity provider. Once users log into our notes app, we’ll grant them limited access to the S3 Bucket for uploading files.
- Create a new Identity Pool 
- Open Authentication Providers and select Cognito (there are others like Facebook, Google, etc.)
- - Input your User Pool ID and App Client ID (from the user pool created above)
we need to specify what AWS resources are accessible for users with temporary credentials obtained from the Cognito Identity Pool.  Two roles will appear for authenticated users and unauthenticated users.
- - Edit the Policy Document
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "mobileanalytics:PutEvents",
                    "cognito-sync:*",
                    "cognito-identity:*"
                ],
                "Resource": [
                     "*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:*"
                ],
                "Resource": [
                    "arn:aws:s3:::YOUR_S3_UPLOADS_BUCKET_NAME/${cognito-identity.amazonaws.com:sub}*"
                ]
            }
        ]
    }

Note cognito-identity.amazonaws.com:sub is the authenticated user’s federated identity ID. This policy grants the authenticated user access to files with filenames prefixed by the user’s id in the S3 bucket as a security measure.

- Select Dashboard and Select Edit Identity Pool to get the Identity Pool ID > take note: us-west-2:f20d34e7-0787-4cf8-9fe0-ae43ec2ccf9a
- Definition: User Pool
Amazon Cognito User Pool makes it easy for developers to add sign-up and sign-in functionality to web and mobile applications. It serves as your own identity provider to maintain a user directory. It supports user registration and sign-in, as well as provisioning identity tokens for signed-in users.
- Definition: Identity Pool
Amazon Cognito Federated Identities enables developers to create unique identities for your users and authenticate them with federated identity providers. With a federated identity, you can obtain temporary, limited-privilege AWS credentials to securely access other AWS services such as Amazon DynamoDB, Amazon S3, and Amazon API Gateway.


7.  Install Serverless
- npm install serverless -g
- *serverless create --template aws-nodejs      (this create serverless.yml and handler.js)
- npm install aws-sdk --save-dev
- npm install uuid --save    (generates unique ids. We need this for storing things to DynamoDB)
- - Webpack (separate config): 

    -- babel-preset-react-app
    -- serverless-webpack
    -- webpack-node-externals is necessary because we do not want Webpack to bundle our aws-sdk module, since it is not compatible

    THESE are also in .babelrc (make different env?)
    {
      "plugins": ["transform-runtime"],
      "presets": ["react-app"]
    }

    -- serverless.yml
    service: notes-app-api

    # Use serverless-webpack plugin to transpile ES6/ES7
    plugins:
      - serverless-webpack
      -
      - # Enable auto-packing of external modules
      - custom:
      -   webpackIncludeModules: true
      -
      -   provider:
      -     name: aws
      -       runtime: nodejs6.10
      -         stage: prod
      -           region: us-east-1


8.  Deploy

- serverless deploy

Service Information
service: notes-app-api
stage: prod
region: us-west-2
api keys:
    None
endpoints:
    POST - https://ed0kgwtzu9.execute-api.us-west-2.amazonaws.com/prod/notes
    GET - https://ed0kgwtzu9.execute-api.us-west-2.amazonaws.com/prod/notes/{id}
    GET - https://ed0kgwtzu9.execute-api.us-west-2.amazonaws.com/prod/notes
    PUT - https://ed0kgwtzu9.execute-api.us-west-2.amazonaws.com/prod/notes/{id}
    DELETE - https://ed0kgwtzu9.execute-api.us-west-2.amazonaws.com/prod/notes/{id}
functions:
    create: notes-app-api-prod-create
    get: notes-app-api-prod-get
    list: notes-app-api-prod-list
    update: notes-app-api-prod-update
    delete: notes-app-api-prod-delete

9.  Test
obtain an identity token to include in the API request Authorization header
aws cognito-idp admin-initiate-auth \
    --region us-west-2 \
    --user-pool-id us-west-2_15fkcxuGp \
    --client-id 1n77bvl57hbmd24d2akv5q32lt \
    --auth-flow ADMIN_NO_SRP_AUTH \
    --auth-parameters USERNAME=admin@example.com,PASSWORD=Passw0rd!

The identity token can be found in the IdToken field of the response.
$ aws cognito-idp admin-initiate-auth --region us-west-2 --user-pool-id us-west-2_15fkcxuGp --client-id 1n77bvl57hbmd24d2akv5q32lt --auth-flow ADMIN_NO_SRP_AUTH --auth-parameters USERNAME=ryan@example.com,PASSWORD=Passw0rd!
{
    "AuthenticationResult": {
        "ExpiresIn": 3600,
        "IdToken": "eyJraWQiOiJtMDljYlJFbGQrOXFWbWg5TU41aTR0d2lvWjFHUFFjXC8wU0hVc2dmcGZPST0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJkNmNmNzgyZS1jZTk5LTQyNjYtYjgxMi03YmZkOGJlZTAxYTEiLCJhdWQiOiIxbjc3YnZsNTdoYm1kMjRkMmFrdjVxMzJsdCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwidG9rZW5fdXNlIjoiaWQiLCJhdXRoX3RpbWUiOjE0OTI0NTQ3NTYsImlzcyI6Imh0dHBzOlwvXC9jb2duaXRvLWlkcC51cy13ZXN0LTIuYW1hem9uYXdzLmNvbVwvdXMtd2VzdC0yXzE1ZmtjeHVHcCIsImNvZ25pdG86dXNlcm5hbWUiOiJyeWFuQGV4YW1wbGUuY29tIiwiZXhwIjoxNDkyNDU4MzU2LCJpYXQiOjE0OTI0NTQ3NTYsImVtYWlsIjoicnlhbkBleGFtcGxlLmNvbSJ9.KNk4C049TdcZbXcrWFbqszCOMYuuRnkdyCk-s83CcTAT32GmXrmJj-y8HKnyIq_-chyg_QX3H0PVtHfYiUCsyhPqvyhbWE6H5uGhitDAbYxz4CjeRjwcWw9LCwX0ZqAmeCcR_ewHUui70C2q1dG7BPW1JZvsQwbvMfi6e5GVXnl7wa6Rk-z688PwuTEXWdpwgCzr8GPgu6D6EyehbCHZqDap9WVkp_0Vy-PsmnHtobUQZjlvHPxjGwBR8rWuvL0pCJOt69nPYM01og7NUZfZ3jQCJqEWOkDUqdxTRr5a3YUSMRpc2O_DdOdgD4h0onn5qUE5nxiKTOS5llfTn1urcg",
        "RefreshToken": "eyJjdHkiOiJKV1QiLCJlbmMiOiJBMjU2R0NNIiwiYWxnIjoiUlNBLU9BRVAifQ.OKOSmOHh9SyxVvm81QDhVbk40dJV6D3gNeBrwvW4BtRSmQcVGbexfD8jXtJRLB6zpZr4EMUPNWwizARDgnHego7EnUmvLRdKd4U-pQrT4TZWcbs1760a422E7nOP0zD0qTX538adSkCFM2v4Y8q5fuTeGFCtjiHnsT222RTvm13i0GnrhWLpiBsKUhggzz27kjvdITeH0uy_MyM5778dWonn7Hvscd7g2Nf2QhJXUIpamQGxHonr0qQoMsEhkSW_YlYEoQcnuF16SOlyc0qkNpw5KUw9KJv1L5rvoOAxuNq3PmX_T4sgzi8XHhEOZyyEX3gUq242lorEe9WrcrrWHA.foRxwg9XmpfTcNqg.5CByhiBgjJmK6-8GVQpN5fMX0V3FOsa7sMegW1gsC__zoBgV1SkUnvR00zofhmQKs87d1qf_HYg18r_oJwiuZ46SxYKM0l3H8guuClLLz10LyktsCO4-p2z7yAm7bt722t0uwpELixjv2miL8ILnymB5rw08dwXn64buM_5zl4V0oLvLczx8C57kwVzNSKUNEZaU5bYmi_eyisV8bwsZAjoMugEP8-LNIqwUK7r19qJ_hDiGFiEicJB9D5Qo6gr7Lp158-QtV3ubyA3CiBbNFTskWDT8CApOBMg0LhGEVzMiXQSCgfpqg0LwsgNDmnRJ6tWTuDfOyHSwi_KlE3niYf1Q9bx1qNMN7Oy_ZA4o2AM0PXMGk2klnRW-K7QyXKHy-P2SUrqq_eFFnfkFBaunGJWZjQcKRLPzDnaXFfoz9hN2HSDc9Q1niOU4QGxSNf0BbN3ebGFgW0GVbGmpxXFYhslKc_ldmeEWYj4zTR1K712MxxTItOYzpossNERin1MT25_zz56IkU1rhL1UcBkxZnTTSysko4YPqU1R3vjP6ngdL3CmQ2qY9ylBpeHavTGqBPTDF9JH3tH5QoHgg4sFKXIRKaSua0EZI-rbZTXno12E_jYRwXRMjtS_IUxhMurO-AbfcK790_9tZlimiD6VX_rirF68JlXsLuu5Du4pVaaWBmaIKXW4MsAVhhQvtQ_I8FOwT1QYR87H-DdlXrmQmXIdX4Aq0cNzPML81G7HxExSwGfLNZjZvxyKhs1Y1E6B38gj_PA2vZBqLZf8Tb_L-1aFiUWCnFwLwuJg_OiVtrSEP3euqinYPJtNgsMKa82UPtHkUpu_ZGdIhoumU2m3cHEps2xY7WsSe3sA1XhDsgVaYwnRHnuHj3_Kzgr_74PO52nWig15DHd7EssqPc717E4mIl2aa5TumXy9SS9Yyb0uxnlhNmQEhF1-Dja9M2utzufa8YYdfOf3HTqLJHK0uT-TueCPpRGiJhGwEKZ40OmRapPfqo066FbmBwl5Udgqwrkepwc4yL8vX0RMm3sqrjMVKeIRgnCmZuQ8nGjBK-QIvNJDOnzwfJS29BrN-TdXjIruvM8cswHfyoSvnoAndpXWHJDb6GO0aHGuwHnrWndeRmgJkpxdsAKUVxQd7o3ZlMXR8gvgU4ARy9mxFWnqKQ.AMvf_Wj47OnRPciM7RlTww",
        "TokenType": "Bearer",
        "AccessToken": "eyJraWQiOiJrb0NzenBJMEU2VEtibnFOdFQyejdGQ0NSc2ZvM3BzNlpwUHZxWWZlbzdVPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiJkNmNmNzgyZS1jZTk5LTQyNjYtYjgxMi03YmZkOGJlZTAxYTEiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6ImF3cy5jb2duaXRvLnNpZ25pbi51c2VyLmFkbWluIiwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLnVzLXdlc3QtMi5hbWF6b25hd3MuY29tXC91cy13ZXN0LTJfMTVma2N4dUdwIiwiZXhwIjoxNDkyNDU4MzU2LCJpYXQiOjE0OTI0NTQ3NTYsImp0aSI6IjJkMDYwYmZjLTI3ZTYtNGZkMi05YThmLWM0MzI2ZTgxOTVkYyIsImNsaWVudF9pZCI6IjFuNzdidmw1N2hibWQyNGQyYWt2NXEzMmx0IiwidXNlcm5hbWUiOiJyeWFuQGV4YW1wbGUuY29tIn0.aEikP3saqp2NjhFHXoyzlucq_ebeu7YWZRwG3cotX9Zw4e09oJFMPX8lMuPe4FuWDjYC11Fw-5X2bnU0uZVqNT0SZWrKkeQaX0poE5yfp5XuxeSxvgmuRhtzDEyvCqbqecE2z_5VVOkHhMZydREsrg2mYZYHnHIzvR-dWQ_nTEwLRj6fB0Dx7mZLn8Ooy5vg3Mv2Pzjft-wvvEkowcy3ih8wfHJiN9CjqUkRIZqrVmtyBIhmcJ5FAqe8IF91XAJ0axJaDKO2FF8TIJrHBM9seK_AuxtFh03L9xb8kuQWcmxjsvyj_wtiaolQnh1fzWeZ0SfSKNCu7uBBS8BUJ4MfRQ"
        },
        "ChallengeParameters": {}
    }

We can use the IdToken as the Authorization header to make a request to our api

curl https://ed0kgwtzu9.execute-api.us-west-2.amazonaws.com/prod/notes \
  -H "Authorization:eyJraWQiOiJtMDljYlJFbGQrOXFWbWg5TU41aTR0d2lvWjFHUFFjXC8wU0hVc2dmcGZPST0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJkNmNmNzgyZS1jZTk5LTQyNjYtYjgxMi03YmZkOGJlZTAxYTEiLCJhdWQiOiIxbjc3YnZsNTdoYm1kMjRkMmFrdjVxMzJsdCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwidG9rZW5fdXNlIjoiaWQiLCJhdXRoX3RpbWUiOjE0OTI0NTQ3NTYsImlzcyI6Imh0dHBzOlwvXC9jb2duaXRvLWlkcC51cy13ZXN0LTIuYW1hem9uYXdzLmNvbVwvdXMtd2VzdC0yXzE1ZmtjeHVHcCIsImNvZ25pdG86dXNlcm5hbWUiOiJyeWFuQGV4YW1wbGUuY29tIiwiZXhwIjoxNDkyNDU4MzU2LCJpYXQiOjE0OTI0NTQ3NTYsImVtYWlsIjoicnlhbkBleGFtcGxlLmNvbSJ9.KNk4C049TdcZbXcrWFbqszCOMYuuRnkdyCk-s83CcTAT32GmXrmJj-y8HKnyIq_-chyg_QX3H0PVtHfYiUCsyhPqvyhbWE6H5uGhitDAbYxz4CjeRjwcWw9LCwX0ZqAmeCcR_ewHUui70C2q1dG7BPW1JZvsQwbvMfi6e5GVXnl7wa6Rk-z688PwuTEXWdpwgCzr8GPgu6D6EyehbCHZqDap9WVkp_0Vy-PsmnHtobUQZjlvHPxjGwBR8rWuvL0pCJOt69nPYM01og7NUZfZ3jQCJqEWOkDUqdxTRr5a3YUSMRpc2O_DdOdgD4h0onn5qUE5nxiKTOS5llfTn1urcg" \
    -d "{\"content\":\"hello world\",\"attachment\":\"hello.jpg\"}"

