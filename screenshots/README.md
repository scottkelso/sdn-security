# Screenshots

When running the `run-faucnet.sh` script, one of the packages that is launched is a graphical interface for monitoring network traffic. If grafana is up successfully, one should be able to access it at `localhost:3000`.

If when you visit this URL, you are not automatically logged in - this usually indicates that this is the first time accessed on your particular machine. Follow the following [instructions](https://faucet.readthedocs.io/en/latest/tutorials/first_time.html#configure-grafana) to setup Grafana to use Prometheus as it's method of scraping data from Faucet.

See the three `FaucetSomething.png` screenshots which show the dashboards when traffic is successfully running through mininet and being picked up.