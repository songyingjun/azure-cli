FROM microsoft/azure-cli:0.10.13

COPY * /

RUN ["chmod", "+x", "/start_staging_vm.sh"]
RUN ["chmod", "+x", "/stop_staging_vm.sh"]
WORKDIR	/


