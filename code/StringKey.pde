public class StringKey{
  int[] ICNT1;
  String[] ICNT2;
  public StringKey(int[] ICNT1,String[] ICNT2){
    this.ICNT1 = ICNT1;
    this.ICNT2 = ICNT2;
  }
  
  public String getMatch(int match){
    for(int i=0;i<ICNT1.length;i++){
      if(ICNT1[i]==match){
        return ICNT2[i];
      }
    }
    return "";
  }
}