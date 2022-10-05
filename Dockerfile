FROM andy5995/0ad-bin-nodata:0.0.26.3

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
