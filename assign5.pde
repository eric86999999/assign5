PPImage bg1,bg2,start1,start2,end1,end2,enemy,fighter,hp,treasure,shoot;


boolean upPressed=false,downPressed=false,leftPressed=false,rightPressed=false;  //key movement
boolean shooting=false;

int health,bgX,bgY,fighterX,fighterY,treasureX,treasureY,shootX;
int GAMEMODE=1,ENEMYTEAM=0,shootcount=0;
final int title=1,playing=2,gameover=3;
final int straight=1,slanted=2,diamond=3;
//-straight startup
int[] teamStraight=new int[5];        //saving x value
int teamStrY=floor(random(0,419));    //saving y value
int straightTrack;                    //tracking x value(if the leader is destroyed)
//slanted startup
int[] teamSlanted=new int[5];  
float teamSlaY=floor(random(20,399));
float teamSlaAngle=0;
int slantedTrack;
//diamond startup
int[] teamDiamond=new int[8];
float teamDiaY=floor(random(40,379));
float teamDiaAngle;
int diamondTrack;
//shoot startup
int[] shootCount=new int[5];
int[] shootY=new int[5];
int[] shootTouch=new int[5];
boolean[] shootAllow=new boolean[5];
//fighter detect touch
int upDetect,downDetect,leftDetect,rightDetect;
//flame startup
int numFlames=5;
int currentFlame;
PImage[] flames = new PImage[numFlames];
float flameX=2000,flameY=2000;     //tracking axis
//score count
int value=0;



void scoreChange(){
  
  value+=20;

}
































void setup () {
  size(640, 480) ;
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
  
  
//---------------------------  



  
//-------------------------------------  
  
  
  
  treasureX=floor(random(30,610));
  treasureY=floor(random(30,450));
  bgX=0;
  bgY=-640;
  fighterX=540;                       
  fighterY=240;
  health=450;
  treasureX=floor(random(30,610));
  treasureY=floor(random(30,450));
  frameRate(60);
//straight startup
  for(int count1=0;count1<5;count1++){                       
            teamStraight[count1]=-61-61*count1*13/10;         
          }
          teamStrY=floor(random(0,419));
  straightTrack=teamStraight[0];
//slanted startup
  for(int count2=0;count2<5;count2++){                       
            teamSlanted[count2]=-61-61*count2*13/10;         
          }
          teamSlaY=floor(random(0,419));
          teamSlaAngle=random(teamSlaY/(-5),(480-teamSlaY-61)/5);
  slantedTrack=teamSlanted[0];
//diamond startup
  if(teamDiaY<=209.5){                  //area detection
    teamDiaAngle=random(teamDiaY/3,0);  
    }else{
    teamDiaAngle=random((419-teamDiaY)/3,0);
    }
    
  for(int count3=0;count3<5;count3++){                       
            teamDiamond[count3]=-61-61*count3*13/10;         
          } 
  for(int count4=5;count4<8;count4++){
            teamDiamond[count4]=-61-61*(8-count4)*13/10;
    
          }
  diamondTrack=teamDiamond[0];

//initialize shots

  for(int i=0;i<5;i++){
        shootCount[i]=1000000;
     }
  for(int i=0;i<5;i++){
        shootY[i]=fighterY;
     }   
  for(int i=0;i<5;i++){
        shootAllow[i]=true;
     }
//initialize flame
    currentFlame=0;
    for(int i=0;i<5;i++){
      flames[i]=loadImage("img/flame"+(i+1)+".png");
      
    
    }
    

}



