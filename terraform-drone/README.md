# terraform-drone

Used to plan changes to our Terraform.

The base image is Ruby since the `terralearn` wrapper is written in Ruby.

It installs the version of Terraform we're using, and also includes the
parallel package which is used for parallel plans by the `deployment.sh`
script, and also fetches the `sops` package which is used for secrets.
