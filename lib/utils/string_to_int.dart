int stringToInt(String input){
  int value=0;
  try{
 value= int.parse(input);
  }catch(exception){
    print("not converted");
  }
  return value;
}