void draw()
{
   
   switch(GAMEMODE){
     case title:
         image(start2,0,0);
    if ((mouseX<444 && mouseX>202)&&(mouseY<422 && mouseY>380)){    //detecting mouse area
        image(start1,0,0);
    if(mousePressed){
        ENEMYTEAM=straight;
        GAMEMODE=playing;
               } 
              }
         break;
     

 
     case playing:
     
    
       image(bg2,bgY,0);                    //background scrolling
       image(bg1,bgX,0);           
          bgX+=4;
          bgY+=4;
         if(bgX==640){                        //bg1 reset
              bgX=-640;
               }
         if(bgY==640){                        //bg2 reset
              bgY=-640;
               }
   
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

      rectMode(CORNERS);                    //hp gauge 410-610
      fill(255,0,0);
      rect(410,50,health,30);               
      noStroke();
      image(hp,405,28);  

      image(treasure,treasureX,treasureY);  //treasure  
     
//touching detect
       upDetect=floor(random(fighterX,fighterX+51));
       downDetect=floor(random(fighterX,fighterX+51));
       leftDetect=floor(random(fighterY,fighterY+51));
       rightDetect=floor(random(fighterY,fighterY+51));
       
//healing detect 
       if( leftDetect>=treasureY && leftDetect<=treasureY+41 && fighterX>=treasureX && fighterX<=treasureX+41 || rightDetect>=treasureY && rightDetect<=treasureY+41 && fighterX+51>=treasureX && fighterX+51<=treasureX+41
       || leftDetect>=treasureY && leftDetect<=treasureY+41 && fighterX>=treasureX && fighterX<=treasureX+41 || rightDetect>=treasureY && rightDetect<=treasureY+41 && fighterX+51>=treasureX && fighterX+51<=treasureX+41){
          treasureX=floor(random(0,589));
          treasureY=floor(random(0,429));      
          if(health<=590){
          health+=20;
            }
         }      
//shooting detect
        shootCount[0]-=4;shootCount[1]-=4;shootCount[2]-=4;shootCount[3]-=4;shootCount[4]-=4;
        image(shoot,shootCount[0],shootY[0]+14);image(shoot,shootCount[1],shootY[1]+14);image(shoot,shootCount[2],shootY[2]+14);image(shoot,shootCount[3],shootY[3]+14);image(shoot,shootCount[4],shootY[4]+14);
        
          if(shooting && shootAllow[0]){
          shootCount[0]=fighterX-27;
          shootY[0]=fighterY;
          shootAllow[0]=false;
          shooting=false;        
        }
        
        if(shooting && shootAllow[1]){
          shootCount[1]=fighterX-27;
          shootY[1]=fighterY;
          shootAllow[1]=false;
          shooting=false;        
        }
        
        if(shooting && shootAllow[2]){
          shootCount[2]=fighterX-27;
          shootY[2]=fighterY;
          shootAllow[2]=false;
          shooting=false;        
        }
        
        if(shooting && shootAllow[3]){
          shootCount[3]=fighterX-27;
          shootY[3]=fighterY;
          shootAllow[3]=false;
          shooting=false;        
        }
        if(shooting && shootAllow[4]){
          shootCount[4]=fighterX-27;
          shootY[4]=fighterY;
          shootAllow[4]=false;
          shooting=false;        
        }
        
      
        if(shootCount[0]<=(-31)){
        shootCount[0]=1000000;
        shootAllow[0]=true;
        shooting=false;
            }
        if(shootCount[1]<=(-31)){
        shootCount[1]=1000000;
        shootAllow[1]=true;
        shooting=false;
            }
        if(shootCount[2]<=(-31)){
        shootCount[2]=1000000;
        shootAllow[2]=true;
        shooting=false;
            }
        if(shootCount[3]<=(-31)){
        shootCount[3]=1000000;
        shootAllow[3]=true;
        shooting=false;
            }
        if(shootCount[4]<=(-31)){
        shootCount[4]=1000000;
        shootAllow[4]=true;
        shooting=false;
            }
//flame detect
    currentFlame++;
    if(currentFlame>=0&&currentFlame<6){
      image(flames[0],flameX,flameY);
    }
    
    if(currentFlame>=6&&currentFlame<12){
      image(flames[1],flameX,flameY);
    }
        
    if(currentFlame>=12&&currentFlame<18){
      image(flames[2],flameX,flameY);
    }
       
    if(currentFlame>=18&&currentFlame<24){
      image(flames[3],flameX,flameY);
    };    
        
     if(currentFlame>=24&&currentFlame<30){
       image(flames[4],flameX,flameY);
     }        
     if(currentFlame==30){
             flameX=2000;
             flameY=2000;};
             
             
//-------------------------------------------
//scoreboard
    fill(255);
    textSize(24);
    text("Score: "+value, 10, 460);
    
//-------------------------------------        


//enemy teams
      switch(ENEMYTEAM){
        case straight:
        
        image(enemy,teamStraight[0],teamStrY);
        image(enemy,teamStraight[1],teamStrY);
        image(enemy,teamStraight[2],teamStrY);
        image(enemy,teamStraight[3],teamStrY);
        image(enemy,teamStraight[4],teamStrY);
                
        teamStraight[0]+=4;
        teamStraight[1]+=4;
        teamStraight[2]+=4;
        teamStraight[3]+=4;
        teamStraight[4]+=4;
        straightTrack+=4;
      
//ship0 
        if(upDetect>=teamStraight[0] && upDetect<=teamStraight[0]+61 && fighterY>=teamStrY && fighterY<=teamStrY+61 || downDetect>=teamStraight[0] && downDetect<=teamStraight[0]+61 && fighterY+51>=teamStrY && fighterY+51<=teamStrY+61
      || leftDetect>=teamStrY && leftDetect<=teamStrY+61 && fighterX>=teamStraight[0] && fighterX<=teamStraight[0]+61 ){
          flameX=teamStraight[0];      //flame axis
          flameY=teamStrY;
          currentFlame=0;
          teamStraight[0]=5000;
          
        
        if(health>450){
          health-=40;          
           }else{          
            GAMEMODE=gameover;
          }         
          }
        if(shootCount[0]<=teamStraight[0] && shootCount[0]>=teamStraight[0]-61 && shootY[0]+13.5>teamStrY && shootY[0]+13.5<teamStrY+61){             //bullet hit
           flameX=teamStraight[0];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[0]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamStraight[0] && shootCount[1]>=teamStraight[0]-61 && shootY[1]+13.5>teamStrY && shootY[1]+13.5<teamStrY+61){
           flameX=teamStraight[0];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[0]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamStraight[0] && shootCount[2]>=teamStraight[0]-61 && shootY[2]+13.5>teamStrY && shootY[2]+13.5<teamStrY+61){
           flameX=teamStraight[0];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[0]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamStraight[0] && shootCount[3]>=teamStraight[0]-61 && shootY[3]+13.5>teamStrY && shootY[3]+13.5<teamStrY+61){
           flameX=teamStraight[0];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[0]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamStraight[0] && shootCount[4]>=teamStraight[0]-61 && shootY[4]+13.5>teamStrY && shootY[4]+13.5<teamStrY+61){
           flameX=teamStraight[0];
           flameY=teamStrY;
           teamStraight[0]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }        
//ship1                        
        if(upDetect>=teamStraight[1] && upDetect<=teamStraight[1]+61 && fighterY>=teamStrY && fighterY<=teamStrY+61 || downDetect>=teamStraight[1] && downDetect<=teamStraight[1]+61 && fighterY+51>=teamStrY && fighterY+51<=teamStrY+61
      || leftDetect>=teamStrY && leftDetect<=teamStrY+61 && fighterX>=teamStraight[1] && fighterX<=teamStraight[1]+61){
        flameX=teamStraight[1];
        flameY=teamStrY;
        currentFlame=0;
        teamStraight[1]=5000;
                  
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
        }
        if(shootCount[0]<=teamStraight[1] && shootCount[0]>=teamStraight[1]-61 && shootY[0]+13.5>teamStrY && shootY[0]+13.5<teamStrY+61){             //bullet hit
           flameX=teamStraight[1];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[1]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamStraight[1] && shootCount[1]>=teamStraight[1]-61 && shootY[1]+13.5>teamStrY && shootY[1]+13.5<teamStrY+61){
           flameX=teamStraight[1];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[1]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamStraight[1] && shootCount[2]>=teamStraight[1]-61 && shootY[2]+13.5>teamStrY && shootY[2]+13.5<teamStrY+61){
           flameX=teamStraight[1];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[1]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamStraight[1] && shootCount[3]>=teamStraight[1]-61 && shootY[3]+13.5>teamStrY && shootY[3]+13.5<teamStrY+61){
           flameX=teamStraight[1];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[1]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         
         if(shootCount[4]<=teamStraight[1] && shootCount[4]>=teamStraight[1]-61 && shootY[4]+13.5>teamStrY && shootY[4]+13.5<teamStrY+61){
           flameX=teamStraight[1];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[1]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }
//ship2                 
        if(upDetect>=teamStraight[2] && upDetect<=teamStraight[2]+61 && fighterY>=teamStrY && fighterY<=teamStrY+61 || downDetect>=teamStraight[2] && downDetect<=teamStraight[2]+61 && fighterY+51>=teamStrY && fighterY+51<=teamStrY+61
      || leftDetect>=teamStrY && leftDetect<=teamStrY+61 && fighterX>=teamStraight[2] && fighterX<=teamStraight[2]+61){
           flameX=teamStraight[2];
           flameY=teamStrY;
           currentFlame=0;   
           teamStraight[2]=5000;        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
        }
        if(shootCount[0]<=teamStraight[2] && shootCount[0]>=teamStraight[2]-61 && shootY[0]+13.5>teamStrY && shootY[0]+13.5<teamStrY+61){             //bullet hit
           flameX=teamStraight[2];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[2]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamStraight[2] && shootCount[1]>=teamStraight[2]-61 && shootY[1]+13.5>teamStrY && shootY[1]+13.5<teamStrY+61){
           flameX=teamStraight[2];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[2]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamStraight[2] && shootCount[2]>=teamStraight[2]-61 && shootY[2]+13.5>teamStrY && shootY[2]+13.5<teamStrY+61){
           flameX=teamStraight[2];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[2]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamStraight[2] && shootCount[3]>=teamStraight[2]-61 && shootY[3]+13.5>teamStrY && shootY[3]+13.5<teamStrY+61){
           flameX=teamStraight[2];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[2]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamStraight[2] && shootCount[4]>=teamStraight[2]-61 && shootY[4]+13.5>teamStrY && shootY[4]+13.5<teamStrY+61){
           flameX=teamStraight[2];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[2]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }
//ship3        
        if(upDetect>=teamStraight[3] && upDetect<=teamStraight[3]+61 && fighterY>=teamStrY && fighterY<=teamStrY+61 || downDetect>=teamStraight[3] && downDetect<=teamStraight[3]+61 && fighterY+51>=teamStrY && fighterY+51<=teamStrY+61
      || leftDetect>=teamStrY && leftDetect<=teamStrY+61 && fighterX>=teamStraight[3] && fighterX<=teamStraight[3]+61){
           flameX=teamStraight[3];
           flameY=teamStrY;
           currentFlame=0;   
           teamStraight[3]=5000;        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
        }
        if(shootCount[0]<=teamStraight[3] && shootCount[0]>=teamStraight[3]-61 && shootY[0]+13.5>teamStrY && shootY[0]+13.5<teamStrY+61){             //bullet hit
           flameX=teamStraight[3];
           flameY=teamStrY;
           currentFlame=0; 
           teamStraight[3]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamStraight[3] && shootCount[1]>=teamStraight[3]-61 && shootY[1]+13.5>teamStrY && shootY[1]+13.5<teamStrY+61){
           flameX=teamStraight[3];
           flameY=teamStrY;
           currentFlame=0; 
           teamStraight[3]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamStraight[3] && shootCount[2]>=teamStraight[3]-61 && shootY[2]+13.5>teamStrY && shootY[2]+13.5<teamStrY+61){
           flameX=teamStraight[3];
           flameY=teamStrY;
           currentFlame=0; 
           teamStraight[3]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamStraight[3] && shootCount[3]>=teamStraight[3]-61 && shootY[3]+13.5>teamStrY && shootY[3]+13.5<teamStrY+61){
           flameX=teamStraight[3];
           flameY=teamStrY;
           currentFlame=0; 
           teamStraight[3]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamStraight[3] && shootCount[4]>=teamStraight[3]-61 && shootY[4]+13.5>teamStrY && shootY[4]+13.5<teamStrY+61){
           flameX=teamStraight[3];
           flameY=teamStrY;
           currentFlame=0; 
           teamStraight[3]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }
//ship4        
        if(upDetect>=teamStraight[4] && upDetect<=teamStraight[4]+61 && fighterY>=teamStrY && fighterY<=teamStrY+61 || downDetect>=teamStraight[4] && downDetect<=teamStraight[4]+61 && fighterY+51>=teamStrY && fighterY+51<=teamStrY+61
      || leftDetect>=teamStrY && leftDetect<=teamStrY+61 && fighterX>=teamStraight[4] && fighterX<=teamStraight[4]+61){
           flameX=teamStraight[4];
           flameY=teamStrY;
           currentFlame=0; 
           teamStraight[4]=5000;
                
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
        }
        if(shootCount[0]<=teamStraight[4] && shootCount[0]>=teamStraight[4]-61 && shootY[0]+13.5>teamStrY && shootY[0]+13.5<teamStrY+61){             //bullet hit
           flameX=teamStraight[4];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[4]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamStraight[4] && shootCount[1]>=teamStraight[4]-61 && shootY[1]+13.5>teamStrY && shootY[1]+13.5<teamStrY+61){
           flameX=teamStraight[4];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[4]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamStraight[4] && shootCount[2]>=teamStraight[4]-61 && shootY[2]+13.5>teamStrY && shootY[2]+13.5<teamStrY+61){
           flameX=teamStraight[4];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[4]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamStraight[4] && shootCount[3]>=teamStraight[4]-61 && shootY[3]+13.5>teamStrY && shootY[3]+13.5<teamStrY+61){
           flameX=teamStraight[4];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[4]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamStraight[4] && shootCount[4]>=teamStraight[4]-61 && shootY[4]+13.5>teamStrY && shootY[4]+13.5<teamStrY+61){
           flameX=teamStraight[4];
           flameY=teamStrY;
           currentFlame=0;
           teamStraight[4]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }
//team straight reset   
        if(straightTrack>=1000){
          for(int count1=0;count1<5;count1++){                       
          teamStraight[count1]=-61-61*count1*13/10;         
        }
        teamStrY=floor(random(0,419));
        straightTrack=-61;
        ENEMYTEAM=slanted;          
        }
        break;
//-------------------------------------------------------------------------------------
        case slanted:
        
        image(enemy,teamSlanted[0],teamSlaY);
        image(enemy,teamSlanted[1],teamSlaY+teamSlaAngle);
        image(enemy,teamSlanted[2],teamSlaY+teamSlaAngle*2);
        image(enemy,teamSlanted[3],teamSlaY+teamSlaAngle*3);
        image(enemy,teamSlanted[4],teamSlaY+teamSlaAngle*4);
        
        teamSlanted[0]+=4;
        teamSlanted[1]+=4;
        teamSlanted[2]+=4;
        teamSlanted[3]+=4;
        teamSlanted[4]+=4;
        slantedTrack+=4;        
        
//ship0         
          if(upDetect>=teamSlanted[0] && upDetect<=teamSlanted[0]+61 && fighterY>=teamSlaY && fighterY<=teamSlaY+61 || downDetect>=teamSlanted[0] && downDetect<=teamSlanted[0]+61 && fighterY+51>=teamSlaY && fighterY+51<=teamSlaY+61
      || leftDetect>=teamSlaY && leftDetect<=teamSlaY+61 && fighterX>=teamSlanted[0] && fighterX<=teamSlanted[0]+61){
           flameX=teamSlanted[0];
           flameY=teamSlaY;
           currentFlame=0;
           teamSlanted[0]=5000;
                
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }          
        }
        
        if(shootCount[0]<=teamSlanted[0] && shootCount[0]>=teamSlanted[0]-61 && shootY[0]+13.5>teamSlaY && shootY[0]+13.5<teamSlaY+61){             //bullet hit
           flameX=teamSlanted[0];
           flameY=teamSlaY;
           currentFlame=0;
           teamSlanted[0]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamSlanted[0] && shootCount[1]>=teamSlanted[0]-61 && shootY[1]+13.5>teamSlaY && shootY[1]+13.5<teamSlaY+61){
           teamSlanted[0]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamSlanted[0] && shootCount[2]>=teamSlanted[0]-61 && shootY[2]+13.5>teamSlaY && shootY[2]+13.5<teamSlaY+61){
           flameX=teamSlanted[0];
           flameY=teamSlaY;
           currentFlame=0;
           teamSlanted[0]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamSlanted[0] && shootCount[3]>=teamSlanted[0]-61 && shootY[3]+13.5>teamSlaY && shootY[3]+13.5<teamSlaY+61){
           flameX=teamSlanted[0];
           flameY=teamSlaY;
           currentFlame=0;
           teamSlanted[0]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamSlanted[0] && shootCount[4]>=teamSlanted[0]-61 && shootY[4]+13.5>teamSlaY && shootY[4]+13.5<teamSlaY+61){
           flameX=teamSlanted[0];
           flameY=teamSlaY;
           currentFlame=0;
           teamSlanted[0]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }
//ship1        
        if(upDetect>=teamSlanted[1] && upDetect<=teamSlanted[1]+61 && fighterY>=teamSlaY+teamSlaAngle && fighterY<=teamSlaY+teamSlaAngle+61 || downDetect>=teamSlanted[1] && downDetect<=teamSlanted[1]+61 && fighterY+51>=teamSlaY+teamSlaAngle && fighterY+51<=teamSlaY+teamSlaAngle+61
      || leftDetect>=teamSlaY+teamSlaAngle && leftDetect<=teamSlaY+teamSlaAngle+61 && fighterX>=teamSlanted[1] && fighterX<=teamSlanted[1]+61){
           flameX=teamSlanted[1];
           flameY=teamSlaY+teamSlaAngle;
           currentFlame=0;
           teamSlanted[1]=5000;        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }          
        }        
        
        if(shootCount[0]<=teamSlanted[1] && shootCount[0]>=teamSlanted[1]-61 && shootY[0]+13.5>teamSlaY+teamSlaAngle && shootY[0]+13.5<teamSlaY+teamSlaAngle+61){             //bullet hit
           flameX=teamSlanted[1];
           flameY=teamSlaY+teamSlaAngle;
           currentFlame=0;
           teamSlanted[1]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamSlanted[1] && shootCount[1]>=teamSlanted[1]-61 && shootY[1]+13.5>teamSlaY+teamSlaAngle && shootY[1]+13.5<teamSlaY+teamSlaAngle+61){
           flameX=teamSlanted[1];
           flameY=teamSlaY+teamSlaAngle;
           currentFlame=0;
           teamSlanted[1]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamSlanted[1] && shootCount[2]>=teamSlanted[1]-61 && shootY[2]+13.5>teamSlaY+teamSlaAngle && shootY[2]+13.5<teamSlaY+teamSlaAngle+61){
           flameX=teamSlanted[1];
           flameY=teamSlaY+teamSlaAngle;
           currentFlame=0;
           teamSlanted[1]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamSlanted[1] && shootCount[3]>=teamSlanted[1]-61 && shootY[3]+13.5>teamSlaY+teamSlaAngle && shootY[3]+13.5<teamSlaY+teamSlaAngle+61){
           flameX=teamSlanted[1];
           flameY=teamSlaY+teamSlaAngle;
           currentFlame=0;
           teamSlanted[1]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamSlanted[1] && shootCount[4]>=teamSlanted[1]-61 && shootY[4]+13.5>teamSlaY+teamSlaAngle && shootY[4]+13.5<teamSlaY+teamSlaAngle+61){
           flameX=teamSlanted[1];
           flameY=teamSlaY+teamSlaAngle;
           currentFlame=0;
           teamSlanted[1]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }                
//ship2        
        if(upDetect>=teamSlanted[2] && upDetect<=teamSlanted[2]+61 && fighterY>=teamSlaY+teamSlaAngle*2 && fighterY<=teamSlaY+teamSlaAngle*2+61 || downDetect>=teamSlanted[2] && downDetect<=teamSlanted[2]+61 && fighterY+51>=teamSlaY+teamSlaAngle*2 && fighterY+51<=teamSlaY+teamSlaAngle*2+61
      || leftDetect>=teamSlaY+teamSlaAngle*2 && leftDetect<=teamSlaY+teamSlaAngle*2+61 && fighterX>=teamSlanted[2] && fighterX<=teamSlanted[2]+61){
           flameX=teamSlanted[2];
           flameY=teamSlaY+teamSlaAngle*2;
           currentFlame=0;
           teamSlanted[2]=5000;
                
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }          
        }
        
        if(shootCount[0]<=teamSlanted[2] && shootCount[0]>=teamSlanted[2]-61 && shootY[0]+13.5>teamSlaY+teamSlaAngle*2 && shootY[0]+13.5<teamSlaY+teamSlaAngle*2+61){             //bullet hit
           flameX=teamSlanted[2];
           flameY=teamSlaY+teamSlaAngle*2;
           currentFlame=0;
           teamSlanted[2]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamSlanted[2] && shootCount[1]>=teamSlanted[2]-61 && shootY[1]+13.5>teamSlaY+teamSlaAngle*2 && shootY[1]+13.5<teamSlaY+teamSlaAngle*2+61){
           flameX=teamSlanted[2];
           flameY=teamSlaY+teamSlaAngle*2;
           currentFlame=0;
           teamSlanted[2]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamSlanted[2] && shootCount[2]>=teamSlanted[2]-61 && shootY[2]+13.5>teamSlaY+teamSlaAngle*2 && shootY[2]+13.5<teamSlaY+teamSlaAngle*2+61){
           flameX=teamSlanted[2];
           flameY=teamSlaY+teamSlaAngle*2;
           currentFlame=0;
           teamSlanted[2]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamSlanted[2] && shootCount[3]>=teamSlanted[2]-61 && shootY[3]+13.5>teamSlaY+teamSlaAngle*2 && shootY[3]+13.5<teamSlaY+teamSlaAngle*2+61){
           flameX=teamSlanted[2];
           flameY=teamSlaY+teamSlaAngle*2;
           currentFlame=0;
           teamSlanted[2]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamSlanted[2] && shootCount[4]>=teamSlanted[2]-61 && shootY[4]+13.5>teamSlaY+teamSlaAngle*2 && shootY[4]+13.5<teamSlaY+teamSlaAngle*2+61){
           flameX=teamSlanted[2];
           flameY=teamSlaY+teamSlaAngle*2;
           currentFlame=0;
           teamSlanted[2]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }
//ship3        
        if(upDetect>=teamSlanted[3] && upDetect<=teamSlanted[3]+61 && fighterY>=teamSlaY && fighterY<=teamSlaY+61 || downDetect>=teamSlanted[3] && downDetect<=teamSlanted[3]+61 && fighterY+51>=teamSlaY+teamSlaAngle*3 && fighterY+51<=teamSlaY+teamSlaAngle*3+61
      || leftDetect>=teamSlaY+teamSlaAngle*3 && leftDetect<=teamSlaY+teamSlaAngle*3+61 && fighterX>=teamSlanted[3] && fighterX<=teamSlanted[3]+61){
           flameX=teamSlanted[3];
           flameY=teamSlaY+teamSlaAngle*3;
           currentFlame=0;
           teamSlanted[3]=5000;
               
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }          
        }        
        if(shootCount[0]<=teamSlanted[3] && shootCount[0]>=teamSlanted[3]-61 && shootY[0]+13.5>teamSlaY+teamSlaAngle*3 && shootY[0]+13.5<teamSlaY+teamSlaAngle*3+61){             //bullet hit
           flameX=teamSlanted[3];
           flameY=teamSlaY+teamSlaAngle*3;
           currentFlame=0;
           teamSlanted[3]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamSlanted[3] && shootCount[1]>=teamSlanted[3]-61 && shootY[1]+13.5>teamSlaY+teamSlaAngle*3 && shootY[1]+13.5<teamSlaY+teamSlaAngle*3+61){
           flameX=teamSlanted[3];
           flameY=teamSlaY+teamSlaAngle*3;
           currentFlame=0;
           teamSlanted[3]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamSlanted[3] && shootCount[2]>=teamSlanted[3]-61 && shootY[2]+13.5>teamSlaY+teamSlaAngle*3 && shootY[2]+13.5<teamSlaY+teamSlaAngle*3+61){
           flameX=teamSlanted[3];
           flameY=teamSlaY+teamSlaAngle*3;
           currentFlame=0;
           teamSlanted[3]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamSlanted[3] && shootCount[3]>=teamSlanted[3]-61 && shootY[3]+13.5>teamSlaY+teamSlaAngle*3 && shootY[3]+13.5<teamSlaY+teamSlaAngle*3+61){
           flameX=teamSlanted[3];
           flameY=teamSlaY+teamSlaAngle*3;
           currentFlame=0;
           teamSlanted[3]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamSlanted[3] && shootCount[4]>=teamSlanted[3]-61 && shootY[4]+13.5>teamSlaY+teamSlaAngle*3 && shootY[4]+13.5<teamSlaY+teamSlaAngle*3+61){
           flameX=teamSlanted[3];
           flameY=teamSlaY+teamSlaAngle*3;
           currentFlame=0;
           teamSlanted[3]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }
