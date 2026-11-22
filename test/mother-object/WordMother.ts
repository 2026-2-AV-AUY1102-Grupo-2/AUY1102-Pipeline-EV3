import { MotherCreator } from './MotherCreator';

export class WordMother {
  static random(length = 5): string {
    if (length <= 0) {
      return '';
    }
    return MotherCreator.random().lorem.word(length);
  }
}
