# app-persberichten

Backend of the Persberichten application

## How to
### Run the application in development mode
A supplementary `docker-compose.development.yml`-file is provided in order to tweak the stack-setup for development purposes. Among other changes, this configuration will for instance prevent crashed services from restarting automatically, in order to catch errors quicker.

You can start the stack in development mode by running

```
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up
```
