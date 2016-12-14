public class LineSeg
{
  public double x0;
  public double y0;
  public double x1;
  public double y1;
  private color c;
  
  public LineSeg(double x0, double y0, double x1, double y1, color c)
  {
    /*DEPRECTATED, we don't need to make the front vs back algorithm
      common because front vs back is evaluated at all tree nodes during
      rendering*/
    /*the reason we do these swaps here is so that the variable
      marked with 1 is always larger than the one with 0. That way the
      getNormal method will always return a predictable vector
      no matter which coordinate is (x0,y0) and which is (x1,y1)*/
    /*if(x0 > x1)
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
    }*/
    this.x0 = x0;
    this.y0 = y0;
    this.x1 = x1;
    this.y1 = y1;
    this.c = c;
  }
  
  public LineSeg(Point a, Point b, color c)
  {
    this.x0 = a.x;
    this.y0 = a.y;
    this.x1 = b.x;
    this.y1 = b.y;
    this.c = c;
  }
  
  public LineSeg(boolean isVector, double x0, double y0, double x1, double y1, color c)
      throws IllegalArgumentException
  {
    if(!isVector || x0 != 0 || y0 != 0)
    {
      throw new IllegalArgumentException("Why the heck are you using this constructor, if "+
                                          "you're not constructing a vector?");
    }
    /*This constructor does not swap the coordinates because a vector
      needs x0 and y0 to always be zero*/
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
  
  public Point getPerp()
  {
    double dx = this.x1-this.x0;
    double dy = this.y1-this.y0;
    return new Point(-dy, dx);
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
  
  public List<Point> getPts()
  {
    List<Point> ptList = new ArrayList<Point>();
    ptList.add(new Point(this.x0,this.y0));
    ptList.add(new Point(this.x1,this.y1));
    return ptList;
  }
  
  public String toString()
  {
    return "("+this.x0+", "+this.y0+") -> ("+
            this.x1+", "+this.y1+") \n";
  }
}