ARG VERSION
FROM andy5995/0ad-bin-nodata:0.27.0

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
