#include <VarSpeedServo.h>
VarSpeedServo servo1;
VarSpeedServo servo2;
VarSpeedServo servo3;
VarSpeedServo servo4;
boolean mode = true, mode1 = true;
String  x , y, z;
int a1, a2, S;
int a1o , a2o , so;
void setup() {
  Serial.begin(115200);
  servo1.attach(2);
  servo2.attach(3);
  servo3.attach(4);
  servo4.attach(5);
  Serial.write(1);
  servo1.write(0, 50, true);
  servo2.write(90, 50, true);
  servo3.write(150, 50, true);
  servo4.write(95, 50, true);

}

void loop() {
  if (mode1) {
    if (Serial.available()) {
      x = Serial.readStringUntil(',');
      y = Serial.readStringUntil(',');
      z = Serial.readStringUntil(',');

      a1 = x.toInt();
      a2 = 180 - y.toInt();
      S = z.toInt();
      if ( a1 == a1o && a2 == a2o && S == so ) {
        mode = false ;
      }
      else {
        mode = true;
      }
      while (Serial.available()) {
        Serial.read();
      }
      a1o = a1;
      a2o = a2;
      so = S;
    }
  }
  if ( mode ) {
    if (S == 1) {
      mode1 = false;
      Serial.write(0);
      //      if (a1 > 0 && a1 < 30) {
      //        servo1.write(a1, 50, true);
      //        servo2.write(a2 + 15, 50, true);
      //      } else {
      //        servo1.write(a1 + 15, 50, true);
      //        servo2.write(a2, 50, true);
      //      }
      servo1.write(a1 + 8, 50, true);
      servo2.write(a2, 50, true);
      gripper();
      red();
      drop();
      origin();
      mode1 = true;
      //    Serial.write(1);
    }
    else if (S == 2) {
      //    Serial.write(0);
      mode1 = false;
      servo1.write(a1 + 15, 50, true);
      servo2.write(a2, 50, true);
      servo2.writeMicroseconds(map(a2, 0, 180, 630, 2400));
      gripper();
      yellow();
      drop();
      origin();
      mode1 = true;
      //    Serial.write(1);
    }
    else if (S == 3) {
      //    Serial.write(0);
      mode1 = false;
      servo1.write(a1 + 15, 50, true);
      servo2.write(a2, 50, true);
      servo2.writeMicroseconds(map(a2, 0, 180, 630, 2400));
      gripper();
      blue();
      drop();
      origin();
      mode1 = true;
      //    Serial.write(1);

    }
    else if (S == 0) {
      servo1.write(0, 50, true);
      servo2.write(90, 50, true);
      servo3.write(150, 50, true);
      servo4.write(95, 50, true);

    }
  }
}
void gripper() {
  servo3.write(50, 50, true);
  servo4.write(165, 50, true);
  servo3.write(150, 50, true);
}
void drop() {
  servo3.write(90, 50, true);
  servo4.write(80, 50, true);
  servo3.write(150, 50, true);
}
void red() {
  servo1.write(100, 50, true);
  servo2.write(0, 50, true);
}
void yellow() {
  servo1.write(100, 50, true);
  servo2.write(25, 50, true);
}
void blue() {
  servo1.write(125, 50, true);
  servo2.write(0, 50, true);
}
void origin() {
  servo1.write(0, 50, true);
  servo2.write(90, 50, true);
  servo3.write(175, 50, true);
  servo4.write(95, 50, true);
}

