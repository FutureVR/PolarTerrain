class Wave
{
  float posX;
  float speedX;
  float amp;
  float wavelength;
  
  Wave( float px, float sx, float a, float w )
  {
    posX = px;
    speedX = sx;
    amp = a;
    wavelength = w;
  }
  
  void mainUpdate()
  {
    updateMovement();
  }
  
  void updateMovement()
  {
    posX += speedX;
  }
}