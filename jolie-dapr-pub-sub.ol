from protocols.http import DefaultOperationHttpRequest

type DaprSubscriptionResponse {
	_* {
		pubsubname: string
		topic: string
		route: string
	}
}

interface DaprSubscribeInterface {
RequestResponse:
	get( DefaultOperationHttpRequest )( undefined ),
	jqstatus( undefined )( undefined )
}

service DaprSubscribeService {
	execution: concurrent

	inputPort DaprSubscribeService {
		location: "socket://localhost:9000"
		protocol: http { format = "json" default.get = "get" }
		interfaces: DaprSubscribeInterface   
	}

	main {
		[ get( request )( response ) { 
			if( request.operation == "dapr/subscribe" ) {      
				response._ << {
					pubsubname = "pubsub"
					topic = "JolieQueue"
					route = "jqstatus"
				}
			}
		} ]

		[ jqstatus( request )( {
			status = "Status is: " + request.status
		} ) ]
	}
}
