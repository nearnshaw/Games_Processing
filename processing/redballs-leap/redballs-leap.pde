
							int life = 50;
							int prize = 0;
							int flee= 0;
							int score;
							int power = 1000;
							int level = 1;
							car[] auto = new car[10];
							hole[] holes = new hole[5];
							salvation salvador = new salvation();
							target[] objetivo = new target[3];
							int gameover = 0;
							int youwin = 0;
							//float leapX =200;
							//float leapY = 200;
							boolean leap_enabled = false;



													// interface JavaScript {
												 //    void showXYCoordinates(int x, int y);
												 //  }

												 //  void bindJavascript(JavaScript js) {
												 //    javascript = js;
												 //  }

												 //  JavaScript javascript;


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

							  //leapX = leapPosition[0];
							  //leapY =leapPosition[1];
							  
							  if (gameover == 0 & youwin == 0)
							  {
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
								  
								  if (prize > 600)
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
								  if (life <1){gameover = 40;}
								  if (score == objetivo.length){youwin = 40;}
								  drawMe();
								  
								  if(flee ==1)
								  {
									noFill();
									rect(400,10,50,10);
									fill(0,255,255);
									rect(401,10,(power/20)-1,9);
								  }
							  }
								else if (youwin > 0){
								  youwin -=1;
								  fill(0,255,30);
								  rect(0,0, width, height);
								   }
								else if (gameover > 0) {  
								  gameover -=1;
								  fill(0,30);
								  rect(0,0, width, height);
								   }
								if (gameover ==1)  
									{resetall();};
								if (youwin ==1)  
									{nextlevel();};
							}
								
							void drawMe()
							{
							 stroke(0);
							 fill(230,230,255);
							 noStroke();
							ellipse(leapvars.leapX,leapvars.leapY,10,10);
							}
								

							void resetall()
							{
							  fill(255,30);
							  rect(0,0, width, height);
							  
							  life = 50;
							  prize = 0;
							  flee= 0;
							  score = 0;
							  power = 1000;
							  level = 1;
							  gameover = 0;
							  youwin = 0;
							  
								
							  for (int j = 0; j< holes.length; j++)
							  {holes[j] = new hole();}
							  
							  for (int i = 0; i< auto.length; i++)
							  {auto[i] = new car(holes, auto, i);}
							  
							  for (int n = 0; n<objetivo.length;n++)
							  {objetivo[n] = new target(holes);}
							  
							  salvador = new salvation();
								
							  
							  
							}
							
							
							void nextlevel()
							{
							  fill(255,30);
							  rect(0,0, width, height);
							  
							  life = 50;
							  prize = 0;
							  score = 0;
							  flee= 0;
							  power = 1000;
							  gameover = 0;
							  youwin = 0;
							  
							  
							  //car = null;
							  //hole = null;
							  //target = null;
							  
							level += 1;
							
							
						
							
							int ncar = level*10;
							car[] auto = 0;
							car[] auto = new car[ncar];
						
							  
								
							 for (int j = 0; j< holes.length; j++)
							  {holes[j] = new hole();}
							  
							  for (int i = 0; i< auto.length; i++)
							  {auto[i] = new car(holes, auto, i);}
							  
							  for (int n = 0; n<objetivo.length;n++)
							  {objetivo[n] = new target(holes);}
							  
							  salvador = new salvation();
								
								
							  
							  
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
							if (abs(leapvars.leapX - lx)<10 && abs(leapvars.leapY - ly)<10)
							{
							  background(255,0,0);
							  life-=5;
							}
							}
							}


							////////////////////////////////////////////////////////balls
							class car
							{
							PVector location;
							PVector speed;
							PVector acceleration;
							PVector leap;
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
							  leap = new PVector (leapvars.leapX,leapvars.leapY);
							 PVector dir = PVector.sub(leap, location);
							 dir.mult(0.0015);
							 acceleration = dir;
							 if ((mousePressed)&& flee ==1 && power > 0)  {acceleration.mult(-1); power-=1;}
							   
							  speed.add(acceleration);
							  speed.limit(speedmax);
							  location.add(speed);
							  
							}

							void bounce()
							{
															  
								if (location.x < 0){speed.x*=(-1); acceleration.x*=(-1);}
								else if (location.x>width) {speed.x*=(-1);acceleration.x*=(-1);}

								if (location.y < 0){speed.y*=(-1);acceleration.y*=(-1);}
								else if (location.y>height) {speed.y*=(-1);acceleration.y*=(-1);}


							for (int i = 0;i<others.length;i++)
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
							if (abs(location.x-holes[n].lx)<6 && abs(location.y-holes[n].ly)<6)
							{
							  acceleration = new PVector (0,0);
							  location.mult(-3);
								}
							  }
							}
							void killyou()
							{
							if (abs(leapvars.leapX - int(location.x))< 8 && abs(leapvars.leapY - int(location.y))<8)
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
							  if(abs(leapvars.leapX - sx)<5 && abs(leapvars.leapY - sy)<5)
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
							  if(mousePressed && abs(leapvars.leapX -location.x)<7 && abs(leapvars.leapY - location.y)<7)
							  {
							  PVector[] leap = new PVector[3] ;
							  if(leap[0] == null){leap[0]= location;}
							  leap[2] = leap[1];
							  leap[1] = new PVector(leapvars.leapX,leapvars.leapY);
							  
							  PVector dir = new PVector();
							  dir = PVector.sub(leap[0], leap[1]);
							  acceleration.add(dir);
							  speed = acceleration;  
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
							  location = new PVector(0,0);
							  score += 1;
								}
							  }

							  
							  
							}
							 void bounce()
							{
							  
							if (location.x == 0 & location.y == 0){speed = 0;}
							else if (location.x < 0){ speed = new PVector(5,0);}
							else if (location.x>width) {speed = new PVector(-5,0);;}
							
							//else if (location.x < 10){ acceleration.mult(-1);}
							//else if (location.x>width-10) {acceleration.mult(-1);}
							
							
							if (location.x == 0 & location.y == 0){speed = 0;}
							else if (location.y < 0){speed = new PVector(0,5);}
							else if (location.y>height) {speed = new PVector(0,-5);;}

							//else if (location.y < 10){acceleration.mult(-1);}
							//else if (location.y>height-10) {acceleration.mult(-1);}
							
							

							}

							}	
		
