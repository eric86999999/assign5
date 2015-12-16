
PImage bg1,bg2,start1,start2,end1,end2,enemy,fighter,hp,treasure,shoot;
//shooting and keyboard touch-----------------------------------
boolean upPressed=false,downPressed=false,leftPressed=false,rightPressed=false;  //key movement
boolean shooting=false;
//general----------------------------
int health;
int bgfirst,bgsecond;
int GAMEMODE=0;
int treasureX,treasureY;
int fighterX,fighterY;
int detection;                  //tracking x location
int shootcount;
//flames------------------------------
int numFlames=5;
PImage[] flames = new PImage[numFlames];
int flameX=2000,flameY=2000;
int currentFrame=0;
//mode&teams-------------------------
final int title=1,playing=2,gameover=3;
int enemyTeams=0;
boolean summon=false;
//scoreboard-----------------------
int value;
boolean scoring=false;
//used for setting teams-----------------------------
int enemyCount=8;
int[] enemyX = new int[enemyCount];
int[] enemyY = new int[enemyCount];

//used for hit detection-----------------------------
final int treasureWidth=41;
final int treasureHeight=41;
final int fighterWidth=51;
final int fighterHeight=51;
final int enemyWidth=61;
final int enemyHeight=61;
final int shootWidth=31;
final int shootHeight=27;
final int Width=640;
final int Height=480;


//----------------------------------------------------
int shootCount=5;
int[] shootX = new int[shootCount];
int[] shootY = new int[shootCount];
boolean shootAllow[]=new boolean[shootCount];

//void scoreChange----------------------------------if enemy shot scoring true
void scoreChange(){  
  if(scoring){
  value+=20;
  scoring=false;
  }
}
//void controls-----------------------------------------
void keyPressed(){  //key detection
    if (key==CODED) {
    switch (keyCode) {
      case UP:
        upPressed=true;
      break;        
      case DOWN:
        downPressed=true;
      break;        
      case LEFT:
        leftPressed=true;
      break;
      case RIGHT:
        rightPressed=true;
      break;      
     }    
    }
    if(keyCode==' '){      
         shooting=true;
    }
}
void keyReleased(){
      if (key==CODED) {
    switch (keyCode) {
      case UP:
        upPressed=false;
        break;
      case DOWN:
        downPressed=false;
        break;
      case LEFT:
        leftPressed=false;
        break;
      case RIGHT:
        rightPressed=false;
        break;
    }
  }
}
//general usage---------------------------------------------------------------
void generalUsage(){
       image(bg2,bgsecond,0);                    //background scrolling
       image(bg1,bgfirst,0);           
          bgfirst+=4;
          bgsecond+=4;
         if(bgfirst==640){                        //bg1 reset
              bgfirst=-640;
               }
         if(bgsecond==640){                        //bg2 reset
              bgsecond=-640;
               }
//hp gauge               
      rectMode(CORNERS);                    //hp gauge 410-610
      fill(255,0,0);
      rect(410,50,health,30);               
      noStroke();
      image(hp,405,28);  
//fighter
      image(fighter,fighterX,fighterY);     //fighter moving
      if(upPressed && fighterY>0){
        fighterY-=3;
      }
      if(downPressed && fighterY<429){
        fighterY+=3;
      }
      if(leftPressed && fighterX>0 ){
        fighterX-=3;
      }
      if(rightPressed && fighterX<589){
        fighterX+=3;
      } 
//treasure       
      image(treasure,treasureX,treasureY);  //treasure
//scoreboard
      fill(255);
      textSize(30);
      text("Score: "+value, 10, 460);
}
//shoot&enemytraveling---------------------------------------
    void objectTravel(){
      for(int x=0;x<enemyCount;x++){
        enemyX[x]+=4;
      }
      for(int x=0;x<shootCount;x++){
        shootX[x]-=4;
      }
     
      for(int x=0;x<enemyCount;x++){
      image(enemy,enemyX[x],enemyY[x]);
      }
      for(int x=0;x<shootCount;x++){
      image(shoot,shootX[x],shootY[x]);
      }
      
      for(int x=0;x<shootCount;x++){
        if(shootX[x]<=-31&&shootX[x]>=(-62)){
          shootX[x]=-9999;
        }
      }
      
      
    }
