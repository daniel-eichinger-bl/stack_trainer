library constants;

enum TrainModes { cards, mix, indexes }
const modeDic = {
  TrainModes.cards: 0.0,
  TrainModes.mix: 1.0,
  TrainModes.indexes: 2.0
};

const modeDicRev = {
  0: TrainModes.cards,
  1: TrainModes.mix,
  2: TrainModes.indexes
};

const stack = {
  '4C': 1,
  '2H': 2,
  '7D': 3,
  '3C': 4,
  '4H': 5,
  '6D': 6,
  'AS': 7,
  '5H': 8,
  '9S': 9,
  '2S': 10,
  'QH': 11,
  '3D': 12,
  'QC': 13,
  '8H': 14,
  '6S': 15,
  '5S': 16,
  '9H': 17,
  'KC': 18,
  '2D': 19,
  'JH': 20,
  '3S': 21,
  '8S': 22,
  '6H': 23,
  '10C': 24,
  '5D': 25,
  'KD': 26,
  '2C': 27,
  '3H': 28,
  '8D': 29,
  '5C': 30,
  'KS': 31,
  'JD': 32,
  '8C': 33,
  '10S': 34,
  'KH': 35,
  'JC': 36,
  '7S': 37,
  '10H': 38,
  'AD': 39,
  '4S': 40,
  '7H': 41,
  '4D': 42,
  'AC': 43,
  '9C': 44,
  'JS': 45,
  'QD': 46,
  '7C': 47,
  'QS': 48,
  '10D': 49,
  '6C': 50,
  'AH': 51,
  '9D': 52
};

const suitDic = {'H': 'hearts', 'C': 'clubs', 'S': 'spades', 'D': 'diamonds'};
