/*

This is the subscriber that recieves the sting with the name. 
*/

import spacebrew.*;

String server= "sandbox.spacebrew.cc";
String name="gotItYourNameIs";
String description ="";

Spacebrew sb;

//makes a string for remote string
String remote_string = "";

//create json object
JSONObject outgoing = new JSONObject();

void setup(){
  size(200,300);
  
  //intitiate the spacebrew Connection Variable
  sb = new Spacebrew( this );
  
  //declare subscriber
  sb.addSubscribe ("say_something", "name");
  
  sb.connect(server, name, description);
}



void draw(){
  background(50);
  
  // draw latest received message
  text("This person just entered: ", 30, 120);  
  text(remote_string, 150, 140);
 
}

void onCustomMessage( String name, String type, String value ){
  if  (name.equals("say_something") ) {
    JSONObject m = JSONObject.parse( value );
    println("got string message " + name + " : " + value);
    remote_string = m.getString("local_string");
  }
}