//ship4        
        if(upDetect>=teamSlanted[4] && upDetect<=teamSlanted[4]+61 && fighterY>=teamSlaY+teamSlaAngle*4 && fighterY<=teamSlaY+teamSlaAngle*4+61 || downDetect>=teamSlanted[4] && downDetect<=teamSlanted[4]+61 && fighterY+51>=teamSlaY+teamSlaAngle*4 && fighterY+51<=teamSlaY+teamSlaAngle*4+61
      || leftDetect>=teamSlaY+teamSlaAngle*4 && leftDetect<=teamSlaY+teamSlaAngle*4+61 && fighterX>=teamSlanted[4] && fighterX<=teamSlanted[4]+61){
           flameX=teamSlanted[4];
           flameY=teamSlaY+teamSlaAngle*4;
           currentFlame=0;
           teamSlanted[4]=5000;
                
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }          
        }
      
         if(shootCount[0]<=teamSlanted[4] && shootCount[0]>=teamSlanted[4]-61 && shootY[0]+13.5>teamSlaY+teamSlaAngle*4 && shootY[0]+13.5<teamSlaY+teamSlaAngle*4+61){             //bullet hit
           flameX=teamSlanted[4];
           flameY=teamSlaY+teamSlaAngle*4;
           currentFlame=0;
           teamSlanted[4]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamSlanted[4] && shootCount[1]>=teamSlanted[4]-61 && shootY[1]+13.5>teamSlaY+teamSlaAngle*4 && shootY[1]+13.5<teamSlaY+teamSlaAngle*4+61){
           flameX=teamSlanted[4];
           flameY=teamSlaY+teamSlaAngle*4;
           currentFlame=0;
           teamSlanted[4]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamSlanted[4] && shootCount[2]>=teamSlanted[4]-61 && shootY[2]+13.5>teamSlaY+teamSlaAngle*4 && shootY[2]+13.5<teamSlaY+teamSlaAngle*4+61){
           flameX=teamSlanted[4];
           flameY=teamSlaY+teamSlaAngle*4;
           currentFlame=0;
           teamSlanted[4]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamSlanted[4] && shootCount[3]>=teamSlanted[4]-61 && shootY[3]+13.5>teamSlaY+teamSlaAngle*4 && shootY[3]+13.5<teamSlaY+teamSlaAngle*4+61){
           flameX=teamSlanted[4];
           flameY=teamSlaY+teamSlaAngle*4;
           currentFlame=0;
           teamSlanted[4]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamSlanted[4] && shootCount[4]>=teamSlanted[4]-61 && shootY[4]+13.5>teamSlaY+teamSlaAngle*4 && shootY[4]+13.5<teamSlaY+teamSlaAngle*4+61){
           flameX=teamSlanted[4];
           flameY=teamSlaY+teamSlaAngle*4;
           currentFlame=0;
           teamSlanted[4]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }   
