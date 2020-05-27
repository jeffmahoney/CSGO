docker rm csgo-dedicated2
#debug="-it --entrypoint=/bin/bash"
docker  run --net=host --name=csgo-dedicated2 --env-file=.default-env -d \
	--mount type=bind,source=/home/csgo/steamappdir,destination=/home/steam/csgo-dedicated \
	--mount type=bind,source=/home/csgo/Steam,destination=/home/steam/Steam \
	$debug --restart unless-stopped jeffm:csgo
