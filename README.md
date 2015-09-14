Tecla CMS app
=============

[ ![Codeship Status for kristianmandrup/tecla-cms-app](https://codeship.com/projects/835d7a90-3152-0133-9f1f-0a744e9a501a/status?branch=master)](https://codeship.com/projects/99692)

### Ruby version

See `.ruby-version` file

### System dependencies

Requires [MongoDB](https://www.mongodb.org/) 3.0 or higher.

### Configuration

[DotEnv](https://github.com/bkeepers/dotenv) is used for Environment configuration via `.env` files

```sh
AWS_KEY=[YOUR KEY]
AWS_SECRET=[YOUR SECRET]
AWS_REGION=eu-central-1
AWS_BUCKET=tecla-cms

TRANSLATOR_CLIENT_ID=TeclaCms
TRANSLATOR_CLIENT_SECRET=[YOUR SECRET]
```

### Database setup

```sh
rake db:create
rake db:seed
```

### Testing

`bundle exec rake`

### Services

[Microsoft Translator API](https://www.microsoft.com/en-us/translator/translatorapi.aspx) is used for *Auto translations* feature

[ImgMix](https://www.imgix.com/) - Will likely be used for uploading and transforming images in the near future

#### Job queues

[Resque scheduler](https://github.com/resque/resque-scheduler) is used to run background jobs

### Deployment instructions

See [Docker Deployment](Docker-Deployment.md)

### License

Commercial License (c) Copyright Tecla 5 2015-2016
