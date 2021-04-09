##introduction
this repository contains a single makefile, intended to be run on a raspberry pi, in order to start a wifi access point

##usage
if you have installed this repository for the first time, move into it, and run:
```sudo make init```
this should initialize your access point.
it is also noteworthy that the makefile itself contains a couple of setup variables. it is reccomended to modify those as needed
**WARNING**: this command is intended to be run only once. running it multiple times may cause file corruption and misfunction. use at your own risk

in order to turn off the access point, run:
```sudo make deactivate```

to reactivate, run:
```sudo make activate```

##license
[mit](./LICENSE)
