import netP5.*;//defines a netAddress for communication over UPT protocol
import oscP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

float ampValue;
float pitchValue;

void oscEvent(OscMessage theOscMessage) {
  //check if "/first" is in the sent data
  if (theOscMessage.checkAddrPattern("/freq")==true) {
    pitchValue = theOscMessage.get(0).floatValue();
  }
  if (theOscMessage.checkAddrPattern("/amp")==true) {
    ampValue = theOscMessage.get(0).floatValue();
  }
  println(pitchValue, ampValue);
}

 