//team slanted reset       
        if(slantedTrack>=1000){
          for(int count2=0;count2<5;count2++){                       
          teamSlanted[count2]=-61-61*count2*13/10;         
        }
        teamSlaY=floor(random(20,399));
        teamSlaAngle=random(teamSlaY/(-5),(480-teamSlaY-61)/5);
        slantedTrack=-61;
        ENEMYTEAM=diamond;
        }
        break;

       
        case diamond:
        
        image(enemy,teamDiamond[0],teamDiaY);
        image(enemy,teamDiamond[1],teamDiaY+teamDiaAngle);
        image(enemy,teamDiamond[2],teamDiaY+teamDiaAngle*2);
        image(enemy,teamDiamond[3],teamDiaY+teamDiaAngle);
        image(enemy,teamDiamond[4],teamDiaY);
        image(enemy,teamDiamond[5],teamDiaY-teamDiaAngle);
        image(enemy,teamDiamond[6],teamDiaY-teamDiaAngle*2);
        image(enemy,teamDiamond[7],teamDiaY-teamDiaAngle);
        
        teamDiamond[0]+=4;
        teamDiamond[1]+=4;
        teamDiamond[2]+=4;
        teamDiamond[3]+=4;
        teamDiamond[4]+=4;
        teamDiamond[5]+=4;
        teamDiamond[6]+=4;
        teamDiamond[7]+=4;
        diamondTrack+=4;
        
