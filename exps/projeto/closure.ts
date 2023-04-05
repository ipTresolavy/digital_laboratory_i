let a = 1

const fA = () => {

  const fB = () => {
    a = a + 1;
    return a;
  };

  return fB;
};

const eu = fA();
a = 100;
console.log(eu());
console.log(eu());
