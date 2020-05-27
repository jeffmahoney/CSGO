###########################################################
# Dockerfile that builds a CSGO Gameserver
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="walentinlamonos@gmail.com"

ENV STEAMAPPID 740
ENV STEAMAPPDIR /home/steam/csgo-dedicated
ENV SRCDS_FPSMAX=300
ENV SRCDS_TICKRATE=128
ENV SRCDS_PORT=27015
ENV SRCDS_TV_PORT=27020
ENV SRCDS_CLIENT_PORT=27005
ENV SRCDS_MAXPLAYERS=14
ENV SRCDS_TOKEN=0
ENV SRCDS_RCONPW="changeme"
ENV SRCDS_PW="changeme"
ENV SRCDS_STARTMAP="de_dust2"
ENV SRCDS_REGION=3
ENV SRCDS_MAPGROUP="mg_active"
ENV SRCDS_GAMETYPE=0
ENV SRCDS_GAMEMODE=1

ADD etc ${STEAMAPPDIR}

# Create autoupdate config
# Add entry script & ESL config
# Remove packages and tidy up
RUN  apt-get update
RUN  apt-get install -y --no-install-recommends --no-install-suggests wget \
		ca-certificates=20190110
RUN  mkdir -p ${STEAMAPPDIR}/csgo
WORKDIR ${STEAMAPPDIR}
RUN  mv entry.sh /
RUN  chmod 755 /entry.sh
RUN  cd ${STEAMAPPDIR}/csgo
RUN  {	\
			echo '@ShutdownOnFailedCommand 1';	\
			echo '@NoPromptForPassword 1';	\
			echo 'login anonymous';	\
			echo 'force_install_dir ${STEAMAPPDIR}';	\
			echo 'app_update ${STEAMAPPID}';	\
			echo 'quit';	\
		} > ${STEAMAPPDIR}/csgo_update.txt
RUN tar zxf cfg.tar.gz
RUN rm -f cfg.tar.gz
RUN  chown -R steam:steam .
RUN  apt-get remove --purge -y wget
RUN  apt-get clean autoclean
RUN  apt-get autoremove -y
RUN  rm -rf /var/lib/apt/lists/*

USER steam

WORKDIR $STEAMAPPDIR

VOLUME $STEAMAPPDIR
VOLUME /home/steam/Steam

ENTRYPOINT /entry.sh

# Expose ports
EXPOSE 27015/tcp 27015/udp 27020/udp
