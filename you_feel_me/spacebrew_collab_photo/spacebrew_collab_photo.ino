

void setup() {
// open serial port
Serial.begin(9600);
}
 
void loop() {
// read and send the value of analog sensor
long raw_val = analogRead(A0);


 
// use to adjust the range, if necessary
// int range_offet = 3;
// int range_size = 60;
// raw_val = raw_val - range_offet;
// raw_val = constrain( (raw_val * 1023 / range_size), 0, 1023);
 
Serial.println(raw_val);
 
// wait to send the next value so that you
// don't clog up the serial port
delay(100);
}
