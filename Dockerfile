FROM perl:5.24.1
LABEL authors="Daniel Cesario <dcesario@redhat.com>"

RUN cpanm Carton

WORKDIR /opt/project-x

COPY ./ /opt/project-x

RUN groupadd -r xman -g 1001 \
    && useradd -u 1001 -r -g xman -d /opt/project-x/ -s /sbin/nologin -c "Docker image user" xman \
    && chown -R xman:xman /opt/project-x/

RUN carton install --deployment

EXPOSE 8080

USER 1001
ENTRYPOINT ["carton", "exec", "hypnotoad"]
CMD ["-f", "/opt/project-x/script/project-x"]
