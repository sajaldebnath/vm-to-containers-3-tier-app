FROM mongo:6
WORKDIR /seed
COPY MOCK_DATA.json /seed/MOCK_DATA.json
COPY init-mongo.sh /init-mongo.sh
RUN chmod +x /init-mongo.sh
ENTRYPOINT ["/init-mongo.sh"]
