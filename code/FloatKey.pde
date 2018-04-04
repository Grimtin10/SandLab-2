public class FloatKey{
  int[] ICNT1;
  float[] ICNT2;
  public FloatKey(int[] ICNT1,float[] ICNT2){
    this.ICNT1 = ICNT1;
    this.ICNT2 = ICNT2;
  }
  
  public float getMatch(int match){
    for(int i=0;i<ICNT1.length;i++){
      if(ICNT1[i]==match){
        return ICNT2[i];
      }
    }
    return -1;
  }
}