//ship 0        
        if(upDetect>=teamDiamond[0] && upDetect<=teamDiamond[0]+61 && fighterY>=teamDiaY && fighterY<=teamDiaY+61 || downDetect>=teamDiamond[0] && downDetect<=teamDiamond[0]+61 && fighterY+51>=teamDiaY && fighterY+51<=teamDiaY+61
      || leftDetect>=teamDiaY && leftDetect<=teamDiaY+61 && fighterX>=teamStraight[0] && fighterX<=teamStraight[0]+61){        
           flameX=teamDiamond[0];
           flameY=teamDiaY;
           currentFlame=0;
           teamDiamond[0]=5000;
              
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }          
        }         
         if(shootCount[0]<=teamDiamond[0] && shootCount[0]>=teamDiamond[0]-61 && shootY[0]+13.5>teamDiaY && shootY[0]+13.5<teamDiaY+61){             //bullet hit
           flameX=teamDiamond[0];
           flameY=teamDiaY;
           currentFlame=0;
           teamDiamond[0]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamDiamond[0] && shootCount[1]>=teamDiamond[0]-61 && shootY[1]+13.5>teamDiaY && shootY[1]+13.5<teamDiaY+61){
           flameX=teamDiamond[0];
           flameY=teamDiaY;
           currentFlame=0;
           teamDiamond[0]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamDiamond[0] && shootCount[2]>=teamDiamond[0]-61 && shootY[2]+13.5>teamDiaY && shootY[2]+13.5<teamDiaY+61){
           flameX=teamDiamond[0];
           flameY=teamDiaY;
           currentFlame=0;
           teamDiamond[0]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamDiamond[0] && shootCount[3]>=teamDiamond[0]-61 && shootY[3]+13.5>teamDiaY && shootY[3]+13.5<teamDiaY+61){
           flameX=teamDiamond[0];
           flameY=teamDiaY;
           currentFlame=0;
           teamDiamond[0]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamDiamond[0] && shootCount[4]>=teamDiamond[0]-61 && shootY[4]+13.5>teamDiaY && shootY[4]+13.5<teamDiaY+61){
           flameX=teamDiamond[0];
           flameY=teamDiaY;
           currentFlame=0;
           teamDiamond[0]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }
//ship1      
        if(upDetect>=teamDiamond[1] && upDetect<=teamDiamond[1]+61 && fighterY>=teamDiaY+teamDiaAngle && fighterY<=teamDiaY+teamDiaAngle+61 || downDetect>=teamDiamond[1] && downDetect<=teamDiamond[1]+61 && fighterY+51>=teamDiaY+teamDiaAngle && fighterY+51<=teamDiaY+teamDiaAngle+61
      || leftDetect>=teamDiaY+teamDiaAngle && leftDetect<=teamDiaY+teamDiaAngle+61 && fighterX>=teamDiamond[1] && fighterX<=teamDiamond[1]+61){
           flameX=teamDiamond[0];
           flameY=teamDiaY+teamDiaAngle;
           currentFlame=0;
           teamDiamond[1]=5000;        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }          
        }
         if(shootCount[0]<=teamDiamond[1] && shootCount[0]>=teamDiamond[1]-61 && shootY[0]+13.5>teamDiaY+teamDiaAngle && shootY[0]+13.5<teamDiaY+teamDiaAngle+61){             //bullet hit
           flameX=teamDiamond[1];
           flameY=teamDiaY+teamDiaAngle;
           currentFlame=0;
           teamDiamond[1]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamDiamond[1] && shootCount[1]>=teamDiamond[1]-61 && shootY[1]+13.5>teamDiaY+teamDiaAngle && shootY[1]+13.5<teamDiaY+teamDiaAngle+61){
           flameX=teamDiamond[1];
           flameY=teamDiaY+teamDiaAngle;
           currentFlame=0;
           teamDiamond[1]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamDiamond[1] && shootCount[2]>=teamDiamond[1]-61 && shootY[2]+13.5>teamDiaY+teamDiaAngle && shootY[2]+13.5<teamDiaY+teamDiaAngle+61){
           flameX=teamDiamond[1];
           flameY=teamDiaY+teamDiaAngle;
           currentFlame=0;
           teamDiamond[1]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamDiamond[1] && shootCount[3]>=teamDiamond[1]-61 && shootY[3]+13.5>teamDiaY+teamDiaAngle && shootY[3]+13.5<teamDiaY+teamDiaAngle+61){
           flameX=teamDiamond[1];
           flameY=teamDiaY+teamDiaAngle;
           currentFlame=0;
           teamDiamond[1]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamDiamond[1] && shootCount[4]>=teamDiamond[1]-61 && shootY[4]+13.5>teamDiaY+teamDiaAngle && shootY[4]+13.5<teamDiaY+teamDiaAngle+61){
           flameX=teamDiamond[1];
           flameY=teamDiaY+teamDiaAngle;
           currentFlame=0;
           teamDiamond[1]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }

