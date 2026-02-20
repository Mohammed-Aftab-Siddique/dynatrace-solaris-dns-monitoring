# dns_mon_v1.sh Documentation

## Overview
The `dns_mon` script is designed to monitor the DNS status for the list of domains from a host. It provides observability for DNS status ona Solaris host into dynatrace (pre-built extension not available).

## Configuration
To configure the script, you'll need to specify the following parameters:
- `DT_ENDPOINT` - Dynatrace tenant URL with environment ID and api endpoint.
- `DT_TOKEN` - Dynatrace PAAS token with Ingest.Metrics permission.
- `HOST_IP` - The host ip of the source.
- `URL_FILE` - Absolute path to a text file containing a list of domains.
- `PAYLOAD` - Absolute path to a temporary payload file.
- `TIMEOUT` - NSLookup time out value in seconds.
- `Metric Name` - Metric name to be configured in the payload (recommended format: custom.app_name...)

Ensure that the configuration values follow the required format to avoid issues during execution.

## Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/Mohammed-Aftab-Siddique/dynatrace-solaris-dns-monitoring.git
   ```
2. Navigate to the cloned directory:
   ```bash
   cd dynatrace-solaris-dns-monitoring
   ```
3. Ensure that you have the necessary permissions to execute the script:
   ```bash
   chmod +x dns_mon_v1.sh
   ```
## Metric Overview
Metric Name(s):
 ```bash
   custom.dns.status.v1
   ```
Metric Dimensions:
 ```bash
   resolved_ip, time_spent, host & url
   ```
Metric Value:
 ```bash
   status
   ```
## Security Considerations
- Be aware of the sensitivity of the data being processed. Avoid exposing sensitive information in the output files.
- Run the script in a secure environment to prevent unauthorized access to the files.

## Troubleshooting
- **Permission Denied**: Check that the script has appropriate execution permissions.

## Examples
To run the parser on a log file, use the following command:
```bash
./dns_mon_v1.sh
```

This command will process the specified log file and ingest an output to dynatrace.

# Version History

## dns_mon_v1
- Initial Release

