type DaprSubscriptionResponse {
  _* {
    pubsubname: string
    topic: string
    route: string
  }
}

interface DaprSubscribeInterface {
requestResponse:
	post( undefined )( undefined )
requestResponse:
  get( undefined )( undefined )  
}

service DaprSubscribeService {
	execution: concurrent

	inputPort DaprSubscribeService {
		location: "socket://localhost:9000"
		protocol: http { format = "json" default.get = "get" default.post = "post" }    
		interfaces: DaprSubscribeInterface   
	}

	main {
    [get( request )( response ) { 
      if( request.operation == "dapr/subscribe" ) {         
        response._[0].pubsubname = "pubsub"
        response._[0].topic = "JolieQueue"
        response._[0].route = "jqstatus"
      } 
    }]

    [post( request )( response ) {
      if( request.operation == "jqstatus" ) {         
        response.status = "Status is: " + request.data.status
      }
    }]
	}
}
