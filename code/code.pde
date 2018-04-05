int size = 2;
int type = 1;
int rad = 1;
int wallType = 3;
int ver = 1;
int fireLast = 500;

float maxTemp = 9725.85;
float minTemp = -273.15;

int[] types = {0,1,2,3,4,5,6,7,8};
int[] states = {0,1,2,3,4,4,4,2,3,0,0};
int[] melt = {0,5,6,7,5,5,5,5,8,0};

float[] thermals = {100,50,75,80,100,0,50,50,50};
float[] weights = {0,30,45,100,50,50,50,45,100};
float[] temps = {20,20,20,20,20,400,100,1000,20};
float[] melts = {9999,400,100,1000,400,maxTemp+1,maxTemp+1,maxTemp+1,maxTemp+1};

color[] colors = {color(0,0,0),color(255,248,220),color(0,0,255),color(128,128,128),color(0,245,0),color(255,140,0),color(100,100,256),color(255,140,0),color(128,128,256)};

IntKey typeState = new IntKey(types,states);
IntKey meltType = new IntKey(types,melt);

ColorKey typeColor = new ColorKey(types,colors);

FloatKey typeWeight = new FloatKey(types,weights);
FloatKey typeMelt = new FloatKey(types,melts);
FloatKey typeTemp = new FloatKey(types,temps);
FloatKey typeConduct = new FloatKey(types,thermals);

Cell emptyCell = new Cell(typeTemp.getMatch(0),0,typeState.getMatch(0),typeWeight.getMatch(0),typeConduct.getMatch(0));
Cell wallCell;

Cell[][] cells;

void setup(){
  size(1280,720);
  cells = new Cell[width/size][height/size];
  for(int x=0;x<cells.length;x++){
    for(int y=0;y<cells[0].length;y++){
      cells[x][y]=new Cell(typeTemp.getMatch(0),0,typeState.getMatch(0),typeWeight.getMatch(0),typeConduct.getMatch(0));;
    }
  }
  wallCell = new Cell(typeTemp.getMatch(wallType),wallType,typeState.getMatch(wallType),typeWeight.getMatch(wallType),typeConduct.getMatch(wallType));
  makeWalls();
}

void draw(){
  background(0);
  noStroke();
  update();
  for(int x=0;x<cells.length;x++){
    for(int y=0;y<cells[0].length;y++){
      //if(cells[x][y].getType()!=0){
        //if(cells[x][y].getTemp()>=1000){
          //fill((typeColor.getMatch(cells[x][y].getType()))+color(cells[x][y].getTemp()-1000));
        //} else {
          //fill((typeColor.getMatch(cells[x][y].getType())));
        //}
        color c = typeColor.getMatch(cells[x][y].getType());
        if(cells[x][y].getTemp()<=0){
          fill(red(c)/5,green(c)/5,blue(c)/5+map(cells[x][y].getTemp(),0,minTemp,0,255));
        } else {
          fill(red(c)/5+map(cells[x][y].getTemp(),0,maxTemp,0,255),green(c)/5,blue(c)/5);
        }
        rect(x*size,y*size,size,size);
      //}
    }
  }
  drawCircle(mouseX/size,mouseY/size,rad-1,220);
  surface.setTitle("SandLab ver. "+ver+" Type: "+type+" FPS: "+frameRate);
  textSize(8);
  text("Hover type: "+cells[mouseX/size][mouseY/size].getType()+" temperature "+cells[mouseX/size][mouseY/size].getTemp(),4,height-4);
}

void update(){
  for(int x=0;x<cells.length;x++){
    for(int y=0;y<cells[0].length;y++){
      cells[x][y].updateCell(x,y);
      cells[x][y].doSpecial(x,y);
      if(x==mouseX/size&&y==mouseY/size){
        if(mousePressed&&mouseButton==LEFT){
          for(int i=0;i<rad;i++){
            if(type>=0){
              drawCircle(x,y,i,new Cell(typeTemp.getMatch(type),type,typeState.getMatch(type),typeWeight.getMatch(type),typeConduct.getMatch(type)));
            } else {
              if(type==-2){
                drawCircle(x,y,i,true,-10);
              } else {
                drawCircle(x,y,i,true,10);
              }
            }
          }
        } else if(mousePressed&&mouseButton==RIGHT){
          for(int i=0;i<rad;i++){
            drawCircle(x,y,i,new Cell(typeTemp.getMatch(0),0,typeState.getMatch(0),typeWeight.getMatch(0),typeConduct.getMatch(0)));
          }
        }
      }
    }
  }
}

