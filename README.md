# jolie-dapr

Install Dapr locally (https://docs.dapr.io/getting-started/)

dapr --app-id jolieq --app-port 9000 --log-level debug run jolie jolie-dapr-pub-sub.ol

dapr run --app-id testpubsub --dapr-http-port 3500 

dapr publish --publish-app-id testpubsub --pubsub pubsub --topic JolieQueue --data '{"message": "Message from Dapr API"}'

curl -X POST http://localhost:3500/v1.0/publish/pubsub/JolieQueue -H "Content-Type: application/json" -d '{"message": "Another message"}'
