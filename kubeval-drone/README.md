# kubeval-drone

[Kubeval][https://github.com/garethr/kubeval] is a nice way to lint Kubernetes
manifest files.

This image adds a small utility to pass in a directory and check all files inside using
Drone CI.

Set the directory using an environment variable:

`KUBEVAL_DIRECTORY`

Automatically looks for all files with the `.yaml` or `.yml` extension.
