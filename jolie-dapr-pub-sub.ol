from protocols.http import DefaultOperationHttpRequest
from console import Console

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
		protocol: http { format = "json" default.get = "get" default.post = "jqstatus" }
		interfaces: DaprSubscribeInterface   
	}
	embed Console as console
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

		[ jqstatus( request )( response ) {
			println@console( "Message received! " + request.data.message )()
			response.status = "SUCCESS"
		} ]
	}
}
