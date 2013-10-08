
Maxim maxim;
AudioPlayer player;
float[] spec;
int xPos;
float oscil;
float thresh;
int wait;
int shift;

void setup()
{
  background(0);
 
   size(600,600);
   maxim = new Maxim(this);
   player = maxim.loadFile("mykbeat.wav");
   player.setLooping(true);
   player.play();
   player.setAnalysing(true);
   xPos = 0;
   oscil = 0;
   wait = 25;
   thresh = 200;
   shift = 0;
 
}

void draw()
{  


  
 // background(0);
   float pow;
   strokeWeight(1);
   fill(0,0,0,20);
   rect(130,140,340,320);
   
   spec = player.getPowerSpectrum();
   if (spec!=null)
   {
      for (int r=0; r<360; r+=120)
        {
        pushMatrix();
        translate(width/2,height/2);
        rotate(radians(r+shift));
        xPos = spec.length/5*2;
        for (int i=5;i<spec.length;i+=5)
         { 
           
           //fill(255*spec[i],0,0);
           //rect(0,i,spec[i]*width, 2);
           //stroke(255);
           stroke(255* spec[i]*2);
           //point(xPos, spec[i]*100);
           line(xPos+2,spec[i-5]*300,xPos,spec[i]*300);
           xPos += -2;
         }
       popMatrix();
       //xPos = 0;
        }
       
   }
    pow = player.getAveragePower(); 
    
    //cursor pulsante
    colorMode(HSB);
    noStroke();
    pow = map(pow,0,0.5,0,360);
    fill(pow,100,100);
    ellipse(mouseX,mouseY,sin(oscil)*30,sin(oscil)*30);
    ellipse(width-mouseX,mouseY,sin(oscil)*30,sin(oscil)*30);
    ellipse(mouseX,height-mouseY,sin(oscil)*30,sin(oscil)*30);
    ellipse(width-mouseX,height-mouseY,sin(oscil)*30,sin(oscil)*30);

    //centro pulsante
    colorMode(RGB);
    fill(0,0,0);
    strokeWeight(3);   
    stroke(255,60,60,60);   
    ellipse(width/2,height/2,sin(oscil)*15,sin(oscil)*15);
    noStroke();
    
   oscil += 0.1;

  if (pow > thresh && wait<0)
  {
    //rect(0,height/5*4,width,height/5);
    wait = 30;
    shift+=51;
    println(pow);
  }
  wait --;
  

}

void mousePressed()
{
}

