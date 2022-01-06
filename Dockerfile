FROM alpine:latest

RUN apk --update add curl jq coreutils

COPY sorry-cypress-run-cleaner.sh .

RUN chmod +x sorry-cypress-run-cleaner.sh

ENTRYPOINT ["sorry-cypress-run-cleaner.sh"]
