# Listen on all ports (in addition to ('-dev' default listener listens on localhost only)
listener "tcp" {
  address = "0.0.0.0:8201"
  tls_disable = 1
}
