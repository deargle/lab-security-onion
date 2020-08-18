#!/bin/bash
# copied function from /usr/sbin/sosetup-minimal on 8-14-2020
function tune() {

CONF="/etc/nsm/securityonion.conf"
source $CONF

# stop elastalert if running
if docker ps |grep elastalert >/dev/null 2>&1; then
echo -e "XXX\n10\nPlease wait while stopping elastalert...\nXXX"
docker stop so-elastalert >/dev/null 2>&1
fi

# disable elastalert
if [ "$ELASTALERT_ENABLED" = "yes" ]; then
echo -e "XXX\n15\nPlease wait while disabling elastalert...\nXXX"
sed -i 's|ELASTALERT_ENABLED="yes"|ELASTALERT_ENABLED="no"|g' $CONF
fi

# stop freqserver if running
if docker ps |grep freqserver >/dev/null 2>&1; then
echo -e "XXX\n20\nPlease wait while stopping freqserver...\nXXX"
docker stop so-freqserver >/dev/null 2>&1
fi

# disable freqserver
if [ "$FREQ_SERVER_ENABLED" = "yes" ]; then
echo -e "XXX\n25\nPlease wait while disabling freqserver...\nXXX"
sed -i 's|FREQ_SERVER_ENABLED="yes"|FREQ_SERVER_ENABLED="no"|g' $CONF
fi

# stop domainstats if running
if docker ps |grep domainstats >/dev/null 2>&1; then
echo -e "XXX\n30\nPlease wait while stopping domainstats...\nXXX"
docker stop so-domainstats >/dev/null 2>&1
fi

# disable domainstats
if [ "$DOMAIN_STATS_ENABLED" = "yes" ]; then
echo -e "XXX\n30\nPlease wait while disabling domainstats...\nXXX"
sed -i 's|DOMAIN_STATS_ENABLED="yes"|DOMAIN_STATS_ENABLED="no"|g' $CONF
fi

# tune elasticsearch if enabled
# sosetup-minimal: improve service check #1738
# https://github.com/Security-Onion-Solutions/security-onion/issues/1738
if [ "$ELASTICSEARCH_ENABLED" = "yes" ]; then

echo -e "XXX\n40\nPlease wait while stopping Elasticsearch...\nXXX"
/usr/sbin/so-elasticsearch-stop >/dev/null 2>&1

echo -e "XXX\n50\nPlease wait while configuring and restarting Elasticsearch...\nXXX"
ES_HEAP_SIZE="400m"
sed -i "s/^-Xms.*/-Xms$ES_HEAP_SIZE/" /etc/elasticsearch/jvm.options
sed -i "s/^-Xmx.*/-Xmx$ES_HEAP_SIZE/" /etc/elasticsearch/jvm.options
CLUSTER_NAME=$(grep "cluster.name" /etc/elasticsearch/elasticsearch.yml | tail -1 | cut -d\" -f2)
rm -f /var/log/elasticsearch/${CLUSTER_NAME}.log
/usr/sbin/so-elasticsearch-start >/dev/null 2>&1
fi

# tune logstash if enabled
# sosetup-minimal: improve service check #1738
# https://github.com/Security-Onion-Solutions/security-onion/issues/1738
if [ "$LOGSTASH_ENABLED" = "yes" ]; then

echo -e "XXX\n60\nPlease wait while stopping Logstash...\nXXX"
/usr/sbin/so-logstash-stop >/dev/null 2>&1

echo -e "XXX\n70\nPlease wait while configuring and restarting Logstash...\nXXX"
LS_HEAP_SIZE="200m"
sed -i "s/^-Xms.*/-Xms$LS_HEAP_SIZE/" /etc/logstash/jvm.options
sed -i "s/^-Xmx.*/-Xmx$LS_HEAP_SIZE/" /etc/logstash/jvm.options
/usr/sbin/so-logstash-start >/dev/null 2>&1

echo -e "XXX\n80\nPlease wait while services initialize (may be a few minutes)...\nXXX"
# If logstash outputs to Elasticsearch, we can check Elasticsearch log for initialization
# Otherwise, logstash is outputting to Redis and we can skip this
if [ "$LOGSTASH_OUTPUT_REDIS" != "yes" ]; then
until fgrep -qs "adding template [logstash" /var/log/elasticsearch/${CLUSTER_NAME}.log; do
sleep 1s
done
fi
fi
}
tune
