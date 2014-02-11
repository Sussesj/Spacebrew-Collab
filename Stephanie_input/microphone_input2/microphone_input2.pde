/*
 * Microphone Receiver, 
 *
 *   Stephanie's input for hear no, speak no, see no.
 * 
 */
import spacebrew.*;

String server="sandbox.spacebrew.cc";
String name="Steph's Microphone Input";
String description ="Client that sends and receives boolean messages. Background turns yellow when message received.";

Spacebrew sb;

color color_on = color(255, 255, 50);
color color_off = color(255, 255, 255);
int currentColor = color_off;

import ddf.minim.*;
Minim minim;
AudioInput in;

/* @pjs preload="1231.png, 12341.png"; */

int numFrames = 2; //the number of frames in the animation
int frame = 0;
PImage[] images = new PImage [numFrames];

void setup() {

  background (0);
  frameRate(5);
  size(500, 800);
  //  numFrames.resize(50,50);

  images[0] = loadImage("1231.png");
  images[1] = loadImage("12341.png");

  // instantiate the spacebrewConnection variable
  sb = new Spacebrew( this );

  // declare your publishers
  sb.addPublish( "recording_received", "boolean", true ); 


  // declare your subscribers
  sb.addSubscribe( "pop_up", "boolean" );

  // connect to spacebre
  sb.connect(server, name, description );

  minim = new Minim(this);

  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
}

void draw() {
  //set background color
  background (255);
  // background (0);
  // draw button
  //  fill(255, 0, 0);
  //  stroke(200, 0, 0);
  //  rectMode(CENTER);
  //  ellipse(width/2, height/2, 250, 250);

  // add text to button
  //  fill(230);
  //  textAlign(CENTER);
  //  textSize(24);
  //  if (mousePressed == true) {
  //    text("That Feels Good", width/2, height/2 + 12);
  //  } 
  //  else {
  //    text("Click Me", width/2, height/2 + 12);
  //  }

  //background(0);
  stroke(0);
  //microPhone();
  // draw the waveforms so we can see what we are monitoring
  for (int i = 0; i < in.bufferSize() - 1; i++)
  {
    line( i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50 );
    line( i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50 );
    float vals= in.left.get(i)*50;

    if (vals < -5) {

      println(vals);
      // send message to spacebrew
      sb.send( "recording_received", true);
      //println("true");
      frame = (frame+1) % numFrames;  // Use % to cycle through frames
      int offset = 0;
      for (int x = 50; x < 400; x += images[0].width) { 
        image(images[(frame+offset) % numFrames], x, 10);
      }
    }

    // if (vals >-20) {
    // send message to spacebrew
    //sb.send( "recording_received", false);
  }


  //void microPhone();

  // void onBooleanMessage( String name, boolean value ) {
  //   println("got bool message " + name + " : " + value); 
  // update background color
  //  if (value == true) {
  //    currentColor = color_on;
  //  } 
  //  else {
  //    currentColor = color_off;
}

