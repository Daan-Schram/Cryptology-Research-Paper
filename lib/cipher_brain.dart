class CipherBrain{

  CipherBrain({this.text, this.key});

  String text;
  int key;

  String encodeCaesar(){
    List li = text.split("");
    String encText = "";

    for (String letter in li) {
      int newValue = 0;
      String newLetter = "";

      if (letter.toUpperCase() == letter && letter.codeUnitAt(0) > 64 && letter.codeUnitAt(0) < 91) {
        int value = letter.codeUnitAt(0) - 65;
        newValue = (value + key) % 26 + 65;
        newLetter = String.fromCharCode(newValue);
      }

      else if (letter.toUpperCase() != letter && letter.codeUnitAt(0) > 96 && letter.codeUnitAt(0) < 123) {
        int value = letter.codeUnitAt(0) - 97;
        newValue = (value + key) % 26 + 97;
        newLetter = String.fromCharCode(newValue);
      }

      else {
        newLetter = letter;
      }
      encText += newLetter;
    }
    return encText;
  }

  String decodeCaesar(){
    List li = text.split("");
    String decText = "";

    for (String letter in li) {
      int newValue = 0;
      String newLetter = "";

      if (letter.toUpperCase() == letter && letter.codeUnitAt(0) > 64 && letter.codeUnitAt(0) < 91) {
        int value = letter.codeUnitAt(0) - 65;
        newValue = (value - key) % 26 + 65;
        newLetter = String.fromCharCode(newValue);
      }

      else if (letter.toUpperCase() != letter && letter.codeUnitAt(0) > 96 && letter.codeUnitAt(0) < 123) {
        int value = letter.codeUnitAt(0) - 97;
        newValue = (value - key) % 26 + 97;
        newLetter = String.fromCharCode(newValue);
      }

      else {
        newLetter = letter;
      }
      decText += newLetter;
    }
    return decText;
  }

}