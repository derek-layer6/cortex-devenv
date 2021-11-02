# Cortex Development Environment

A standardized development environment in which all Cortex related repositories compile
and run out of the box.

## Repositories supported

- `ml_core`
- `cortex`
- `mock-risk`

## Installation

Create the docker container

`make build`

Install the startup script

`make install`

## Usage

After installing, `cd` to the directory that contains the repository you want to work
with, then run:

`develop`

This will drop you into the development docker container with the current directory mounted at
`/mnt`. Your `~.m2` directory will also be mounted so that Maven commands like `mvn install`
will re-use packages downloaded while outside of the docker container.
