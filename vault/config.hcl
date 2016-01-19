# Listen on all ports (in addition to ('-dev' default listener listens on localhost only)
listener "tcp" {
  address = "0.0.0.0:8201"
  tls_disable = 1
}

# Default is 30 days (specified in hours)
# Let's use 10 years, I don't want to remember to renew these tokens.
default_lease_ttl = "87600h"
max_lease_ttl = "87600h"
