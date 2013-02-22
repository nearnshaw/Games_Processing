int life = 50;
int prize = 0;
int flee= 0;
int score;
int power = 1000;
car[] auto = new car[10];
hole[] holes = new hole[5];
salvation salvador = new salvation();
target[] objetivo = new target[3];

void setup()
{
background(255);
size(500,500);


for (int j = 0; j< holes.length; j++)
{holes[j] = new hole();}

for (int i = 0; i< auto.length; i++)
{auto[i] = new car(holes, auto, i);}

for (int n = 0; n<objetivo.length;n++)
{objetivo[n] = new target(holes);}

salvador = new salvation();

}
//////////////////////////////////////////////////////draw

void draw()
{
  fill(255,30);
  rect(0,0, width, height);
  
  for (int j = 0; j < holes.length; j++)
  {
  holes[j].killyou();
  holes[j].display();
   }
  
  for (int i = 0; i < auto.length; i++)
  {
  auto[i].move();
  auto[i].bounce();
  auto[i].display();
  auto[i].killyou();
  auto[i].die();
  }
  
  if (prize > 400)
  {
  salvador.display();
  salvador.shoo();
  }
  prize += 1;
  
  for (int n=0;n<objetivo.length;n++)
  {
    objetivo[n].display();
    objetivo[n].move();
    objetivo[n].bounce();
    objetivo[n].drop();
    
  }
  
  fill(255,0,0);
  rect(400,30,50,10);
  fill(0,255,0);
  rect(401,31,life-1,9);
  if (life ==0){exit();}
  if (score == objetivo.length){exit();}
  
  if(flee ==1)
  {
    noFill();
    rect(400,10,50,10);
    fill(0,255,255);
    rect(401,10,(power/20)-1,9);
  }
  
  
}



/////////////////////////////////////////////////////////holes
class hole
{
  float lx;
  float ly;
 
  hole()
  {
    lx = random(0,500);
    ly = random(0,500);
    
    }
void display()
{
  stroke(0);
  fill(1);
  ellipse(lx,ly,20,20);
 
}
void killyou()
{
if (abs(mouseX - lx)<10 && abs(mouseY - ly)<10)
{
  background(255,0,0);
  life-=1;
}
}
}


////////////////////////////////////////////////////////balls
class car
{
PVector location;
PVector speed;
PVector acceleration;
PVector mouse;
PVector dir;
float speedmax = 5;
hole[] holes;
car[] others;
int ID;

car(hole[] hos, car[] othr, int tID){
location = new PVector(random(0,500),random(0,500));
speed = new PVector(0,0);
acceleration = new PVector(1,1);
holes = hos;
others = othr;
ID = tID;}

void display()
{
  stroke(0);
 fill(255,0,0);
ellipse(location.x,location.y,16,16);
}

void move()
{
  mouse = new PVector (mouseX,mouseY);
 PVector dir = PVector.sub(mouse, location);
 dir.mult(0.0015);
 acceleration = dir;
 if ((mousePressed)&& flee ==1 && power > 0)  {acceleration.mult(-1); power-=1;}
   
  speed.add(acceleration);
  speed.limit(speedmax);
  location.add(speed);
  
}

void bounce()
{
  
if (location.x < 0){speed.mult(-1); acceleration.mult(-1);}
else if (location.x>width) {speed.mult(-1);acceleration.mult(-1);}

if (location.y < 0){speed.mult(-1);acceleration.mult(-1);}
else if (location.y>height) {speed.mult(-1);acceleration.mult(-1);}

for (int i = ID+1;i<others.length;i++)
{ 
      float dx = others[i].location.x - location.x;
      float dy = others[i].location.y - location.y;
      float distance = sqrt(dx*dx + dy*dy);
    if (distance < 20)
  {
    speed.x -= dx/3;
    speed.y -= dy/3;
  }
}

}
void die()
{
  for (int n=0; n < holes.length; n++)
  {
if (abs(location.x-holes[n].lx)<5 && abs(location.y-holes[n].ly)<5)
{
  acceleration = new PVector (0,0);
  location.mult(-3);
    }
  }
}
void killyou()
{
if (abs(mouseX - int(location.x))< 5 && abs(mouseY - int(location.y))<5)
{
  background(255,0,0);
  life-=1;
}
}

}

////////////////////////////////////////////////////salvation

class salvation
{
  float sx =0;
  float sy =0;
  int time;
  salvation()
  {
  sx = random(0, 500);
  sy = random(0, 500);
  time = 500;  
}
  
  void display()
  {
    if (time > 1 && flee == 0){
  stroke(0);
  fill(0,255,0);
  ellipse(sx,sy,10,10);
  time -=1;
    }
     }
  void shoo()
  {
  if(abs(mouseX - sx)<5 && abs(mouseY - sy)<5)
  {  flee = 1; }
   }
}

///////////////////////////////////////////////////target
class target
{
PVector location;
PVector speed;
PVector acceleration;
PVector friction;
float speedmax = 1;
hole[] holes;
  target(hole[] holest)
  {
  location = new PVector (random(0,500), random(0,500));
  speed = new PVector (0,0);
  acceleration = new PVector (0,0);
  friction = new PVector (0.98,0.98);
  holes = holest;
  }
  void display()
{  
  stroke(0);
  fill(255,255,0);
  ellipse (location.x,location.y,10,10);
  
}
  void move()
{
  if(mousePressed && abs(mouseX -location.x)<7 && abs(mouseY - location.y)<7)
  {
  PVector[] mouse = new PVector[3] ;
  if(mouse[0] == null){mouse[0]= location;}
  mouse[2] = mouse[1];
  mouse[1] = new PVector(mouseX,mouseY);
  
  PVector dir = new PVector();
  dir = PVector.sub(mouse[0], mouse[1]);
  acceleration.add(dir);
  speed.add(acceleration);  
}
  
  location.add(speed);
  speed.limit(speedmax);
  speed.mult(friction);  

}
  void drop()
{
  for (int n=0; n < holes.length; n++)
  {
if (abs(location.x-holes[n].lx)<9 && abs(location.y-holes[n].ly)<9)
{
  location.mult(-3);
  score += 1;
    }
  }

  
  
}
 void bounce()
{
  
if (location.x < 0){speed.mult(-1); acceleration.mult(-1);}
else if (location.x>width) {speed.mult(-1);acceleration.mult(-1);}

if (location.y < 0){speed.mult(-1);acceleration.mult(-1);}
else if (location.y>height) {speed.mult(-1);acceleration.mult(-1);}



}

}
