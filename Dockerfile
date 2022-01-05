LABEL org.opencontainers.image.source https://github.com/sendible-labs/sorry-cypress-run-cleaner
FROM alpine:latest

RUN apk --update add curl jq

COPY test-deleter.sh .

RUN chmod +x test-deleter.sh

ENTRYPOINT ["test-deleter.sh"]