//initializing teams(remember to break)----------------------------------------------
    void addStraight(){
      int y=floor(random(Height - enemyHeight));      
      for(int x=0;x<5;x++){
       enemyX[x]=-122-81*x; 
       enemyY[x]=y;         
      }      
    }
    void addSlanted(){
      int y=floor(random(Height - enemyHeight));
      int angle=floor(random(y/(-4),(Height-y-enemyHeight)/4));
      for(int x=0;x<5;x++){
       enemyX[x]=-122-81*x; 
       enemyY[x]=y+angle*x;         
      }      
    }
    void addDiamond(){
      int y=floor(random(120,360));   //limit y area to make diamond clear
      int angle;
        if(y<=209.5){                  //area detection
          angle=floor(random(y/2,-60));  
        }else{
          angle=floor(random(19,(419-y)/3));
          }
       for(int x=0;x<enemyCount;x++){  //x area
         enemyX[0]=-122;
         enemyX[1]=-122-81;enemyX[7]=-122-81;
         enemyX[2]=-122-81*2;enemyX[6]=-122-81*2;
         enemyX[3]=-122-81*3;enemyX[5]=-122-81*3;
         enemyX[4]=-122-81*4;
       }
       enemyY[0]=y;enemyY[4]=y;
       enemyY[1]=y+angle;enemyY[3]=y+angle;
       enemyY[5]=y-angle;enemyY[7]=y-angle;
       enemyY[2]=y+2*angle;enemyY[6]=y-2*angle;
      }  
//collisions--------------------------------------------------------------
    void collisions(){
    //treasure get      
     if(isHit(fighterX,fighterY,fighterWidth,fighterHeight,treasureX,treasureY,treasureWidth,treasureHeight)==true){
       treasureX=floor(random(30,589));
       treasureY=floor(random(30,429)); 
       if(health>=590&&health<=610){
         health=610;
       }else{       
       health+=20;
       }
     }   
    //enemy crash     
     for(int i=0;i<enemyCount;i++){
       if(isHit(fighterX,fighterY,fighterWidth,fighterHeight,enemyX[i],enemyY[i],enemyWidth,enemyHeight)==true){
         flameX=enemyX[i];                    //flame spawning
         flameY=enemyY[i];
         currentFrame=0;
         enemyX[i]=9999;                   //enemy remove
           if(health>450){                 //hp minus
              health-=40;
            }else{          
              GAMEMODE=gameover;
                  }    
         }          
     }
    //enemy shoot      
      for(int e=0;e<enemyCount;e++){
        for(int s=0;s<shootCount;s++){
          if(isHit(shootX[s],shootY[s],shootWidth,shootHeight,enemyX[e],enemyY[e],enemyWidth,enemyHeight)==true){
             flameX=enemyX[e];                    //flame spawning
             flameY=enemyY[e];
             enemyX[e]=9999;
             shootX[s]=-9999;
             currentFrame=0;
             scoring=true;                        //get score
                        }           
                 }       
            }            
}
//hit detect-------------------------------------------------------
boolean isHit(float ax,float ay,float aw,float ah,float bx,float by,float bw,float bh){
  if(ax>bx-aw && ax<bx+bw && ay>by-ah && ay<by+bh){
    return true;
  }
  return false;
}
//shooting and allow--------------------------------------------------------
    void shootOut(){
      //allow  
      for(int i=0;i<shootCount;i++){
         if(shootX[i]<0){
           shootAllow[i]=true;
         }else{
           shootAllow[i]=false;
         }    
       }
      //shootout
      if(shooting){
        for(int i=0;i<shootCount;i++){
          if(shootAllow[i]){
            shootX[i]=fighterX-27;
            shootY[i]=fighterY+12;
            i=10;    //reset
            shooting=false;
                }
            }   
          }
      //cancelling if 5 shots on screen    
      if(shootAllow[0]==false&&shootAllow[1]==false&&shootAllow[2]==false&&shootAllow[3]==false&&shootAllow[4]==false){
         shooting=false;
           } 
        }
