import { type NextPage } from "next";
import { useEffect, useState } from "react";
import mqtt from "mqtt";
import { alphabet } from "~/utils/alphabet";
import Navbar from "~/components/Navbar";

const Home: NextPage = () => {
  const [isConnected, setIsConnected] = useState(false);
  const [letter, setLetter] = useState("");
  const [mqttClient, setMqttClient] = useState<any>();

  useEffect(() => {
    const client = mqtt.connect("ws://broker.emqx.io:8083/mqtt", {
      clientId: "mqttjs_" + Math.random().toString(16),
      username: "emqx_test",
      password: "emqx_test",
      clean: true,
      connectTimeout: 4000,
      // username: "grupo2-bancadaA",
      // password: "digi#@2A3",
    });
    console.log(client);
    client.on("connect", () => {
      setIsConnected(true);
      setMqttClient(client);
    });
    client.on("error", (error) => {
      console.log("MQTT error:", error);
    });
    return () => {
      if (client) {
        client.end();
        setIsConnected(false);
        setMqttClient(null);
      }
    };
  }, []);

  const handleSendMessage = (letter: string) => {
    if (mqttClient) {
      mqttClient.publish("letter", letter);
    }
  };

  return (
    <>
      <Navbar></Navbar>
      <div className="flex flex-col items-center space-y-8">
        <div className="flex h-24 w-full items-center justify-center rounded-md bg-gray-100 shadow-md">
          <h1 className="text-3xl font-bold text-gray-800">
            Letra escolhida: {letter}
          </h1>
        </div>
        <div className="grid grid-cols-7 gap-4">
          {alphabet.map((l) => (
            <button
              className={`rounded-md py-4 px-6 font-medium shadow-md focus:outline-none ${
                letter === l
                  ? "bg-green-500 text-white"
                  : "bg-gray-200 text-gray-700 hover:bg-green-500 hover:text-white"
              }`}
              key={l}
              onClick={(e) => {
                setLetter(l);
                handleSendMessage(l);
              }}
            >
              {l}
            </button>
          ))}
        </div>
      </div>
    </>
  );
};

export default Home;