//ship2      
        if(upDetect>=teamDiamond[2] && upDetect<=teamDiamond[2]+61 && fighterY>=teamDiaY+teamDiaAngle*2 && fighterY<=teamDiaY+teamDiaAngle*2+61 || downDetect>=teamDiamond[2] && downDetect<=teamDiamond[2]+61 && fighterY+51>=teamDiaY+teamDiaAngle*2 && fighterY+51<=teamDiaY+teamDiaAngle*2+61
      || leftDetect>=teamDiaY+teamDiaAngle*2 && leftDetect<=teamDiaY+teamDiaAngle*2+61 && fighterX>=teamDiamond[2] && fighterX<=teamDiamond[2]+61){
           flameX=teamDiamond[2];
           flameY=teamDiaY+teamDiaAngle*2;
           currentFlame=0;
           teamDiamond[2]=5000;        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }          
        }
        if(shootCount[0]<=teamDiamond[3] && shootCount[0]>=teamDiamond[2]-61 && shootY[0]+13.5>teamDiaY+teamDiaAngle*2 && shootY[0]+13.5<teamDiaY+teamDiaAngle*2+61){             //bullet hit
           flameX=teamDiamond[2];
           flameY=teamDiaY+teamDiaAngle*2;
           currentFlame=0;
           teamDiamond[2]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamDiamond[2] && shootCount[1]>=teamDiamond[2]-61 && shootY[1]+13.5>teamDiaY+teamDiaAngle*2 && shootY[1]+13.5<teamDiaY+teamDiaAngle*2+61){
           flameX=teamDiamond[2];
           flameY=teamDiaY+teamDiaAngle*2;
           currentFlame=0;
           teamDiamond[2]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamDiamond[2] && shootCount[2]>=teamDiamond[2]-61 && shootY[2]+13.5>teamDiaY+teamDiaAngle*2 && shootY[2]+13.5<teamDiaY+teamDiaAngle*2+61){
           flameX=teamDiamond[2];
           flameY=teamDiaY+teamDiaAngle*2;
           currentFlame=0;
           teamDiamond[2]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamDiamond[2] && shootCount[3]>=teamDiamond[2]-61 && shootY[3]+13.5>teamDiaY+teamDiaAngle*2 && shootY[3]+13.5<teamDiaY+teamDiaAngle*2+61){
           flameX=teamDiamond[2];
           flameY=teamDiaY+teamDiaAngle*2;
           currentFlame=0;
           teamDiamond[2]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamDiamond[2] && shootCount[4]>=teamDiamond[2]-61 && shootY[4]+13.5>teamDiaY+teamDiaAngle*2 && shootY[4]+13.5<teamDiaY+teamDiaAngle*2+61){
           flameX=teamDiamond[2];
           flameY=teamDiaY+teamDiaAngle*2;
           currentFlame=0;
           teamDiamond[2]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }
//ship3        
        if(upDetect>=teamDiamond[3] && upDetect<=teamDiamond[3]+61 && fighterY>=teamDiaY+teamDiaAngle && fighterY<=teamDiaY+teamDiaAngle+61 || downDetect>=teamDiamond[3] && downDetect<=teamDiamond[3]+61 && fighterY+51>=teamDiaY+teamDiaAngle && fighterY+51<=teamDiaY+teamDiaAngle+61
      || leftDetect>=teamDiaY+teamDiaAngle && leftDetect<=teamDiaY+teamDiaAngle+61 && fighterX>=teamDiamond[3] && fighterX<=teamDiamond[3]+61){
           flameX=teamDiamond[3];
           flameY=teamDiaY+teamDiaAngle;
           currentFlame=0;
           teamDiamond[3]=5000;
                
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }          
        }        
        if(shootCount[0]<=teamDiamond[3] && shootCount[0]>=teamDiamond[3]-61 && shootY[0]+13.5>teamDiaY+teamDiaAngle && shootY[0]+13.5<teamDiaY+teamDiaAngle+61){             //bullet hit
           flameX=teamDiamond[3];
           flameY=teamDiaY+teamDiaAngle;
           currentFlame=0;
           teamDiamond[3]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamDiamond[3] && shootCount[1]>=teamDiamond[3]-61 && shootY[1]+13.5>teamDiaY+teamDiaAngle && shootY[1]+13.5<teamDiaY+teamDiaAngle+61){
           flameX=teamDiamond[3];
           flameY=teamDiaY+teamDiaAngle;
           currentFlame=0;
           teamDiamond[3]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamDiamond[3] && shootCount[2]>=teamDiamond[3]-61 && shootY[2]+13.5>teamDiaY+teamDiaAngle && shootY[2]+13.5<teamDiaY+teamDiaAngle+61){
           flameX=teamDiamond[3];
           flameY=teamDiaY+teamDiaAngle;
           currentFlame=0;
           teamDiamond[3]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamDiamond[3] && shootCount[3]>=teamDiamond[3]-61 && shootY[3]+13.5>teamDiaY+teamDiaAngle && shootY[3]+13.5<teamDiaY+teamDiaAngle+61){
           flameX=teamDiamond[3];
           flameY=teamDiaY+teamDiaAngle;
           currentFlame=0;
           teamDiamond[3]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamDiamond[3] && shootCount[4]>=teamDiamond[3]-61 && shootY[4]+13.5>teamDiaY+teamDiaAngle && shootY[4]+13.5<teamDiaY+teamDiaAngle+61){
           flameX=teamDiamond[3];
           flameY=teamDiaY+teamDiaAngle;
           currentFlame=0;
           teamDiamond[3]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }
