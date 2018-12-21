NAME=yakout/docker-ns3

build: Dockerfile
	if [ -d "./ns-allinone-3.26" ]; then \
		echo "Dir exists, skip downloading .."; \
	else \
		wget http://www.nsnam.org/release/ns-allinone-3.26.tar.bz2; \
		tar -xf ./ns-allinone-3.26.tar.bz2; \
		rm ./ns-allinone-3.26.tar.bz2; \
	fi
	socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
	docker build -t $(NAME) .

run:
	docker run --rm -it -v `pwd`/ns-allinone-3.26/ns-3.26/src/:/usr/ns3/ns-3.26/src -e DISPLAY=docker.for.mac.host.internal:0 $(NAME)
