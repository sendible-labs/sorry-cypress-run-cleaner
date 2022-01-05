FROM alpine:latest

RUN apk --update add curl jq

COPY sorry-cypress-run-deleter.sh .

RUN chmod +x sorry-cypress-run-deleter.sh

ENTRYPOINT ["sorry-cypress-run-deleter.sh"]
