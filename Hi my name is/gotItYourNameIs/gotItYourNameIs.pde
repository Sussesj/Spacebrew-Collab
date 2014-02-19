/*

This is the subscriber that recieves the sting with the name. 
*/

import spacebrew.*;

String server= "sandbox.spacebrew.cc";
String name="gotItYourNameIs";
String description ="";

Spacebrew sb;

PVector remotePoint = new PVector(0,0);

String remote_string = "";
JSONObject outgoing = new JSONObject();

void setup(){
  size(200,300);
  
  //intitiate the spacebrew Connection Variable
  sb = new Spacebrew( this );
  
  //declare subscriber
  sb.addSubscribe ("p5Point", "point2d");
  sb.addSubscribe ("say_something", "name");
  
  sb.connect(server, name, description);
}



void draw(){
  background(50);

  //fill(255);
  //ellipse(remotePoint.x, remotePoint.y, 20,20);
  
  // draw latest received message
  text("This person just entered: ", 30, 120);  
  text(remote_string, 150, 120);
 
}

void onCustomMessage( String name, String type, String value ){
  if ( type.equals("point2d") ){
    // parse JSON!
    JSONObject m = JSONObject.parse( value );
    remotePoint.set( m.getInt("x"), m.getInt("y"));
  } else if  (name.equals("say_something") ) {
    JSONObject m = JSONObject.parse( value );
    println("got string message " + name + " : " + value);
    remote_string = m.getString("local_string");
  }
}


