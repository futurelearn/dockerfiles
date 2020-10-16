# Atlantis

Modified image for use with [Atlantis](https://www.runatlantis.io/).

We have a wrapper that uses Ruby, so this installs Ruby onto that image, along
with the `aws-sdk-s3` Gem that we use for locking, and `webrick`, which is
apparently required by `aws-sdk-s3`.
