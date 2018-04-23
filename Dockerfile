FROM microsoft/azure-cli:0.10.13

COPY * /

RUN ["chmod", "+x", "/*.sh"]

WORKDIR	/


