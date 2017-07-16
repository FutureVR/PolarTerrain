TerrainController tc;

float rotX = 0;
float rotY = 0;

boolean pressed = false;
boolean released = false;
boolean setStartTimer = false;
float startTime = 0;
float maxTimeElapsed = 5000;

float minAmp = 5;
float maxAmp = 150;

boolean displayingText = true;

void setup()
{
  size(1600, 900, P3D);
  background(255);
  
  tc = new TerrainController( new PVector(0, 0) );
}

void draw()
{
  if (displayingText)
  {
    background(0);
    fill(255);
    
    textSize(64);
    textAlign(CENTER);
    text("Hold and release mouse to form ripples", width / 2, height / 2);
  }
  else
  {
    background(0);
    
    fill(255);
    translate( width / 2, height / 2);
    rotX = map(mouseY, 0, height, 180, -180);
    rotY = map(mouseX, 0, width, -180, 180); 
    rotateX(radians(rotX));
    rotateY(radians(rotY));
    
    
    if(pressed)
    {
      if(!setStartTimer)
      {
        setStartTimer = true;
        startTime = millis();
      }
      
      if(released)
      {
        pressed = false;
        released = false;
        setStartTimer = false;
        
        float timeElapsed = millis() - startTime;
        float amp = map(timeElapsed, 0, maxTimeElapsed, minAmp, maxAmp);
        tc.addWave(0, random(.2, 12), amp, random(100, 500));
      }
    }
    
    tc.mainUpdate();
  }
}

void mousePressed()
{
  pressed = true;
  displayingText = false;
}

void mouseReleased()
{
  released = true;
}
