import socket
import sys
import websocket
import json
import time
import _thread as thread
import creds


data = {
    "type": "LISTEN",
    "data": {
        "topics": ["channel-points-channel-v1." + creds.channel_id],
        "auth_token": creds.auth_token,
    }
}


def on_message(ws, message):
    print(message)
    data = json.loads(message)
    if data["type"] == "MESSAGE":
        message = json.loads(data["data"]["message"])
        if message["type"] == "reward-redeemed":
            redemption = message["data"]["redemption"]
            response = {
                "type": "reward",
                "data": {
                    "user": redemption["user"]["login"],
                    "user_display": redemption["user"]["display_name"],
                    "redeem_id": redemption["reward"]["id"],
                    "redeem_title": redemption["reward"]["title"],
                    "user_input": redemption.get("user_input", None),
                }
            }
            skt.sendall((json.dumps(response) + "\n").encode('utf-8'))

def on_error(ws, error):
    print(error)

def on_close(ws):
    print("### closed ###")

def on_open(ws):
    ws.send(json.dumps(data))

def do_ping(ws):
    ws.send(json.dumps({"type": "PING"}))

def run_pings(ws):
    while True:
        time.sleep(180)
        do_ping(ws)

if __name__ == "__main__":
    skt = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    skt.connect(("localhost", 2134))
    sys.stdout.write("Connected to localhost:2134.\n")
    sys.stdout.flush()
    websocket.enableTrace(True)
    ws = websocket.WebSocketApp("wss://pubsub-edge.twitch.tv",
                              on_message = on_message,
                              on_error = on_error,
                              on_close = on_close)
    ws.on_open = on_open

    thread.start_new_thread(run_pings, (ws, ))

    ws.run_forever()
    skt.close()
