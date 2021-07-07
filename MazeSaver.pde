import java.io.FileWriter;   // Import the FileWriter class
import java.io.IOException;
import java.io.BufferedWriter;


/*
  0= path
  1= wall
*/

class MazeSaver{
  
  final String filePath = "MazeStorage";
  
  MazeSaver()
  {
    
  }
  
  void saveMaze()
  {
      selectInput("Enter the fileName", "saveFile");
  }
 
}

 void saveFile(File file)
{
    if(file.exists() && !file.isDirectory())
    {
      System.out.println("File is valid");
      writeMazeToFile(file);
    }
    else
    {
      System.out.println("Invalid file");
    }
}

void writeMazeToFile(File file)
{
    try{  
      FileWriter fw = new FileWriter(file);
      PrintWriter pr = new PrintWriter(fw);
      pr.println("rows: " + (2*maze.rows-1) + " cols: " + (2*maze.cols-1) + "*");
      
      for(int i=0; i<2*maze.rows-1; ++i)
      {
        String temp = "";
        for(int j=0; j<2*maze.cols-1; ++j)
        {
            if(maze.cells[i][j].type == Type.PATH)
              temp += "0";
             else temp +="1";
        }
        pr.println(temp);
      }
      pr.close();      
    }
    catch(Exception e)
    {
       e.printStackTrace(); 
    }
    System.out.println("Saved to file");
}
