# Docker environment for guifi.net fiberfy tool
Docker images for fiberfy fiber tool (sails branch)
## Requirements
We must have installed those packages:
- **docker engine**: version 1.13 or above
- **curl**: any version


And that should be enough to run our image

## Working with this
If you want to work with this version of guifi fiberfy tool you should clone this repository inside a development directory with writing permissions:

```
docker run -it -p 1337:1337 -v "$PWD"/fiberfy:/usr/share/node/fiberfy guifi/fiberfy:sails
```

This command runs guifi/fiberfy container with a persistent volume mounted inside ./fiberfy/ folder. Fiberfy is bind in localhost port 3000.

```
Guifi.net fiberfy successfully installed in Docker image!
```

When this appears fiberfy is installed in the Docker container.

After that you need to create a user for the environment:
```
curl -X POST "http://localhost:1337/api/v1/User/" -d '{"username":"<user>","password":"<password>"}' -H Content-Type:application/json
```

If you want to reinstall fiberfy you should erase INSTALLED file:
```
sudo rm ./fiberfy/INSTALLED
```
