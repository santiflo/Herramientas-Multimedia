import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress direccion;

int puerto;
String ip;

int n_balls;  //Cantidad de bolas rebotando por la pantalla
int [] posX;  //Posicion de cada bola en el eje X
int [] posY;  //Posicion de cada bola en el eje Y
int [] velX;  //Velocidad de movimiento de cada bola en X
int [] velY;  //Velocidad de movimiento de cada bola en Y
int [] min_size;  //Tamaño de cada bola
int [] size;
int [] max_size;  //Tamaño maximo de cada bola
int [] grow;  //Taza de crecimiento de cada bola
String [] mess;  //Mensaje udp
float [] dist;

void setup(){
  size(800,600);
  
  ip = "127.0.0.1";
  puerto = 8080;

  oscP5 = new OscP5(this, puerto);
  direccion = new NetAddress(ip, puerto);
  
  n_balls = 6;
  posX = new int[n_balls];
  posY = new int[n_balls];
  velX = new int[n_balls];
  velY = new int[n_balls];
  min_size = new int[n_balls];
  size = new int[n_balls];
  max_size = new int[n_balls];
  grow = new int[n_balls];
  mess = new String[n_balls];
  dist = new float[n_balls];
  
  for(int i=0;i<n_balls; i++)
  {
    posX[i] = int(random(0,width));
    posY[i] = int(random(0,height));
    int vel = int(random(1,5));
    velX[i] = vel;
    velY[i] = vel;
    min_size[i] = int(random(10,50));
    size[i] = int(random(50,60));
    max_size[i] = int(random(60,80));
    grow[i] = int(random(2,10));
    mess[i] = "/1/push"+(i+1);
    dist[i] = 0;
  }
  
}

void draw()
{
  background(0);
  for(int i=0; i<n_balls; i++)
  {
    //Quita el borde a la bola
    noStroke();
    //
    fill(random(255), random(255), random(255), random(255));
    //Dibuja la bola
    ellipse(posX[i],posY[i],size[i],size[i]);
    
    movimiento(i);
    
    crecer_reducir(i);
    
    calcular_distancia(i);
    
    dibujar_linea(i);
  }
}

//Metodo que controla el movimiento de las bolas por las pantalla
void movimiento(int index)
{
  //Movimiento de la bola por el eje X
    posX[index] = posX[index]+velX[index];
    if(posX[index]>=width || posX[index]<0)
    {
      velX[index]=velX[index]*-1;
    }
    //Movimiento de la bola por el eje y
    posY[index] = posY[index]+velY[index];
    if(posY[index]>=height || posY[index]<0)
    {
      velY[index] = velY[index]*-1;
    }
}

//metodo que controla el crecimiento y la reduccion de las bolas
void crecer_reducir(int index)
{
  size[index] = size[index]+grow[index];
    if(size[index]>max_size[index] || size[index]<min_size[index])
    {
      grow[index] = grow[index]*-1;
    }
}

//Metodo que calcula la distancia de un nodo contra todos los demas
void calcular_distancia(int index)
{
  for(int j=0; j<n_balls; j++)
    {
      if(j==index)
      {
        dist[j]=0;
      }else
      {
        dist[j] = dist(posX[index],posY[index],posX[j],posY[j]);
      }
    }
}

void dibujar_linea(int index)
{
  for(int j=0; j<n_balls; j++)
  {
    if(j!=index && dist[j]<=100)
    {
      stroke(random(255), random(255), random(255), random(255));
      line(posX[index],posY[index],posX[j],posY[j]);
      enviar_mensaje(j,1);
    }
    else
    {
      enviar_mensaje(index,0);
    }
  }
}

void enviar_mensaje(int index, int add)
{
  OscMessage mensaje = new OscMessage(mess[index]);
  mensaje.add(add);
  oscP5.send(mensaje, direccion);
}
