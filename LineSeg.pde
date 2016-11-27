public class LineSeg
{
  public double x0;
  public double y0;
  public double x1;
  public double y1;
  private color c;
  
  public LineSeg(double x0, double y0, double x1, double y1, color c)
  {
    /*the reason we do these swaps here is so that the variable
      marked with 1 is always larger than the one with 0. That way the
      getNormal method will always return a predictable vector
      no matter which coordinate is (x0,y0) and which is (x1,y1)*/
    if(x0 > x1)
    {
      double swap = x0;
      x0 = x1;
      x1 = swap;
    }
    if(y0 > y1)
    {
      double swap = y0;
      y0 = y1;
      y1 = swap;
    }
    this.x0 = x0;
    this.y0 = y0;
    this.x1 = x1;
    this.y1 = y1;
    this.c = c;
  }
  
  public color getColor()
  {
    return this.c;
  }
  
  public LineSeg getPerp()
  {
    double dx = this.x1-this.x0;
    double dy = this.y1-this.y0;
    return new LineSeg(0,0,-dy,dx,this.c);
  }
  
  public LineSeg normalized()
      throws IllegalStateException
  {
    if(this.x0 != 0 || this.y0 != 0)
    {
      throw new IllegalStateException("cannot normalize a non-vector line seg");
    }
    double lineLength = this.length();
    return new LineSeg(0,0,this.x1/lineLength,this.y1/lineLength,this.c);
  }
  
  public double length()
  {
    double dx = 0;
    double dy = 0;
    if(this.x0 == 0 && this.y0 == 0)
    {
      dx = this.x1;
      dy = this.y1;
    }
    else
    {
      dx = this.x1-this.x0;
      dy = this.y1-this.y0;
    }
    return sqrt((float)(dx * dx + dy * dy));
  }
  
  public String toString()
  {
    return "("+this.x0+", "+this.y0+") -> ("+
            this.x1+", "+this.y1+")";
  }
}