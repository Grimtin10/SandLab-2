public class Cell{
  int state = 0;
  int type = 0;
  int tmp = 0;
  float temp = 0;
  float weight = 0;
  float thermal = 100;
  
  public Cell(float temp,int type,int state,float weight,float thermal){
    this.state = state;
    this.temp = temp;
    this.type = type;
    this.weight = weight;
    this.thermal = thermal;
  }
  
  public void updateCell(int x,int y){
    if(state==1){
      float r=random(0,100);
      float r2=random(0,100);
      if(y<cells[0].length-1&&x>0&&x<cells.length-1){
        if(r2>=100-weight){
          if(cells[x][y+1].getType()==0||cells[x][y+1].getWeight()<weight){
            Cell c = cells[x][y+1];
            cells[x][y+1]=cells[x][y];
            cells[x][y]=c;
          } else if(r<=50&&x>0&&cells[x-1][y+1].getType()==0){
            Cell c = cells[x-1][y+1];
            cells[x-1][y+1]=cells[x][y];
            cells[x][y]=c;
          } else if(cells[x+1][y+1].getType()==0){
            Cell c = cells[x+1][y+1];
            cells[x+1][y+1]=cells[x][y];
            cells[x][y]=c;
          }
        }
      } else {
        cells[x][y]=emptyCell;
      }
    }
    if(state==2&&x>0&&x<cells.length-1){
      float r=random(0,100);
      float r2=random(0,100);
      if(y<cells[0].length-1){
        if(r2>=100-weight){
          if(cells[x][y+1].getType()==0||cells[x][y+1].getWeight()<weight){
            Cell c = cells[x][y+1];
            cells[x][y+1]=cells[x][y];
            cells[x][y]=c;
          } else if(r<=50&&x>0&&cells[x-1][y].getType()==0){
            Cell c = cells[x-1][y];
            cells[x-1][y]=cells[x][y];
            cells[x][y]=c;
          } else if(cells[x+1][y].getType()==0){
            Cell c = cells[x+1][y];
            cells[x+1][y]=cells[x][y];
            cells[x][y]=c;
          }
        }
      } else {
        cells[x][y]=emptyCell;
      }
    }
    if(state==4&&x>0&&x<cells.length-1){
      float r=random(0,100);
      float r2=random(0,100);
      if(y>0){
        if(r2>=100-weight){
          if(cells[x][y-1].getType()==0||cells[x][y-1].getWeight()<weight){
            Cell c = cells[x][y-1];
            cells[x][y-1]=cells[x][y];
            cells[x][y]=c;
          } else if(r<=50&&x>0&&cells[x-1][y].getType()==0){
            Cell c = cells[x-1][y];
            cells[x-1][y]=cells[x][y];
            cells[x][y]=c;
          } else if(cells[x+1][y].getType()==0){
            Cell c = cells[x+1][y];
            cells[x+1][y]=cells[x][y];
            cells[x][y]=c;
          }
        }
      } else {
        cells[x][y]=emptyCell;
      }
    }
    doTemp(x,y);
    if(temp==typeMelt.getMatch(type)){
      type=meltType.getMatch(type);
      state=typeState.getMatch(type);
    }
    temp=(temp>maxTemp)?maxTemp:(temp<minTemp)?minTemp:temp;
    //if(flammable){
    //  Cell[] t = getNeighbors(x,y);
    //  boolean heat = false;
    //  for(int i=0;i<8;i++){
    //    if(t[i].getHot()){
    //      heat=true;
    //    }
    //  }
    //  if(heat){
    //    cells[x][y]=new Cell(typeTemp.getMatch(4),4,typeState.getMatch(4),typeWeight.getMatch(4),typeFlame.getMatch(4),typeHeat.getMatch(4),typeTime.getMatch(4));
    //  }
    //}
  }
  
  public void doSpecial(int x,int y){
    if(type==5){
      if(tmp==0){
        tmp=fireLast+1;
      } else if(tmp==1){
        cells[x][y]=emptyCell;
      } else {
        tmp--;
      }
      if(temp<400){
        temp=400;
      }
    }
  }
  
  public void doTemp(int x,int y){
    Cell[] t = getNeighbors(x,y);
    float[] t2 = new float[8];
    float t3 = 0;
    for(int i=0;i<8;i++){
      t2[i]=t[i].getTemp();
    }
    for(int i=0;i<8;i++){
      t3+=t2[i];
    }
    float t5=(thermal/100);
    t3=(t3/8);
    float t4=(t3-temp)*t5;
    temp+=t4;
  }
  
  public void changeTemp(float change){temp+=change;}
  
  public int getType(){return type;}
  public float getWeight(){return weight;}
  public float getTemp(){return temp;}
}