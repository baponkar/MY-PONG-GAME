import processing.sound.*;
SoundFile bounce_sound,gameover_sound;
PImage img,img1;
int ball_height,ball_width,ball_posX,ball_posY;
int ball_speedX,ball_speedY,pan_posX,pan_posY,pan_speed;
int panW,panH;
int testX,testY;
int score;
boolean leftKey,rightKey,contact;
boolean gameover,startgame;


int gameoverX,gameoverY,gameoverS;
//--------------------------------------------------------------------------
int rectButtonW,rectButtonH,rectButtonX,rectButtonY;
boolean buttonClick;
//----------------------------------------------------------------------------

void setup(){
  size(600,400);
  textSize(32);
  bounce_sound = new SoundFile(this,"ball_bounce.aiff");
  gameover_sound =new SoundFile(this,"gameover.aiff");
  img = loadImage("bounce_image.png");
  img1 = loadImage("gameover.png");
  gameoverX=width/2;gameoverY=height/2;gameoverS=2;
  
  smooth();
   ellipseMode(CENTER);
   rectMode(CENTER);
  panW=60;panH=10; pan_speed=70;pan_posX=width/2;pan_posY=height-panH/2;
  ball_width=40;ball_height=40;ball_posX=width/2;ball_posY=height/2;ball_speedX=2;ball_speedY=2;
  score=0;
  //---------------------------------------------------------------------------------
rectButtonX=width/2;rectButtonY=height/2+60;rectButtonW=100;rectButtonH=50;

}



void draw(){
  
  
  gameMode();
  if(startgame){
    
   startGame();
   
  }
  if(gameover){
    gameOver();
   
  }
  
}

void ball_draw() {
  if(contact){
    stroke(0,10,230);
  }
  stroke(0,0,255);
  fill(255,0,0);
  ellipse(ball_posX,ball_posY,ball_width,ball_height);
  
  
}




void upper_wall(){
  fill(0,0,255);
  noStroke();
  smooth();
  rectMode(CENTER);
  rect(width/2,5,width,20);
}



void pan_draw() {
  fill(0,0,255);
  noStroke();
  smooth();
  rectMode(CENTER);
  rect(pan_posX,pan_posY,panW,panH); 
}

void pan_motion(){
  testX=pan_posX;
  testY=pan_posY; 
  if(leftKey && pan_posX <=panW){
    pan_posX=panW;
       }
   else if(leftKey){
    pan_posX=pan_posX-pan_speed;
  }
  
  
   if(rightKey && pan_posX >=width-panW){
    pan_posX=width-panW;
  }
  else if(rightKey){
    pan_posX=pan_posX+pan_speed;
  } 

  
}

void score(){
  textSize(32);
  text(score,width/2,height/2);
  if(contact && ball_speedY < 0){
    score = score+1;
  }
  
}


void keyReleased(){
  if(key=='a' || key=='A'){
    leftKey=false;
  }
  if( key=='d' || key=='D'){
    rightKey=false;
  }
}

void keyPressed(){
  if(key=='a' || key=='A'){
    leftKey=true;
  }
  if( key=='d' || key=='D'){
    rightKey=true;
  }
}

void contactPan(){

  if((ball_posY == height-ball_height/2-panH) && (ball_posX > pan_posX-panW && ball_posX < pan_posX+panW ) ){
    contact=true;
    bounce_sound.play();
  }
  
  else
  {
    contact=false;
   
  }
  
  
}

void ball_motion() {
 
 
  ball_posX = ball_posX + ball_speedX;
  ball_posY = ball_posY + ball_speedY;
  
   
    if(ball_posX <= ball_width/2 || ball_posX >= width-ball_width/2 ){
       ball_speedX = -1*ball_speedX;
       bounce_sound.play();
    
     }
    
    
     if( ball_posY <= ball_height/2+20){
       ball_speedY = -1*ball_speedY;
       bounce_sound.play();
     }
     if(contact && ball_speedY>0){
      
      
       ball_speedY = -1*ball_speedY;
       
       
     }
}  
    
  
   
     
 
 void  mousePressed(){
     if((mouseX>=rectButtonX-rectButtonW/2 && mouseX <= rectButtonX+rectButtonW/2) && (mouseY>=rectButtonY-rectButtonH/2 && mouseX <= rectButtonY +rectButtonH/2))
{
  buttonClick=true;
}
else{
  buttonClick=false;
}}

void drawButton() {
  
  rect(rectButtonX,rectButtonY,rectButtonW,rectButtonH);
}

void startGame(){
 
  image(img,0,0);
   
  
  ball_draw();
  pan_draw();
  pan_motion();
  contactPan();
  ball_motion();
   upper_wall();
  keyPressed();
  keyReleased();
  score();
  myName();
  
  
}
void gameOver(){
    image(img1,0,0);
    fill(255,0,0);
    stroke(255);
    textSize(30);
    textAlign(CENTER);
    gameoverX=gameoverX+gameoverS;
    if(gameoverX>=width+80){
      gameoverX=-80;
    }
    text("Game Over !",gameoverX,gameoverY);
    text("Your's Score:",width-400,height-50);
    text(score,width-280,height-50);
   fill(255);
   
    
  }

void gameMode(){
  startgame=true;
  gameover=false;
  
  if(ball_posY >= height-panH){
    gameover=true;
    startgame=false;
  }
  if(buttonClick){
    gameover=false;
    startgame=true;
  }
   
  
}

void myName(){
  textSize(10);
  textAlign(LEFT);
  text("@baponkar",0,width/2+100);
}