Cell[] getNeighbors(int x,int y){
  Cell[] temp = new Cell[8];
  if(x>0&&y>0){
    temp[0] = cells[x-1][y-1];
  } else {
    temp[0] = new Cell(typeTemp.getMatch(0),0,typeState.getMatch(0),typeWeight.getMatch(0),typeConduct.getMatch(0));;
  }
  if(y>0){
    temp[1] = cells[x][y-1];
  } else {
    temp[1] = new Cell(typeTemp.getMatch(0),0,typeState.getMatch(0),typeWeight.getMatch(0),typeConduct.getMatch(0));;
  }
  if(x<cells.length-1&&y>0){
    temp[2] = cells[x+1][y-1];
  } else {
    temp[2] = new Cell(typeTemp.getMatch(0),0,typeState.getMatch(0),typeWeight.getMatch(0),typeConduct.getMatch(0));;
  }
  if(x>0){
    temp[3] = cells[x-1][y];
  } else {
    temp[3] = new Cell(typeTemp.getMatch(0),0,typeState.getMatch(0),typeWeight.getMatch(0),typeConduct.getMatch(0));;
  }
  if(x<cells.length-1){
    temp[4] = cells[x+1][y];
  } else {
    temp[4] = new Cell(typeTemp.getMatch(0),0,typeState.getMatch(0),typeWeight.getMatch(0),typeConduct.getMatch(0));;
  }
  if(x>0&&y<cells[0].length-1){
    temp[5] = cells[x-1][y+1];
  } else {
    temp[5] = new Cell(typeTemp.getMatch(0),0,typeState.getMatch(0),typeWeight.getMatch(0),typeConduct.getMatch(0));;
  }
  if(y<cells[0].length-1){
    temp[6] = cells[x][y+1];
  } else {
    temp[6] = new Cell(typeTemp.getMatch(0),0,typeState.getMatch(0),typeWeight.getMatch(0),typeConduct.getMatch(0));;
  }
  if(x<cells.length-1&&y<cells[0].length-1){
    temp[7] = cells[x+1][y+1];
  } else {
    temp[7] = new Cell(typeTemp.getMatch(0),0,typeState.getMatch(0),typeWeight.getMatch(0),typeConduct.getMatch(0));;
  }
  return temp;
}

void makeWalls(){
  for(int i=0;i<cells.length;i++){
    cells[i][0]=wallCell;
  }
  for(int i=0;i<cells.length;i++){
    cells[i][cells[0].length-1]=wallCell;
  }
  for(int i=0;i<cells[0].length;i++){
    cells[0][i]=wallCell;
  }
  for(int i=0;i<cells[0].length;i++){
    cells[cells.length-1][i]=wallCell;
  }
}

void drawCircle(int centerX,int centerY,int rad,color c){
  int d = 3 - (2 * rad);
  int x = 0;
  int y = rad;
  do {
      /*image.setPixel(centerX + x, centerY + y, circleColor);
      image.setPixel(centerX + x, centerY - y, circleColor);
      image.setPixel(centerX - x, centerY + y, circleColor);
      image.setPixel(centerX - x, centerY - y, circleColor);
      image.setPixel(centerX + y, centerY + x, circleColor);
      image.setPixel(centerX + y, centerY - x, circleColor);
      image.setPixel(centerX - y, centerY + x, circleColor);
      image.setPixel(centerX - y, centerY - x, circleColor);*/
      int centerXPlus = centerX+x;
      int centerXMinus = centerX-x;
      int centerYPlus = centerX+y;
      int centerYMinus = centerX-y;
      int centerYYPlus = centerY+y;
      int centerYYMinus = centerY-y;
      int centerYXPlus = centerY+x;
      int centerYXMinus = centerY-x;
      //cells[centerXPlus][centerYYPlus] = cell;
      //cells[centerXPlus][centerYYMinus] = cell;
      //cells[centerXMinus][centerYYPlus] = cell;
      //cells[centerXMinus][centerYYMinus] = cell;
      //cells[centerYPlus][centerYXPlus] = cell;
      //cells[centerYPlus][centerYXMinus] = cell;
      //cells[centerYMinus][centerYXPlus] = cell;
      //cells[centerYMinus][centerYXMinus] = cell;
      fill(c);
      rect(centerXPlus*size,centerYYPlus*size,size,size);
      rect(centerXPlus*size,centerYYMinus*size,size,size);
      rect(centerXMinus*size,centerYYPlus*size,size,size);
      rect(centerXMinus*size,centerYYMinus*size,size,size);
      rect(centerYPlus*size,centerYXPlus*size,size,size);
      rect(centerYPlus*size,centerYXMinus*size,size,size);
      rect(centerYMinus*size,centerYXPlus*size,size,size);
      rect(centerYMinus*size,centerYXMinus*size,size,size);
      if (d < 0) {
          d = d + (4 * x) + 6;
      } else {
          d = d + 4 * (x - y) + 10;
          y--;
      }
      x++;
    } while (x <= y);
}

