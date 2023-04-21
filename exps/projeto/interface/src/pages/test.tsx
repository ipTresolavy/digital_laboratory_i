import React, { useEffect, useRef, useState } from "react";
import { alphabet } from "~/utils/alphabet";

function SoundPlayer({ setPlaySound, sequence }: any) {
  let sounds: string[] = [];

  const audioRef = useRef<HTMLAudioElement | null>(null);
  const soundIndexRef = useRef(0);

  const playSound = () => {
    const audio = audioRef.current;
    const soundIndex = soundIndexRef.current;
    if (!audio) {
      return;
    }

    if (audio?.src && !audio?.paused) {
      // If the current audio is already playing, don't do anything
      return;
    }

    if (soundIndex < sounds.length) {
      audio.src = sounds[soundIndex]!;
      audio?.play();
      soundIndexRef.current = soundIndex + 1;
    }
  };

  const handleSoundEnded = () => {
    const soundIndex = soundIndexRef.current;
    if (!audioRef.current) {
      return;
    }

    if (soundIndex < sounds.length) {
      audioRef.current.src = sounds[soundIndex]!;
      audioRef.current.play();
      soundIndexRef.current = soundIndex + 1;
    }
  };

  useEffect(() => {
    soundIndexRef.current = 0;
    for (const letra of sequence) {
      sounds.push(`/sounds/${letra}.mp3`);
    }
    playSound();
  }, [sequence]);

  return (
    <div>
      <audio ref={audioRef} onEnded={handleSoundEnded} />
    </div>
  );
}

export default SoundPlayer;
