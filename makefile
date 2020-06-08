.PHONY: build rebuild up restart service log stop down kubuild kurebuild kuup kurestart kustop kudown#kuservice kulog

build:
	docker-compose build

rebuild:
	docker-compose build --no-cache

up:
	docker-compose up

restart:
	docker-compose down
	docker-compose up

service:
	docker-compose up -d

log:
	docker-compose logs -f

stop:
	docker-compose stop

down:
	docker-compose down

kubuild:
	kompose build
kurebuild:
	kompose build --no-cache

kuup:
	kompose up

kurestart:
	kompose down
	kompose up

# kuservice:
# 	kompose up -d

# kulog:
# 	kompose logs -f

kustop:
	kompose stop

kudown:
	kompose down
