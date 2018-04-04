public class BoolKey{
  int[] ICNT1;
  boolean[] ICNT2;
  public BoolKey(int[] ICNT1,boolean[] ICNT2){
    this.ICNT1 = ICNT1;
    this.ICNT2 = ICNT2;
  }
  
  public boolean getMatch(int match){
    for(int i=0;i<ICNT1.length;i++){
      if(ICNT1[i]==match){
        return ICNT2[i];
      }
    }
    return false;
  }
}