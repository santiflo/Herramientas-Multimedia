int sx1;
int sy1;
int px1;
int py1;
int sx2;
int sy2;
int px2;
int py2;
int g1;
int g2;
int vx1;
int vy1;
int vx2;
int vy2;

void setup(){
  size(800,600);
  px1 = int(random(0,width));
  py1 = int(random(0,height));
  px2 = int(random(0,width));
  py2 = int(random(0,height));
  sx1 = 50;
  sy1 = 50;
  sx2 = 50;
  sy2 = 50;
  vx1 = int(random(1,5));
  vy1 = int(random(1,5));
  vx2 = int(random(1,5));
  vy2 = int(random(1,5));
  g1 = 10;
  g2 = 10;
}

void draw(){
  background(55,50,250);
  
  fill(#ffff00);
  noStroke();
  ellipse(px1,py1,sx1,sy1);
  px1 = px1+vx1;
  py1 = py1+vy1;
  if(px1>width || px1<0){
    vx1 = vx1*(-1);
  }
  if(py1>height || py1<0){
    vy1 = vy1*(-1);
  }
  
  sx1 = sx1+g1;
  sy1 = sy1+g1;
  if(sx1>100 || sx1<50){
    g1 = g1*(-1);    
  }
  
  fill(#00ffff);
  noStroke();
  ellipse(px2,py2,sx2,sy2);
  px2 = px2+vx2;
  py2 = py2+vy2;
  if(px2>width || px2<0){
    vx2 = vx2*(-1);
  }
  if(py2>height || py2<0){
    vy2 = vy2*(-1);
  }
  
  sx2 = sx2+g2;
  sy2 = sy2+g2;
  if(sx2>100 || sx2<50){
    g2 = g2*(-1);    
  }
  
  //dibujar linea
  if(dist(px1,py1,px2,py2)<=200){
    stroke(204, 102, 0);
    line(px1,py1,px2,py2);
  }
}
