const express = require('express');
const http = require('http');
const WebSocket = require('ws');

const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

const PORT = process.env.PORT || 3000;

// Store a reference to connected clients
const clients = new Set();

// WebSocket connection handler
wss.on('connection', (ws) => {
    console.log('Client connected');

    // Add the client to the set of connected clients
    clients.add(ws);

    // Handle incoming messages from clients
    ws.on('message', (message) => {
        try {
            const data = JSON.parse(message);
            console.log('Received data:', data);
            // You can process the received data here as needed

            // Broadcast the received data to all connected clients
            wss.clients.forEach((client) => {
                if (client.readyState === WebSocket.OPEN) {
                    client.send(JSON.stringify(data));
                }
            });
        } catch (error) {
            console.error('Error parsing message:', error);
        }
    });

    // Handle WebSocket close event
    ws.on('close', () => {
        console.log('Client disconnected');
        // Remove the client from the set of connected clients
        clients.delete(ws);
    });
});

server.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
