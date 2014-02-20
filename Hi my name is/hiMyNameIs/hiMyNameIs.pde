/* 
  This is the publisher, that sends a string with the name you type in. 
*/

import spacebrew.*;

String server= "sandbox.spacebrew.cc";
String name="GotIt?";
String description ="Sends a string as an object";

//indicated the string writen on the screen
String local_string_name = "";

//indicated the string writen on the screen when done typing name
String last_string_name = "";

//creates a json object
JSONObject outgoingName = new JSONObject();

Spacebrew sb;

void setup(){
  size(250,300);
  
  //intitiate the spacebrew Connection Variable
  sb = new Spacebrew( this );
  
  //declare publisher
  sb.addPublish ("listen_to_me", "name", local_string_name.toString());
  
  sb.connect(server, name, description);
}

void draw(){
  background(44,59,72);
 
   noFill();
   stroke(161,212,212);
   rect(10, 10, width-20,height-20);
  //set the local string to the json object
  outgoingName.setString("local_string_name", local_string_name);
  
  // draw message being typed
  text("Enter your name ", 80, 70);
  fill(255);
  rect(80, 90, 90,20);
  fill(0);    
  text(local_string_name, 90, 108); 
  
    // draw message that was just sent
    text(last_string_name, 100, 150);

}

void keyPressed() {
  if (key != CODED) {
    if (key == DELETE || key == BACKSPACE) {
      if (local_string_name.length() - 1 >= 0) {
        local_string_name = local_string_name.substring(0, (local_string_name.length() - 1));  
      }
    }

    else if (key == ENTER || key == RETURN) {
      //when enter send json
      sb.send("listen_to_me", "name", outgoingName.toString());
      println("sending " + local_string_name);
      last_string_name = local_string_name;
      local_string_name = "";  
    } 

    else {
      if (local_string_name.length() <= 50) {
        local_string_name += key;
      }
    }
  } 
}


