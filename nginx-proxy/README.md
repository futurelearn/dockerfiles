# nginx-proxy

A small reverse proxy to forward error pages to an external location.

## Testing

There are two Docker Compose files that can be used for testing.

### Proxy Mode

Start the environment:

```
docker-compose -f docker-compose.proxy.yml up --build
```

Test a normal request:

```
curl localhost:8080
```

Test an error page:

```
curl localhost:8080/foo
```

### Maintenance Mode

Start the environment:

```
docker-compose -f docker-compose.maintenance.yml up --build
```

Test the request:

```
curl localhost
```
