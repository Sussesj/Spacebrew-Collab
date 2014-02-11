/*
 * Button Example
 *
 *   Spacebrew library button example that send and receives boolean messages.  
 * 
 */
import spacebrew.*;

String server="sandbox.spacebrew.cc";
String name="P5 Button Example";
String description ="Client that sends and receives boolean messages. Background turns yellow when message received.";

Spacebrew sb;

color color_on = color(255, 255, 50);
color color_off = color(255, 255, 255);
int currentColor = color_off;

import ddf.minim.*;
Minim minim;
AudioInput in;

void setup() {
	frameRate(240);
	size(500, 400);

	// instantiate the spacebrewConnection variable
	sb = new Spacebrew( this );

	// declare your publishers
	sb.addPublish( "button_pressed", "boolean", true ); 


	// declare your subscribers
	sb.addSubscribe( "change_background", "boolean" );

	// connect to spacebre
	sb.connect(server, name, description );

minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
}

void draw() {
//set background color
background (0);
	// draw button
	fill(255,0,0);
	stroke(200,0,0);
	rectMode(CENTER);
	ellipse(width/2,height/2,250,250);

	// add text to button
	fill(230);
	textAlign(CENTER);
	textSize(24);
	if (mousePressed == true) {
		text("That Feels Good", width/2, height/2 + 12);
	} else {
		text("Click Me", width/2, height/2 + 12);
	}

//background(0);
  stroke(255);
  
  // draw the waveforms so we can see what we are monitoring
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line( i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50 );
    line( i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50 );
     float vals= in.left.get(i)*50;
     
     if (vals <-20){
     println(vals);
    // send message to spacebrew
  sb.send( "button_pressed", true);
     }
  }
}

//void mousePressed() {
//	// send message to spacebrew
//	sb.send( "button_pressed", true);
//}
//
//void mouseReleased() {
//	// send message to spacebrew
//	sb.send( "button_pressed", false);


void onBooleanMessage( String name, boolean value ){
	println("got bool message " + name + " : " + value); 

	// update background color
	if (value == true) {
		currentColor = color_on;
	} else {
		currentColor = color_off;
	}
}
