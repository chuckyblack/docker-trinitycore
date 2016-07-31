build:
	docker build -t trinitycore .

rm:
	docker kill trinitycore
	docker rm trinitycore

run:
	docker run -dit -v /home/chucky/Hry/World\ of\ Warcraft:/opt/trinitycore/data --name trinitycore trinitycore

bash:
	docker exec -it trinitycore bash

recreate: rm run bash

