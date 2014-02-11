/*
 * Button Example
 *
 *   Spacebrew library button example that send and receives boolean messages.  
 * 
 */
import spacebrew.*;

PImage eyes;
PImage eyesText;

String server="sandbox.spacebrew.cc";
String name="See Evil";
String description ="simple button";

Spacebrew sb;

color color_on = color(255, 255, 50);
color color_off = color(255, 255, 255);
int currentColor = color_off;

void setup() {
	frameRate(240);
	size(800, 200);

        eyes = loadImage("monkeyEyes.png");
        eyesText = loadImage("monkeyEyesText.png");
        
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
	// set background color
	background(237, 212, 183);

        if(mousePressed){
          image(eyesText, 0, 0);
        } else {
          image(eyes, 0, 0);
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
	} else {
		currentColor = color_off;
	}
}
