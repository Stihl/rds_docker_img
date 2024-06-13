#FROM steamcmd/steamcmd

#COPY scripts/* /rust_files/

#EXPOSE 28015/udp 28016/tcp

#CMD force_install_dir=/rust_files/

#RUN /rust_files/garScript.sh


FROM steamcmd/steamcmd

# Good standard practice
RUN apt-get update && \
    apt-get upgrade -y
    # add more packages if they are missing

COPY scripts/* /rust_files/

# RUN /rust_files/garScript.sh

#RUN mkdir -p /steamcmd/rust /scripts

#Rust install script - Passed a file to steamcmd
#ADD scripts/install.sh /scripts/install.sh
RUN /setup.sh

#Now Running commands
# Fix permissions 
# Unpriv containers are UID 1000+ typically 
RUN chown -R 1000:1000 \
    /steamcmd \
    /rust_files

EXPOSE 28015/udp 28016/tcp

# Set any ENV variables you want to be set at startup
# It's common practice to set them in container creation and provide a way to pass them in
# The ENVs set in container creation are defaults
ENV RUST_SERVER_STARTUP_ARGUMENTS "-batchmode -load -nographics +server.secure 1"
ENV RUST_SERVER_IDENTITY "HomeLabbing"
ENV RUST_SERVER_PORT ""
ENV RUST_SERVER_QUERYPORT ""
ENV RUST_SERVER_SEED "LiveLoveHomelab"
ENV RUST_SERVER_NAME "TestBed is the best bed"
ENV RUST_SERVER_DESCRIPTION "This is a Rust server running inside a Docker container!"
ENV RUST_SERVER_URL "https://hub.docker.com/r/didstopia/rust-server/"
ENV RUST_SERVER_BANNER_URL ""
# ENV RUST_RCON_WEB "1"
# ENV RUST_RCON_PORT "28016"
# ENV RUST_RCON_PASSWORD "docker"
ENV RUST_APP_PORT "28082"
ENV RUST_UPDATE_CHECKING "0"
ENV RUST_HEARTBEAT "0"
ENV RUST_UPDATE_BRANCH "public"
ENV RUST_START_MODE "0"
ENV RUST_OXIDE_ENABLED "0"
ENV RUST_OXIDE_UPDATE_ON_BOOT "1"
ENV RUST_RCON_SECURE_WEBSOCKET "0"
ENV RUST_SERVER_WORLDSIZE "3500"
ENV RUST_SERVER_MAXPLAYERS "500"
ENV RUST_SERVER_SAVE_INTERVAL "600"

# Define directories to take ownership of
ENV CHOWN_DIRS "/rust_files,/steamcmd"

# Expose the volumes
# VOLUME [ "/rust_files" ]

WORKDIR /rust_files

# Start the server
#CMD [ "bash", "/garScript.sh"]
CMD [ "bash", "./RustDedicated", "--batchmode"]
#ENTRYPOINT /scripts/start.sh