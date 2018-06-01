# mysql

A simple build that adds our own MySQL tuning configuration specific for running
tests.

In tests we can increase performance because we do not neccessarily care about
the integrity of the data. This means we can flush less often to increase IO performance.

See the [Dockerfile](Dockerfile) for more information, and [futurelearn.cnf](futurelearn.cnf)
for configuration options.