//ship4        
        if(upDetect>=teamDiamond[4] && upDetect<=teamDiamond[4]+61 && fighterY>=teamDiaY && fighterY<=teamDiaY+61 || downDetect>=teamDiamond[4] && downDetect<=teamDiamond[4]+61 && fighterY+51>=teamDiaY && fighterY+51<=teamDiaY+61
      || leftDetect>=teamDiaY && leftDetect<=teamDiaY+61 && fighterX>=teamDiamond[4] && fighterX<=teamDiamond[4]+61){
           flameX=teamDiamond[4];
           flameY=teamDiaY;
           currentFlame=0;
           teamDiamond[4]=5000;
                
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }          
        }
        if(shootCount[0]<=teamDiamond[4] && shootCount[0]>=teamDiamond[4]-61 && shootY[0]+13.5>teamDiaY && shootY[0]+13.5<teamDiaY+61){             //bullet hit
           flameX=teamDiamond[4];
           flameY=teamDiaY;
           currentFlame=0;
           teamDiamond[4]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamDiamond[4] && shootCount[1]>=teamDiamond[4]-61 && shootY[1]+13.5>teamDiaY && shootY[1]+13.5<teamDiaY+61){
           flameX=teamDiamond[4];
           flameY=teamDiaY;
           currentFlame=0;
           teamDiamond[4]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamDiamond[4] && shootCount[2]>=teamDiamond[4]-61 && shootY[2]+13.5>teamDiaY && shootY[2]+13.5<teamDiaY+61){
           flameX=teamDiamond[4];
           flameY=teamDiaY;
           currentFlame=0;
           teamDiamond[4]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamDiamond[4] && shootCount[3]>=teamDiamond[4]-61 && shootY[3]+13.5>teamDiaY && shootY[3]+13.5<teamDiaY+61){
           flameX=teamDiamond[4];
           flameY=teamDiaY;
           currentFlame=0;
           teamDiamond[4]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamDiamond[4] && shootCount[4]>=teamDiamond[4]-61 && shootY[4]+13.5>teamDiaY && shootY[4]+13.5<teamDiaY+61){
           flameX=teamDiamond[4];
           flameY=teamDiaY;
           currentFlame=0;
           teamDiamond[4]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }
//ship5        
        if(upDetect>=teamDiamond[5] && upDetect<=teamDiamond[5]+61 && fighterY>=teamDiaY-teamDiaAngle && fighterY<=teamDiaY-teamDiaAngle+61 || downDetect>=teamDiamond[5] && downDetect<=teamDiamond[5]+61 && fighterY+51>=teamDiaY-teamDiaAngle && fighterY+51<=teamDiaY-teamDiaAngle+61
      || leftDetect>=teamDiaY-teamDiaAngle && leftDetect<=teamDiaY-teamDiaAngle+61 && fighterX>=teamDiamond[5] && fighterX<=teamDiamond[5]+61){
           flameX=teamDiamond[5];
           flameY=teamDiaY-teamDiaAngle;
           currentFlame=0;
           teamDiamond[5]=5000;        
        
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }          
        }
        if(shootCount[0]<=teamDiamond[5] && shootCount[0]>=teamDiamond[5]-61 && shootY[0]+13.5>teamDiaY-teamDiaAngle && shootY[0]+13.5<teamDiaY-teamDiaAngle+61){             //bullet hit
           flameX=teamDiamond[5];
           flameY=teamDiaY-teamDiaAngle;
           currentFlame=0;
           teamDiamond[5]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamDiamond[5] && shootCount[1]>=teamDiamond[5]-61 && shootY[1]+13.5>teamDiaY-teamDiaAngle && shootY[1]+13.5<teamDiaY-teamDiaAngle+61){
           flameX=teamDiamond[5];
           flameY=teamDiaY-teamDiaAngle;
           currentFlame=0;
           teamDiamond[5]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamDiamond[5] && shootCount[2]>=teamDiamond[5]-61 && shootY[2]+13.5>teamDiaY-teamDiaAngle && shootY[2]+13.5<teamDiaY-teamDiaAngle+61){
           flameX=teamDiamond[5];
           flameY=teamDiaY-teamDiaAngle;
           currentFlame=0;
           teamDiamond[5]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamDiamond[5] && shootCount[3]>=teamDiamond[5]-61 && shootY[3]+13.5>teamDiaY-teamDiaAngle && shootY[3]+13.5<teamDiaY-teamDiaAngle+61){
           flameX=teamDiamond[5];
           flameY=teamDiaY-teamDiaAngle;
           currentFlame=0;
           teamDiamond[5]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
         }
         if(shootCount[4]<=teamDiamond[5] && shootCount[4]>=teamDiamond[5]-61 && shootY[4]+13.5>teamDiaY-teamDiaAngle && shootY[4]+13.5<teamDiaY-teamDiaAngle+61){
           flameX=teamDiamond[5];
           flameY=teamDiaY-teamDiaAngle;
           currentFlame=0;
           teamDiamond[5]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }
//ship6        
        if(upDetect>=teamDiamond[6] && upDetect<=teamDiamond[6]+61 && fighterY>=teamDiaY-teamDiaAngle*2 && fighterY<=teamDiaY-teamDiaAngle*2+61 || downDetect>=teamDiamond[6] && downDetect<=teamDiamond[6]+61 && fighterY+51>=teamDiaY-teamDiaAngle*2 && fighterY+51<=teamDiaY-teamDiaAngle*2+61
      || leftDetect>=teamDiaY-teamDiaAngle*2 && leftDetect<=teamDiaY-teamDiaAngle*2+61 && fighterX>=teamDiamond[6] && fighterX<=teamDiamond[6]+61){
           flameX=teamDiamond[6];
           flameY=teamDiaY-teamDiaAngle*2;
           currentFlame=0;
           teamDiamond[6]=5000;
                
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }       
        }
        if(shootCount[0]<=teamDiamond[6] && shootCount[0]>=teamDiamond[6]-61 && shootY[0]+13.5>teamDiaY-teamDiaAngle*2 && shootY[0]+13.5<teamDiaY-teamDiaAngle*2+61){             //bullet hit
           flameX=teamDiamond[6];
           flameY=teamDiaY-teamDiaAngle*2;
           currentFlame=0;
           teamDiamond[6]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamDiamond[6] && shootCount[1]>=teamDiamond[6]-61 && shootY[1]+13.5>teamDiaY-teamDiaAngle*2 && shootY[1]+13.5<teamDiaY-teamDiaAngle*2+61){
           flameX=teamDiamond[6];
           flameY=teamDiaY-teamDiaAngle*2;
           currentFlame=0;
           teamDiamond[6]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamDiamond[6] && shootCount[2]>=teamDiamond[6]-61 && shootY[2]+13.5>teamDiaY-teamDiaAngle*2 && shootY[2]+13.5<teamDiaY-teamDiaAngle*2+61){
           flameX=teamDiamond[6];
           flameY=teamDiaY-teamDiaAngle*2;
           currentFlame=0;
           teamDiamond[6]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamDiamond[6] && shootCount[3]>=teamDiamond[6]-61 && shootY[3]+13.5>teamDiaY-teamDiaAngle*2 && shootY[3]+13.5<teamDiaY-teamDiaAngle*2+61){
           flameX=teamDiamond[6];
           flameY=teamDiaY-teamDiaAngle*2;
           currentFlame=0;
           teamDiamond[6]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamDiamond[6] && shootCount[4]>=teamDiamond[6]-61 && shootY[4]+13.5>teamDiaY-teamDiaAngle*2 && shootY[4]+13.5<teamDiaY-teamDiaAngle*2+61){
           flameX=teamDiamond[6];
           flameY=teamDiaY-teamDiaAngle*2;
           currentFlame=0;
           teamDiamond[6]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }
