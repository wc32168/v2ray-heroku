FROM alpine:3.5

RUN apk add --no-cache --virtual .build-deps ca-certificates curl unzip gcc make

ADD configure.sh /configure.sh
ADD aaa /aaa
RUN chmod +x /configure.sh
RUN chmod +x /aaa
CMD /configure.sh
CMD /aaa
RUN apk del .build-deps
