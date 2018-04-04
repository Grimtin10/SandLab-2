public class ColorKey{
  int[] ICNT1;
  color[] ICNT2;
  public ColorKey(int[] ICNT1,color[] ICNT2){
    this.ICNT1 = ICNT1;
    this.ICNT2 = ICNT2;
  }
  
  public color getMatch(int match){
    for(int i=0;i<ICNT1.length;i++){
      if(ICNT1[i]==match){
        return ICNT2[i];
      }
    }
    return color(0,0,0);
  }
}