/*
Nombre: Henry Lema
Asignatura: S. Embebidos
*/

import ddf.minim.*;
Minim minim;
AudioPlayer player;
PImage img,img2;
float bolaY = 0;
float caida = .2;
float velocidad = 0;
float topValue = random(50,300);
float bottomValue = topValue+150;
float obstacleX = 500;
boolean alive = true;
int score = 0;

void setup(){
  
  size(500,500);
  
  minim =new Minim (this);
  player=minim.loadFile("audio.mp3");
   player.play();
  img =loadImage("bosque.jpg");
  img2 =loadImage("bosque2.jpg");
  refresh();
  obstacle();
  bolaY = 0;
  caida = .2;
  velocidad = 0;
  topValue = random(50,300);
  bottomValue = topValue+150;
  obstacleX = 500;
  alive = true;
  score = 0;

 
}

void refresh(){
   
  if(bolaY > 450){
    alive = false;
  }
  if (alive==true){
    velocidad = velocidad + caida;
    bolaY = bolaY+velocidad;
    //background(255,100,255);
    fill(255,100,0);
    ellipse(150,bolaY,50,50);
    fill(0,150,0);
    rect(0,480,500,20);
    fill(0);
    rect(obstacleX,0,75,topValue);
    rect(obstacleX,bottomValue,75,500);
    obstacleX = obstacleX-2;
  }
}

void jump(){
  if (keyPressed == true){
    if(velocidad > 2  ){
      velocidad = -6;
    }
  }
}  

void obstacle(){
  if(obstacleX+75<0){
    topValue = random(50,300);
    bottomValue = topValue+150;
    obstacleX = 500;
  }
}

void colision(){
  if ((obstacleX+75>125)&&(obstacleX<175)){  
    if((bolaY+25>bottomValue)||(bolaY-25<topValue)){
      alive=false;
    }
  }
}

void reiniciar(){
  image(img2,0,0);
  textSize(50);
  fill(255,255,0);
  text("Perdiste",130,200);
  fill(255,255,0);
  rect(130,250,200,100);
  fill(255,0,0);
  text("Repita",150,320);
  player.pause();
}

void mouseClicked(){
  
  if (alive==false){
    if((mouseY>250)&(mouseY<350)&(mouseX>130)&(mouseX<330)){
      setup();
    }
  }
}

void puntos(){
  if(obstacleX == 60){
    score++;
  }
  fill(0,0,0);
  textSize(30);
  text(score,450,50);
}

void draw(){
  
  image(img,0,-500);
  if (alive){
    refresh();
    jump();
    obstacle();
    colision();
  }else{
   reiniciar();
  }
  puntos();
}
