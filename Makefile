TARANTOOL_STORAGE_PATH=/home/user/docker-tarantool-mqtt/data

console:
	docker run -it --rm tarantool/tarantool:latest -v ${TARANTOOL_STORAGE_PATH}:/home/tarantool/data -p 3301:3301 tarantool
sh:
	docker run -it --rm --env-file mqtt.env -v ${TARANTOOL_STORAGE_PATH}:/home/tarantool/data -p 3301:3301 mqtt_tarantool/connector sh

connector_build:
	docker build -t mqtt_tarantool/connector ./connector
connector_run:
	docker run -it --name mqtt_connector --rm --env-file mqtt.env -v ${TARANTOOL_STORAGE_PATH}:/home/tarantool/data -p 3301:3301 mqtt_tarantool/connector
connector_stop:
	docker stop mqtt_connector

dbcreator_build:
	docker build -t mqtt_tarantool/create_db ./create_db
dbcreator_run:
	docker run -it --name mqtt_dbcreator --rm --env-file mqtt.env -v ${TARANTOOL_STORAGE_PATH}:/home/tarantool/data -p 3301:3301 mqtt_tarantool/create_db
dbcreator_sh:
	docker run -it --name mqtt_dbcreator --rm --env-file mqtt.env -v ${TARANTOOL_STORAGE_PATH}:/home/tarantool/data -p 3301:3301 mqtt_tarantool/create_db sh
dbcreator_console:
	docker run -it --name mqtt_dbcreator --rm --env-file mqtt.env -v ${TARANTOOL_STORAGE_PATH}:/home/tarantool/data -p 3301:3301 mqtt_tarantool/create_db tarantool
dbcreator_stop:
	docker stop mqtt_dbcreator