void drawCircle(int centerX,int centerY,int radius,Cell cell){
  int d = 3 - (2 * radius);
  int x = 0;
  int y = radius;
  do {
      /*image.setPixel(centerX + x, centerY + y, circleColor);
      image.setPixel(centerX + x, centerY - y, circleColor);
      image.setPixel(centerX - x, centerY + y, circleColor);
      image.setPixel(centerX - x, centerY - y, circleColor);
      image.setPixel(centerX + y, centerY + x, circleColor);
      image.setPixel(centerX + y, centerY - x, circleColor);
      image.setPixel(centerX - y, centerY + x, circleColor);
      image.setPixel(centerX - y, centerY - x, circleColor);*/
      int centerXPlus = centerX+x;
      int centerXMinus = centerX-x;
      int centerYPlus = centerX+y;
      int centerYMinus = centerX-y;
      int centerYYPlus = centerY+y;
      int centerYYMinus = centerY-y;
      int centerYXPlus = centerY+x;
      int centerYXMinus = centerY-x;
      if(centerXPlus>cells.length-1){
        centerXPlus = cells.length-1;
      }
      if(centerXMinus<1){
        centerXMinus = 1;
      }
      if(centerYPlus>cells.length-1){
        centerYPlus = cells.length-1;
      }
      if(centerYMinus<1){
        centerYMinus = 1;
      }
      if(centerYXPlus>cells[0].length-1){
        centerYXPlus = cells[0].length-1;
      }
      if(centerYXMinus<1){
        centerYXMinus = 1;
      }
      if(centerYYPlus>cells[0].length-1){
        centerYYPlus = cells[0].length-1;
      }
      if(centerYYMinus<1){
        centerYYMinus = 1;
      }
      cells[centerXPlus][centerYYPlus] = cell;
      cells[centerXPlus][centerYYMinus] = cell;
      cells[centerXMinus][centerYYPlus] = cell;
      cells[centerXMinus][centerYYMinus] = cell;
      cells[centerYPlus][centerYXPlus] = cell;
      cells[centerYPlus][centerYXMinus] = cell;
      cells[centerYMinus][centerYXPlus] = cell;
      cells[centerYMinus][centerYXMinus] = cell;
          if (d < 0) {
              d = d + (4 * x) + 6;
          } else {
              d = d + 4 * (x - y) + 10;
              y--;
          }
          x++;
    } while (x <= y);
}

void drawCircle(int centerX,int centerY,int radius,boolean changeTemp,float change){
  int d = 3 - (2 * radius);
  int x = 0;
  int y = radius;
  do {
      /*image.setPixel(centerX + x, centerY + y, circleColor);
      image.setPixel(centerX + x, centerY - y, circleColor);
      image.setPixel(centerX - x, centerY + y, circleColor);
      image.setPixel(centerX - x, centerY - y, circleColor);
      image.setPixel(centerX + y, centerY + x, circleColor);
      image.setPixel(centerX + y, centerY - x, circleColor);
      image.setPixel(centerX - y, centerY + x, circleColor);
      image.setPixel(centerX - y, centerY - x, circleColor);*/
      int centerXPlus = centerX+x;
      int centerXMinus = centerX-x;
      int centerYPlus = centerX+y;
      int centerYMinus = centerX-y;
      int centerYYPlus = centerY+y;
      int centerYYMinus = centerY-y;
      int centerYXPlus = centerY+x;
      int centerYXMinus = centerY-x;
      if(centerXPlus>cells.length-1){
        centerXPlus = cells.length-1;
      }
      if(centerXMinus<1){
        centerXMinus = 1;
      }
      if(centerYPlus>cells.length-1){
        centerYPlus = cells.length-1;
      }
      if(centerYMinus<1){
        centerYMinus = 1;
      }
      if(centerYXPlus>cells[0].length-1){
        centerYXPlus = cells[0].length-1;
      }
      if(centerYXMinus<1){
        centerYXMinus = 1;
      }
      if(centerYYPlus>cells[0].length-1){
        centerYYPlus = cells[0].length-1;
      }
      if(centerYYMinus<1){
        centerYYMinus = 1;
      }
      cells[centerXPlus][centerYYPlus].changeTemp(change);
      cells[centerXPlus][centerYYMinus].changeTemp(change);
      cells[centerXMinus][centerYYPlus].changeTemp(change);
      cells[centerXMinus][centerYYMinus].changeTemp(change);
      cells[centerYPlus][centerYXPlus].changeTemp(change);
      cells[centerYPlus][centerYXMinus].changeTemp(change);
      cells[centerYMinus][centerYXPlus].changeTemp(change);
      cells[centerYMinus][centerYXMinus].changeTemp(change);
          if (d < 0) {
              d = d + (4 * x) + 6;
          } else {
              d = d + 4 * (x - y) + 10;
              y--;
          }
          x++;
    } while (x <= y);
}

void keyPressed(){
  if (key == CODED) {
    if(keyCode==UP){
      rad++;
    }
    if(keyCode==DOWN&&rad>=1){
      rad--;
    }
    if(keyCode==RIGHT&&type<types.length-1){
      type++;
    }
    if(keyCode==LEFT&&type>=-2){
      type--;
    }
  } else {
    if(key==DELETE){
      for(int x=0;x<(width-1)/size;x++){
        for(int y=0;y<(height-1)/size;y++){
          cells[x][y] = new Cell(typeTemp.getMatch(0),0,typeState.getMatch(0),typeWeight.getMatch(0),typeConduct.getMatch(0));;
        }
      }
      makeWalls();
    }
  }
}