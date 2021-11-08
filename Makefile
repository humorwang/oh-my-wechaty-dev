build:
	docker build --no-cache -t humorwang/oh-my-wechaty-dev:v1.0 .
tag:
	docker tag humorwang/oh-my-wechaty-dev:v1.0  humorwang/oh-my-wechaty-dev:latest
push:
	docker push humorwang/oh-my-wechaty-dev:latest

