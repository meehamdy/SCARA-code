import processing.serial.*;
import processing.video.*;
Serial myPort;
Capture video;
Detection detection;
float th2a, th1a, th1b, th2b;
int th1Send, th2Send;
float l1=18, l2=13;
boolean mode=true;
color track1, track2, track3;
int threshold=25, threshold_dis=100;
int c=0;
int val=0;
String data;
float avx1=0, avx2=0, avx3=0;
float avy1=0, avy2=0, avy3=0;
float dis1, dis2, dis3;
void setup() {
  size(640, 480);
  printArray(Capture.list());
  detection = new Detection();
  video =new Capture(this, Capture.list()[15]);
  video.start();
  track1= color (255, 0, 0);
  track2=color(255, 255, 0);
  track3=color(0, 0, 255);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
}
void draw() { 
  if (val==1) {
    mode=true;
  } else if (val==0) {
    mode=false;
  }
  detection.colors();
}
void serialEvent(Serial myPort) {
  val = myPort.read();
  println(val);
}
void captureEvent(Capture video) {
  video.read();
}
void mousePressed() {
  threshold=10;
  int loc = mouseX + mouseY*video.width;
  c++;
  if (c==1) {
    track1 = video.pixels[loc];
  }
  if (c==2) {
    track2 = video.pixels[loc];
  }
  if (c==3) {
    track3 = video.pixels[loc];
    c=0;
  }
}
void math (float x, float y) {
  th2a = acos((x*x+y*y-l1*l1-l2*l2)/(2*l1*l2));
  th1a = atan2(y, x)-asin((l2*sin(th2a))/(sqrt(x*x+y*y)));
  th2b = -th2a;
  th1b = atan2(y, x)-asin((l2*sin(th2b))/(sqrt(x*x+y*y)));

  th1a = round(th1a*180/PI);
  th2a = round(th2a*180/PI)+90;

  th1b = round(th1b*180/PI);
  th2b = round(th2b*180/PI)+90;
  if (x >300 && y>300) {
    th1Send = int(th1b);   /// The selected Th1 Value
    th2Send = int(th2b);   /// The selected Th2 Value
  } else {
      th1Send = int(th1a);   /// The selected Th1 Value
      th2Send = int(th2a);   /// The selected Th2 Value
    }
    th1Send=constrain(th1Send, 0, 180);
    th2Send=constrain(th2Send, 0, 180);
    println(th1Send);
    println(th2Send);
  }
