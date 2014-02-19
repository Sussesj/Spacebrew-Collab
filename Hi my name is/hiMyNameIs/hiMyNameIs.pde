/* 
  This is the publisher, that sends a string with the name you type in. 
*/

import spacebrew.*;

String server= "sandbox.spacebrew.cc";
String name="GotIt?";
String description ="Sends a string as an object";

//indicated the string writen on the screen
String local_string = "";

//indicated the string writen on the screen when done typing
String last_string = "";

//creates a json object
JSONObject outgoingName = new JSONObject();

Spacebrew sb;

void setup(){
  size(200,300);
  
  //intitiate the spacebrew Connection Variable
  sb = new Spacebrew( this );
  
  //declare publisher
  sb.addPublish ("listen_to_me", "name", local_string.toString());
  
  sb.connect(server, name, description);
}

void draw(){
  background(50);
 
  //set the local string to the json object
  outgoingName.setString("local_string", local_string);
  
  // draw message being typed
  text("Hi, my name is: ", 30, 60);  
  text(local_string, 150, 60); 
  
    // draw message that was just sent
    text("You just send: ", 30, 80);  
    text(last_string, 150, 80);

}

void keyPressed() {
  if (key != CODED) {
    if (key == DELETE || key == BACKSPACE) {
      if (local_string.length() - 1 >= 0) {
        local_string = local_string.substring(0, (local_string.length() - 1));  
      }
    }

    else if (key == ENTER || key == RETURN) {
      //when enter send json
      sb.send("listen_to_me", "name", outgoingName.toString());
      println("sending " + local_string);
      last_string = local_string;
      local_string = "";  
    } 

    else {
      if (local_string.length() <= 50) {
        local_string += key;
      }
    }
  } 
}


