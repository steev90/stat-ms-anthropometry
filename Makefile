docker-build:
	docker build \
		-t stat-ms-anthropometry \
		--rm \
		--force-rm=true \
		--build-arg ANTHRO_PORT=9080 \
		--build-arg ASPNETCORE_ENVIRONMENT=production \
		--build-arg APP_NAME=stat-nutritional-anthropometry \
		.

docker-run: docker-start
docker-start:
	docker-compose up -d
	docker run -d \
		-p 9080:9080 \
		--network=stat-ms-anthropometry_default  \
		--name=stat-ms-anthropometry_main \
		stat-ms-anthropometry

docker-stop:
	docker stop stat-ms-anthropometry_main || true
	docker rm stat-ms-anthropometry_main || true
	docker-compose down --volume

docker-restart:
	make docker-stop 2>/dev/null || true
	make docker-start