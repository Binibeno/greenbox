//create a unsercured simple websocket server, that broadcasts all messages to all clients, except if fthe client is the sender
var WebSocketServer = require('ws').Server
  , wss = new WebSocketServer({ port: 8080 });
var clients = [];

wss.on('connection', function connection(ws) {
  clients.push(ws);
  console.log('new connection');
  ws.send('5323');
  ws.on('message', function incoming(message) {
    console.log('received: %s', message);
    clients.forEach(function(client) {
      if (client !== ws) {

        client.send(message.toString())
      }
    });
  });
});
for (var i = 0; i < clients.length; i++) {
  clients[i].send('something');
}