//flameanimation--------------------------------------------------------------
    void flameAnimation(){
        currentFrame++;
       
        if(currentFrame>=0&&currentFrame<6){
          image(flames[0],flameX,flameY);
        }
        
        if(currentFrame>=6&&currentFrame<12){
          image(flames[1],flameX,flameY);
        }
            
        if(currentFrame>=12&&currentFrame<18){
          image(flames[2],flameX,flameY);
        }
           
        if(currentFrame>=18&&currentFrame<24){
          image(flames[3],flameX,flameY);
        }    
            
         if(currentFrame>=24&&currentFrame<30){
           image(flames[4],flameX,flameY);
         }        
         if(currentFrame==30){
                 flameX=2000;
                 flameY=2000;
               }
        }    
//enemyAdding-------------------------------------------------------------------        
    void enemyAdding(){
      detection+=4;
      if(enemyTeams==1&&summon==false){
        addStraight();
        detection=-122;
        summon=true;
      }
      if(enemyTeams==1 && detection>1000){
        enemyTeams=2;
        summon=false;
      }
      
      if(enemyTeams==2&&summon==false){
        addSlanted();
        detection=-122;
        summon=true;
      }
      
      if(enemyTeams==2 && detection>1000){
        enemyTeams=3;
        summon=false;
      }
      
      if(enemyTeams==3&&summon==false){
        addDiamond();
        detection=-122;
        summon=true;
      }
      if(enemyTeams==3 && detection>1000){
        enemyTeams=1;
        summon=false;
      }
        
    
}
    
    
      
      
      
    
    
void setup(){
//picture startup------------------------------------------------------------
  size(640, 480);
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png"); 
  enemy=loadImage("img/enemy.png");
  fighter=loadImage("img/fighter.png");
  hp=loadImage("img/hp.png");
  treasure=loadImage("img/treasure.png");
  shoot=loadImage("img/shoot.png");
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
 

//flame------------------------------------------------
    for(int i=0;i<5;i++){
      flames[i]=loadImage("img/flame"+(i+1)+".png");   
    }
//general----------------------------------------------------
    GAMEMODE=title;
    bgfirst=0;bgsecond=-640;
    health=450;
    treasureX=floor(random(30,610));
    treasureY=floor(random(30,450));
    fighterX=540;                       
    fighterY=240;
    frameRate(60);
//location startup(outside the screen)----------------------
    for(int x=0;x<enemyCount;x++){
      enemyX[x]=9999;      
    }
    for(int x=0;x<shootCount;x++){
      shootX[x]=-9999;
    }
}

void draw(){
  
   switch(GAMEMODE){
     case title:
         image(start2,0,0);
      if ((mouseX<444 && mouseX>202)&&(mouseY<422 && mouseY>380)){    //detecting mouse area
          image(start1,0,0);
      if(mousePressed){
          enemyTeams=1;
          GAMEMODE=playing;
                 } 
                }
           break;
  
  
      case playing:
        generalUsage();                 
        objectTravel();
        collisions();
        scoreChange();
        shootOut();
        flameAnimation();
        enemyAdding();
        
      
      break;
      
    
    case gameover:
        image(end2,0,0);
      if ((mouseX<width*2/3 && mouseX>width*1/3)&&(mouseY<355 && mouseY>308)){
        image(end1,0,0);
      
          if(mousePressed){                            
            health=450;                         //restart
            fighterX=540;
            fighterY=240;
            bgfirst=0;bgsecond=-640;
            GAMEMODE=playing;
            flameX=2000;
            flameY=2000;
            enemyTeams=1;
            summon=false;
            value=0;
           treasureX=floor(random(30,610));
           treasureY=floor(random(30,450));
            for(int x=0;x<enemyCount;x++){
              enemyX[x]=9999;      
            }
            for(int x=0;x<shootCount;x++){
              shootX[x]=-9999;
            }
  
          }
        }
      
      break;
   }
}
