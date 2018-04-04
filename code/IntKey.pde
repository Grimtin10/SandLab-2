public class IntKey{
  int[] ICNT1;
  int[] ICNT2;
  public IntKey(int[] ICNT1,int[] ICNT2){
    this.ICNT1 = ICNT1;
    this.ICNT2 = ICNT2;
  }
  
  public int getMatch(int match){
    for(int i=0;i<ICNT1.length;i++){
      if(ICNT1[i]==match){
        return ICNT2[i];
      }
    }
    return -1;
  }
}