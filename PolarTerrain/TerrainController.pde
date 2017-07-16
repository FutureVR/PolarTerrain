class TerrainController
{
  ArrayList<PVector> points = new ArrayList<PVector>();
  ArrayList<Wave> waves = new ArrayList<Wave>();
  
  PVector position;
  
  int sizeTheta = 200;
  int sizeR = 50;
  float totalTheta = 360;
  float totalRadius = 600;
  float stepTheta = totalTheta / sizeTheta;
  float stepR = totalRadius / sizeR;
  float maxHeight = 100;
  float minHeight = -100;
  
  float limitingDist = 1500;
  
  TerrainController(PVector p)
  {
    position = p.copy();
    createTerrain();
    
    //waves.add( new Wave(0, .4, 30, 100 ));
    //waves.add( new Wave(0, .2, 35, 100 ));
  }
  
  
  void mainUpdate()
  {
    createTerrain();
    updateWaves();
    displayTerrain();
  }
  
  
  void createTerrain()
  {
    points.clear();

    for(int r = 0; r < sizeR; r++)
    {
      for(int theta = 0; theta < sizeTheta; theta++)
      {
        float posX = (r * stepR) * cos(radians(theta * stepTheta)) + position.x;
        float posY = (r * stepR) * sin(radians(theta * stepTheta)) + position.y;
        float posZ = 0;
        //float posZ = r * (float)frameCount / 100f;
        
        points.add( new PVector( posX, posY, posZ ) );
      }
    }
  }
  
  void updateWaves()
  {
    //for( PVector p : points ) p.z = 0;
    
    for( Wave w : waves )
    {
      w.mainUpdate();
      
      for(int r = 0; r < sizeR - 1; r++)
      {
        PVector myPoint = points.get( r * sizeTheta );
        float dist = w.posX - myPoint.x;
        
        if( dist < limitingDist)
        {
          float angle = map(dist, -w.wavelength / 2f, w.wavelength / 2f, -180, 180);
          float newHeight = w.amp * (1 - dist / limitingDist) * sin(radians(angle));
          
          for(int theta = 0; theta < sizeTheta; theta++)
          {
            PVector v = points.get( theta + r * sizeTheta );
            v.z += newHeight;
          }
        }
      }
    }
  }
  
  void addWave( float px, float sx, float a, float w)
  {
    waves.add( new Wave( px, sx, a, w ) );
  }
  
  
  void displayTerrain()
  {
    for(int r = 0; r < sizeR - 2; r++)
    {
      beginShape(TRIANGLE_STRIP);
      for(int theta = 0; theta <= sizeTheta; theta++)
      {
        PVector v1, v2;

        v1 = points.get( theta + r * sizeTheta );
        v2 = points.get( theta + (r+1) * sizeTheta );
        
        if( theta == sizeTheta )
        {
          v1 = points.get( 0 + r * sizeTheta );
          v2 = points.get( 0 + (r + 1) * sizeTheta );
        }
        
        vertex(v1.x, v1.y, v1.z);
        vertex(v2.x, v2.y, v2.z);
      }
      endShape(CLOSE);
    }
  }
}