/*
 * Button Example
 *
 *   Spacebrew library button example that send and receives boolean messages.  
 * 
 */
import spacebrew.*;

String server="sandbox.spacebrew.cc";
String name="Susse";
String description ="Client that sends and receives boolean messages. Background turns yellow when message received.";

Spacebrew sb;

color color_on = color(255, 255, 50);
color color_off = color(255, 255, 255);
int currentColor = color_off; 

boolean disturbPressed = false;
boolean DoNotDisturbPressed = false;

int disturbButFill = color(255,100,255);
int disturbButSides = 100;
int disturbButY = 400;
int disturbButX = width/3;

void setup() {
  frameRate(240);
  size(500, 600);

  // instantiate the spacebrewConnection variable
  sb = new Spacebrew( this );

  // declare your publishers
  sb.addPublish( "button_pressed", "boolean", true ); 


  // declare your subscribers
  sb.addSubscribe( "change_background", "boolean" );

  // connect to spacebre
  sb.connect(server, name, description );
}

void draw() {
  // draw ResponButton 
  fill( currentColor );
  rectMode(CENTER);
  rect(width/2,200,300,100);
  
  
  // draw disturbMeButton
  fill(disturbButFill);
  rectMode(CENTER);
  rect(disturbButX, disturbButY,disturbButSides,disturbButSides);
  
  // draw DoNotdisturbMeButton
  fill(disturbButFill);
  rectMode(CENTER);
  rect(disturbButX+disturbButX,disturbButY,disturbButSides,disturbButSides);
  

  // add text to disturb me button
  fill(230);
  textAlign(CENTER);
  textSize(14);
  if (mousePressed == true) {
    text("Yeah I'm ready to talk", width/3, 400 + 12);
  } else {
    text("Disturb Me", width/3, 400 + 12);
  }
  
}

void mousePressed() {
  // send message to spacebrew
  sb.send( "button_pressed", true);
  
}

void mouseReleased() {
  // send message to spacebrew
  sb.send( "button_pressed", false);
  
}

void onBooleanMessage( String name, boolean value ){
  println("got bool message " + name + " : " + value); 

  // update background color
  if (value == true) {
    currentColor = color_on;
    fill(0);
    text("Yeah I'm ready to talk", width/2, 200 + 12);
  } else {
    currentColor = color_off;
    fill(0);
    text("Disturb Me", width/2, 200 + 12);
  }
}
