#!/bin/sh

PATH=/usr/bin
export PATH

URL_FILE="</path/to>/urls_dns.txt"
DT_ENDPOINT="<Tenant URL with environment ID>/api/v2/metrics/ingest"
DT_TOKEN="<API-Token with Ingest.Metrics permission>"
PAYLOAD="</path/to>/dt_payload.$$"
HOST_IP="<Host IP>"
TIMEOUT=60

if [ ! -f "$URL_FILE" ]; then
  echo "URL file not found!"
  exit 1
fi

check_dns(){
url="$1"
start_time=$(date +%s)
result=$(nslookup -timeout=$TIMEOUT "$url" 2>/dev/null)
end_time=$(date +%s)
time_spent=$((end_time - start_time))
resolved_ip=$(echo "$result" | awk '/^Name:/ {found=1} found && /Address:/ {print $2}' | tail -1)
if [ -n "$resolved_ip" ]; then
  status=1
else
  status=0
  resolved_ip="0.0.0.0"
fi
echo "custom.dns.status.v1,host=$HOST_IP,resolved_ip=$resolved_ip,time=\"${time_spent}s\",url=\"$url\" $status" >> "$PAYLOAD"
}

while IFS= read -r url
 do 
   check_dns "$url" &
 done < "$URL_FILE"

wait
curl -X POST -H "Authorization: API-Token $DT_TOKEN" -H "Content-Type:text/plain" --data-binary @"$PAYLOAD" "$DT_ENDPOINT"
rm -f "$PAYLOAD"
