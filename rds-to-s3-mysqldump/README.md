# rds-to-s3-mysqldump

A small script to stream a `mysqldump` from RDS, using [IAM
authentication](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html),
compressing with [`pigz`](https://zlib.net/pigz/), and uploading to a bucket
using the [`awscli`](https://aws.amazon.com/cli/).