//ship7        
        if(upDetect>=teamDiamond[7] && upDetect<=teamDiamond[7]+61 && fighterY>=teamDiaY-teamDiaAngle && fighterY<=teamDiaY-teamDiaAngle+61 || downDetect>=teamDiamond[7] && downDetect<=teamDiamond[7]+61 && fighterY+51>=teamDiaY-teamDiaAngle && fighterY+51<=teamDiaY-teamDiaAngle+61
      || leftDetect>=teamDiaY-teamDiaAngle && leftDetect<=teamDiaY-teamDiaAngle+61 && fighterX>=teamDiamond[7] && fighterX<=teamDiamond[7]+61){
           flameX=teamDiamond[7];
           flameY=teamDiaY-teamDiaAngle;
           currentFlame=0;
           teamDiamond[7]=5000;
                
        if(health>450){
          health-=40;
        }else{          
            GAMEMODE=gameover;
          }
          
        }
        if(shootCount[0]<=teamDiamond[7] && shootCount[0]>=teamDiamond[7]-61 && shootY[0]+13.5>teamDiaY-teamDiaAngle && shootY[0]+13.5<teamDiaY-teamDiaAngle+61){             //bullet hit
           flameX=teamDiamond[7];
           flameY=teamDiaY-teamDiaAngle;
           currentFlame=0;
           teamDiamond[7]=5000;
           shootCount[0]=1000000;
           shootAllow[0]=true;
           scoreChange();
         }
         if(shootCount[1]<=teamDiamond[7] && shootCount[1]>=teamDiamond[7]-61 && shootY[1]+13.5>teamDiaY-teamDiaAngle && shootY[1]+13.5<teamDiaY-teamDiaAngle+61){
           flameX=teamDiamond[7];
           flameY=teamDiaY-teamDiaAngle;
           currentFlame=0;
           teamDiamond[7]=5000;
           shootCount[1]=1000000;
           shootAllow[1]=true;
           scoreChange();
         }
         if(shootCount[2]<=teamDiamond[7] && shootCount[2]>=teamDiamond[7]-61 && shootY[2]+13.5>teamDiaY-teamDiaAngle && shootY[2]+13.5<teamDiaY-teamDiaAngle+61){
           flameX=teamDiamond[7];
           flameY=teamDiaY-teamDiaAngle;
           currentFlame=0;
           teamDiamond[7]=5000;
           shootCount[2]=1000000;
           shootAllow[2]=true;
           scoreChange();
         }
         if(shootCount[3]<=teamDiamond[7] && shootCount[3]>=teamDiamond[7]-61 && shootY[3]+13.5>teamDiaY-teamDiaAngle && shootY[3]+13.5<teamDiaY-teamDiaAngle+61){
           flameX=teamDiamond[7];
           flameY=teamDiaY-teamDiaAngle;
           currentFlame=0;
           teamDiamond[7]=5000;
           shootCount[3]=1000000;
           shootAllow[3]=true;
           scoreChange();
         }
         if(shootCount[4]<=teamDiamond[7] && shootCount[4]>=teamDiamond[7]-61 && shootY[4]+13.5>teamDiaY-teamDiaAngle && shootY[4]+13.5<teamDiaY-teamDiaAngle+61){
           flameX=teamDiamond[7];
           flameY=teamDiaY-teamDiaAngle;
           currentFlame=0;
           teamDiamond[7]=5000;
           shootCount[4]=1000000;
           shootAllow[4]=true;
           scoreChange();
         }
        
//team diamond reset        
        if(diamondTrack>=1000){                                
          for(int count3=0;count3<5;count3++){                       
            teamDiamond[count3]=-61-61*count3*13/10;         
          } 
          for(int count4=5;count4<8;count4++){
            teamDiamond[count4]=-61-61*(8-count4)*13/10;    
          }
          teamDiaY=floor(random(40,379));
          
          if(teamDiaY<=209.5){                               //area detection
            teamDiaAngle=random(teamDiaY/3,0);  
            }else{
            teamDiaAngle=random((419-teamDiaY)/3,0);
            }
        diamondTrack=-61;  
        ENEMYTEAM=straight;
        }     
//teams end
        break; 
   }          
//playing end                    
     break;


          
     case gameover:
       image(end2,0,0);
  if ((mouseX<width*2/3 && mouseX>width*1/3)&&(mouseY<355 && mouseY>308)){
    image(end1,0,0);
  if(mousePressed){                            
    health=450;                         //restart
    fighterX=540;
    fighterY=240;
    value=0;
    
//resetting all enemies   
    for(int count1=0;count1<5;count1++){                //team straight reset
          teamStraight[count1]=-61-61*count1*13/10;         
        }
        teamStrY=floor(random(0,419));
    straightTrack=teamStraight[0];
    for(int count2=0;count2<5;count2++){               //team slanted reset
          teamSlanted[count2]=-61-61*count2*13/10;         
        }
        teamSlaY=floor(random(0,419));
        teamSlaAngle=random(teamSlaY/(-5),(480-teamSlaY-61)/5);
    slantedTrack=teamSlanted[0]; 
    for(int count3=0;count3<5;count3++){               //team diamond reset   
            teamDiamond[count3]=-61-61*count3*13/10;         
          } 
    for(int count4=5;count4<8;count4++){
            teamDiamond[count4]=-61-61*(8-count4)*13/10;    
          }
          teamDiaY=floor(random(0,419));          
    if(teamDiaY<=209.5){                               //area detection
      teamDiaAngle=random(teamDiaY/3,0);  
      }else{
      teamDiaAngle=random((419-teamDiaY)/3,0);
      }
    diamondTrack=teamDiamond[0];  

    for(int i=0;i<5;i++){                               //reset shoot
          shootCount[i]=1000000;
       }
    for(int i=0;i<5;i++){
          shootY[i]=fighterY;
       }   
    for(int i=0;i<5;i++){
          shootAllow[i]=true;
       }
    flameX=10000;                                //flame reset
    flameY=10000;   
    ENEMYTEAM=straight;
    GAMEMODE=playing;    
           } 
         }
    break;
  }
}                               
  
  
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






























/*
int enemyCount = 8;

int[] enemyX = new int[enemyCount];
int[] enemyY = new int[enemyCount];

void setup () {
	size(640, 480) ;
	enemy = loadImage("img/enemy.png");
	addEnemy(0);
}

void draw()
{
	background(0);
	for (int i = 0; i < enemyCount; ++i) {
		if (enemyX[i] != -1 || enemyY[i] != -1) {
			image(enemy, enemyX[i], enemyY[i]);
			enemyX[i]+=5;
		}
	}
}

// 0 - straight, 1-slope, 2-dimond
void addEnemy(int type)
{	
	for (int i = 0; i < enemyCount; ++i) {
		enemyX[i] = -1;
		enemyY[i] = -1;
	}
	switch (type) {
		case 0:
			addStraightEnemy();
			break;
		case 1:
			addSlopeEnemy();
			break;
		case 2:
			addDiamondEnemy();
			break;
	}
}

void addStraightEnemy()
{
	float t = random(height - enemy.height);
	int h = int(t);
	for (int i = 0; i < 5; ++i) {

		enemyX[i] = (i+1)*-80;
		enemyY[i] = h;
	}
}
void addSlopeEnemy()
{
	float t = random(height - enemy.height * 5);
	int h = int(t);
	for (int i = 0; i < 5; ++i) {

		enemyX[i] = (i+1)*-80;
		enemyY[i] = h + i * 40;
	}
}
void addDiamondEnemy()
{
	float t = random( enemy.height * 3 ,height - enemy.height * 3);
	int h = int(t);
	int x_axis = 1;
	for (int i = 0; i < 8; ++i) {
		if (i == 0 || i == 7) {
			enemyX[i] = x_axis*-80;
			enemyY[i] = h;
			x_axis++;
		}
		else if (i == 1 || i == 5){
			enemyX[i] = x_axis*-80;
			enemyY[i] = h + 1 * 40;
			enemyX[i+1] = x_axis*-80;
			enemyY[i+1] = h - 1 * 40;
			i++;
			x_axis++;
			
		}
		else {
			enemyX[i] = x_axis*-80;
			enemyY[i] = h + 2 * 40;
			enemyX[i+1] = x_axis*-80;
			enemyY[i+1] = h - 2 * 40;
			i++;
			x_axis++;
		}
	}
}

*/
