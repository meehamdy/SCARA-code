class Detection {
  void colors() {
    video.loadPixels();
    image(video, 0, 0);
    float avgx1 = 0, avgx2=0, avgx3=0;
    float avgy1 = 0, avgy2=0, avgy3=0;
    int count1 = 0, count2=0, count3=0;
    for (int x=0; x<video.width; x++) {
      for (int y=0; y<video.height; y++) {
        int loc=x+y*video.width;
        color current=video.pixels[loc];
        float r0 = red(current);
        float g0 = green(current);
        float b0 = blue(current);
        float r1 = red(track1);
        float g1 = green(track1);
        float b1 = blue(track1);
        float r2 = red(track2);
        float g2 = green(track2);
        float b2 = blue(track2);
        float r3 = red(track3);
        float g3 = green(track3);
        float b3 = blue(track3);
        dis1 = dist(r0, g0, b0, r1, g1, b1);
        dis2 = dist(r0, g0, b0, r2, g2, b2);
        dis3 = dist(r0, g0, b0, r3, g3, b3);
        if (dis1 < threshold) {
          avgx1+=x;
          avgy1+=y;
          count1 ++;
        }
        if (dis2 < threshold) {
          avgx2+=x;
          avgy2+=y;
          count2 ++;
        }
        if (dis3 < threshold) {
          avgx3+=x;
          avgy3+=y;
          count3 ++;
        }
      }
    }
    if (count1 > threshold_dis) { 
      avgx1 = avgx1 / count1;
      avgy1 = avgy1 / count1;
      fill(track1);
      stroke(track1);
      ellipse(avgx1, avgy1, 24, 24);
    }  
    if (count2 > threshold_dis) { 
      avgx2 = avgx2 / count2;
      avgy2 = avgy2 / count2;
      fill(track2);
      stroke(track2);
      ellipse(avgx2, avgy2, 24, 24);
    }  
    if (count3 > threshold_dis) { 
      avgx3 = avgx3 / count3;
      avgy3 = avgy3 / count3;
      fill(track3);
      stroke(track3);
      ellipse(avgx3, avgy3, 24, 24);
    } 
    //if (mode == true ) {
    if (count1>threshold_dis) {
      avx1=avgx1;
      avy1=avgy1;
      avx1=map(avx1, 0, 600, -12, 31);
      avy1=map(avy1, 0, 480, 31, -2);
      //println(avx1);
      //println(avy1);
      math(avx1, avy1);
      if (th1Send ==0 && th2Send==90) {
        myPort.write( str(0)+','+str(0)+','+str(0)+',');
      } else 
      myPort.write(str(th1Send)+','+str(th2Send)+','+str(1)+',');
    } else if (count2>threshold_dis) {
      avx2=avgx2;
      avy2=avgy2;
      avx2=map(avx2, 0, 600, -12, 31);
      avy2=map(avy2, 0, 480, 31, -2);
      //println(avx2);
      //println(avy2);
      math(avx2, avy2);
      if (th1Send ==0 && th2Send==90) {
        myPort.write( str(0)+','+str(0)+','+str(0)+',');
      } else 
      myPort.write(str(th1Send)+','+str(th2Send)+','+str(2)+',');
    } else if (count3>threshold_dis) {
      avx3=avgx3;
      avy3=avgy3;
      avx3=map(avx3, 0, 600, -12, 31);
      avy3=map(avy3, 0, 480, 31, -2);
      //println(avx3);
      //println(avy3);
      math(avx3, avy3);
      if (th1Send ==0 && th2Send==90) {
        myPort.write( str(0)+','+str(0)+','+str(0)+',');
      } else 
      myPort.write(str(th1Send)+','+str(th2Send)+','+str(3)+',');
    } else {
      myPort.write( str(0)+','+str(0)+','+str(0)+',');
    }
  }
}
