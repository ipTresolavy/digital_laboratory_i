import { type NextPage } from "next";
import { useEffect, useState } from "react";
import mqtt from "mqtt";
import { alphabet } from "~/utils/alphabet";
import Navbar from "~/components/Navbar";

const Home: NextPage = () => {
  const [isConnected, setIsConnected] = useState(false);
  const [letter, setLetter] = useState("");
  const [word, setWord] = useState("");
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
        <div className="flex h-24 w-full flex-col items-center justify-center rounded-md bg-gray-100 shadow-md">
          <h1 className="text-3xl font-bold text-gray-800">
            Palavra a ser escolhida:
          </h1>
          <h1 className="text-3xl font-bold text-gray-800">{word}</h1>
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
                setWord(word + l);
                handleSendMessage(l);
              }}
            >
              {l}
            </button>
          ))}
        </div>
        <button
          className="rounded-md py-4 px-6 font-medium bg-red-500 text-white shadow-md hover:bg-red-600 focus:outline-none flex items-center"
          onClick={() => setWord(word.slice(0, -1))}
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 20 20"
            fill="currentColor"
            className="mr-2 h-6 w-6"
          >
            <path
              fillRule="evenodd"
              d="M6.293 6.293a1 1 0 011.414 0L10 8.586l2.293-2.293a1 1 0 111.414 1.414L11.414 10l2.293 2.293a1 1 0 01-1.414 1.414L10 11.414l-2.293 2.293a1 1 0 01-1.414-1.414L8.586 10 6.293 7.707a1 1 0 010-1.414z"
              clipRule="evenodd"
            />
          </svg>
          Delete
        </button>
      </div>
    </>
  );
};

export default Home;
