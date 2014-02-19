/* 
  This is the publisher, that sends a string with the name you type in. 
*/

import spacebrew.*;

String server= "sandbox.spacebrew.cc";
String name="GotIt?";
String description ="Sends a string as an object";

//vector Points
PVector localPoint = new PVector(0,0);
PVector remotePoint = new PVector(0,0);

//store local string in array
char local_string[] = { };
String local_string_name = new String(local_string);

//store last string in array
char last_string[] = { };
String last_string_name = new String(last_string);

JSONObject outgoing = new JSONObject();
//Create the Json Object
JSONObject outgoingName = new JSONObject();

Spacebrew sb;

void setup(){
  size(200,300);
  
  //intitiate the spacebrew Connection Variable
  sb = new Spacebrew( this );
  
  //declare publisher
  sb.addPublish ("p5Point", "point2d", "\"x\":0, \"y\":0");
  sb.addPublish ("listen_to_me", "string", local_string.toString());
  
  sb.connect(server, name, description);
}

void draw(){
  localPoint.set(mouseX, mouseY);
  background(50);
  
  fill(0); //black Dot - local point
  ellipse(localPoint.x, localPoint.y, 20,20);
  
  outgoing.setInt("x", mouseX); //set outgoing points
  outgoing.setInt("y", mouseY);
  
  for(int i = 0; i < local_string.length; i++){
   outgoingName.setString("local_string", local_string[i]);
  }
  
  
  // draw message being typed
  text("Type Message: ", 30, 60);  
  text(local_string[0], 150, 60); 
  
    // draw message that was just sent
    text("Message Sent: ", 30, 80);  
    text(last_string[0], 150, 80);

  
  sb.send("p5Point", "point2d", outgoing.toString()); //sending points 
  sb.send("listen_to_me", "string", outgoingName.toString());
}

void keyPressed() {
  if (key != CODED) {
    if (key == DELETE || key == BACKSPACE) {
      if (local_string.length() - 1 >= 0) {
        local_string = local_string.substring(0, (local_string.length() - 1));  
      }
    }

    else if (key == ENTER || key == RETURN) {
      sb.send("listen_to_me", local_string);
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


