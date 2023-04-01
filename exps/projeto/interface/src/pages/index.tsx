import { type NextPage } from "next";
import { useEffect, useState } from "react";
import mqtt from "mqtt";
import { alphabet } from "~/utils/alphabet";
import Navbar from "~/components/Navbar";
import { useRouter } from "next/router";
import { FaCheck, FaTimes } from "react-icons/fa";
import useSound from "use-sound";

const Home: NextPage = () => {
  const [isConnected, setIsConnected] = useState(false);
  const [letter, setLetter] = useState("");
  const [sequence, setSequence] = useState<string[]>([]);
  const [mqttClient, setMqttClient] = useState<any>();
  const [enable, setEnable] = useState<boolean>(true);
  const [messages, setMessages] = useState<number>(0);
  const [acertos, setAcertos] = useState<number>(0);
  const [erros, setErros] = useState<number>(0);
  const [initializeEnable, setInitializeEnable] = useState<boolean>(true);
  const [playAudio] = useSound('/AHHHHH.mp3')

  const router = useRouter();


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
      client.subscribe("controle");
      setIsConnected(true);
      setMqttClient(client);
    });
    client.on("message", (topic, messagebuffer) => {
      let message = messagebuffer.toString();
      const esperaescrita = "1";
      const acerto = "4";
      const erro = "5";
      switch (topic) {
        case "controle":
          switch (message) {
            case esperaescrita:
              setEnable(true);
              break;
            case acerto:
              setAcertos(data => {return data + 1});
              break;
            case erro:
              setErros(data => {return data + 1});
              break;
          }
          break;
        default:
          break;
      }
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

  const handleReset = () => {
    if (mqttClient) {
      mqttClient.publish("controle", "2");
    }
  };

  const handleInit = () => {
    if (mqttClient) {
      mqttClient.publish("controle", "3");
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
                  : enable
                  ? "bg-gray-200 text-gray-700 hover:bg-green-500 hover:text-white"
                  : "bg-red-500 text-white"
              }`}
              disabled={!enable}
              key={l}
              onClick={(e) => {
                setEnable(false);
                setLetter(l);
                setSequence([...sequence, l]);
                handleSendMessage(l);
              }}
            >
              {l}
            </button>
          ))}
        </div>
        <div className="mt-4">
          {
            <div className="rounded-lg bg-gray-200 p-4 shadow-md">
              <p className="mb-2 text-lg font-bold">Sequence:</p>
              <p className="text-lg text-gray-700">{sequence}</p>
            </div>
          }
        </div>
        <div className="grid grid-cols-2 gap-4">
          <button
            onClick={() => {
              setSequence([]);
              setEnable(true);
              setLetter("");
              handleReset();
              setInitializeEnable(true);
              setAcertos(0);
              setErros(0);
              playAudio()
            }}
            className="rounded-md bg-red-500 py-4 px-6 font-medium text-white shadow-md focus:outline-none"
          >
            RESET
          </button>
          <button
            onClick={() => {
              setInitializeEnable(false);
              handleInit();
            }}
            disabled={!initializeEnable}
            className={`rounded-md  py-4 px-6 font-medium  shadow-md focus:outline-none ${
              initializeEnable
                ? "bg-green-500 text-white"
                : "bg-gray-200 text-gray-700"
            }`}
          >
            INICIAR
          </button>
        </div>
        <div className="flex flex-row ">
          <div className="m-4 flex flex-row">
            <FaCheck color="#22C55D" className="" />
            {acertos}
          </div>
          <div className="m-4 flex flex-row">
            <FaTimes color="#EF4444" className="" />
            {erros}
          </div>
        </div>
      </div>
    </>
  );
};

export default Home;
