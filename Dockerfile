FROM alpine:latest

RUN apk --update add curl jq coreutils

COPY sorry-cypress-run-cleaner.sh /tmp/sorry-cypress-run-cleaner.sh

RUN chmod +x /tmp/sorry-cypress-run-cleaner.sh

ENTRYPOINT ["/tmp/sorry-cypress-run-cleaner.sh"]
