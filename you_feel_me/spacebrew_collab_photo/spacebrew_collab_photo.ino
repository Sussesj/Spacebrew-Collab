
//declare pins
int ledPin = 5; 
int button01 = 13; 

boolean running = false; 

void setup() {
  
  // open serial port
  Serial.begin(9600);

  pinMode(ledPin, OUTPUT);
  pinMode(button01, INPUT);
  digitalWrite(button01, HIGH);

}
 
void loop() {
  
  if(digitalRead(button01) == LOW) 
  {
    //switch is pressed - pullup keeps pin high normally
   
    running = !running;  //toggle running variable
    digitalWrite(ledPin, running);
   }
    
    // read and send the boolean value to the serial
    Serial.println(running);
   
    // wait to send the next value so that you
    // don't clog up the serial port
  
}
