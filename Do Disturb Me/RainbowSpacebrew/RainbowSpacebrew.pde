import spacebrew.*;

/**
 * Rainbow. 
 * Click the mouse anywhere on the sketch to activate the rainbow animation.
 * 
 */
 
Spacebrew spacebrewConnection = new Spacebrew(this);
 
String server="192.168.1.134";
String name="Susse Rainbow";
String description ="Rainbow chain connection";

 
int barWidth = 20;
int barCurrent = 0;
int barTotal = 0;
boolean drawingRainbow = false;

void setup() 
{
  spacebrewConnection.addPublish("chain", true);
  spacebrewConnection.addSubscribe("chain", "boolean");
  
  spacebrewConnection.connect(server, name, description);
  
  size(640, 360);  // create window
  frameRate(20);   // set framerate
  background(0);   // draw a black background

  colorMode(HSB, width, height, height);  // set color mode to Hue/Saturation/Brightness
  noStroke();  // turn off stroke               

  barTotal = width / barWidth;  // calculate total number of bars that fit on window
}

void draw() {
  
  // draw rainbow when flag set to true
  if (drawingRainbow == true) {

    // determine the X location of the current bar 
    int drawBarXpos = barCurrent * barWidth; 

    // step 1: draw rainbow bars
    if (barCurrent < barTotal ) {
      fill(drawBarXpos, height, height);  // set fill color 
    }  

    // step 2: finish animation  
    else {
      drawingRainbow = false;    // set drawing flag to false
      background(0);           // set background to black
      spacebrewConnection.send("chain",true);
    }
    
    rect(drawBarXpos, 0, barWidth, height);  // draw bar at appropriate position      
    barCurrent += 1;                         // increment the number of the current bar
  }
}

void onBooleanMessage(String name, boolean value){
  barCurrent = 0;          // start drawing at beginning
  drawingRainbow = true;   // set draw flag to true
}

void mousePressed() {
  barCurrent = 0;          // start drawing at beginning
  drawingRainbow = true;   // set draw flag to true
}
