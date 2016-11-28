public class BSPTree
{
  private BSPTreeNode root;
  
  public BSPTree(List<LineSeg> localLineList)
  {
    this.root = new BSPTreeNode(localLineList.remove(0));
    List<LineSeg> linesInFront = new ArrayList<LineSeg>();
    List<LineSeg> linesBehind = new ArrayList<LineSeg>();
    
    for(LineSeg currLine : localLineList)
    {
      List<Point> currPts = currLine.getPts();
    }
    
    this.root.setInFront( this.recurConstrPri(linesInFront, this.root.getLine()));
    this.root.setBehind( this.recurConstrPri(linesBehind, this.root.getLine()));
  }
  
  private BSPTreeNode recurConstrPri(List<LineSeg> remainingLines, LineSeg referenceLine)
  {
    if(remainingLines.size() == 1)
    {
      return new BSPTreeNode(remainingLines.remove(0));
    } 
    else 
    {
      BSPTreeNode current = new BSPTreeNode(remainingLines.remove(0));
      List<LineSeg> linesInFront = new ArrayList<LineSeg>();
      List<LineSeg> linesBehind = new ArrayList<LineSeg>();
      
      for(LineSeg currLine : remainingLines)
      {
        List<Point> currPts = currLine.getPts();
        
      }
      
      current.setInFront( this.recurConstrPri(linesInFront, current.getLine()));
      current.setBehind( this.recurConstrPri(linesBehind, current.getLine()));
      
      return current;
    }
  }
  
  private class BSPTreeNode
  {
    private LineSeg line;
    private BSPTreeNode inFront;
    private BSPTreeNode behind;
    
    public BSPTreeNode(LineSeg line)
    {
      this.line = line;
    }
    
    public void setInFront(BSPTreeNode node)
    {
      this.inFront = node;
    }
    
    public void setBehind(BSPTreeNode node)
    {
      this.behind = node;
    }
    
    public LineSeg getLine()
    {
      return this.line;
    }
  }
}