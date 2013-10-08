PImage body1;
PImage hand1;
float angle = 0;
boolean waveup = true;

handle manija;
knot nudo;

void setup()
{
    size (800, 425);
    smooth();
    body1 = loadImage("grumpycat.jpg");
    hand1 = loadImage("paw4.png");
    manija = new handle(650, 150);   
    nudo = new knot(200, 330, 290, 450);
    
}

void draw()
{
  background(102);
  
  

  fill(70, 60, 50);
  //circulo 2 se dibuja dps para sobreescribir line
  ellipse(625, 50, 50,50);
  fill(25);

  ellipse(625, 50, 5,5);
  line(600,50,575,350);
  manija.move();
  line(650,50, manija.hx, manija.hy-20);
  manija.display();
  

  
  //int a = linea.x1;
  //line(400,35,750,35);
  pushMatrix();
  translate(300, 405);
  rotate(angle);
  image(hand1, -50, -180);

  
  

  if (manija.pressed == true)
  {
    angle = float(manija.hy-150)/180;
  }
  else if (angle > 0 )
  {
    angle -= 0.02;
    manija.hy -= 2.6;
    
  }
  
  popMatrix();
  nudo.move(angle);
  image(body1, 50, 150);
  fill(70, 60, 50);
  nudo.display();
  ellipse(550, 350, 50,50);
  fill(25);
  ellipse(550, 350, 5,5);
  fill(90, 60, 60);
  rect(20,380,400,70);

  
}

class handle
{
    int hx;
    int hy;
    boolean pressed = false; 
  
   handle(int x, int y)
    {
      hx = x;
      hy = y;
    }

  void display()
  {
  fill(150,100,50);
  ellipse(hx, hy, 20, 40);
 
  }
  
  void move()
  {
  if (mousePressed && mouseX > (hx-40) && mouseX < (hx+40) && mouseY < (hy+55) && mouseY > (hy-55))
  {
  hy = mouseY;
  pressed = true;
  if(hy>250){hy=250;}
  if(hy<150){hy=150;}
  
  }
  else
    {pressed= false;}
  
  }
}

class knot
{
  int armlength = 180 ;
  float xyratio;
  float kx;
  float ky;
  float relx;
  float rely;
  float vertexx;
  float vertexy;
  
knot(int knotx, int knoty, int vx, int vy)
{
  

  vertexx = vx;
  vertexy = vy;
  
  //kx = knotx;
  //ky = knoty;
  //relx = -180;
  //rely = -280;
  
  
  
}

void move(float angle)
{
  
  relx = sin(angle)*armlength;
  kx = relx + vertexx;
  rely = sqrt(armlength*armlength-relx*relx);
  ky = vertexy - rely;
 
  
}
void display()
{
   line(550,375, kx,ky);
}

}




