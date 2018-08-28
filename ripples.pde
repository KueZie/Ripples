int cols;
int rows;
float[][] BufferOne;
float[][] BufferTwo;
float dampening = 0.999;

void setup() {
  size(1200, 800);
  cols = width;
  rows = height;
  BufferOne = new float[cols][rows];
  BufferTwo = new float[cols][rows];
  background(0);
}

void draw() {
  loadPixels();
  
  for(int i = 1; i < cols - 1; i++) {
    for(int j = 1; j < rows - 1; j++) {
      // System.out.println(i + " " + j);
      int index = i + j * cols;
      BufferTwo[i][j] = (
        BufferOne[i - 1][j  ] + BufferOne[i  ][j + 1] +
        BufferOne[i + 1][j  ] + BufferOne[i  ][j - 1]
      ) / 2 - BufferTwo[i][j];
      BufferTwo[i][j] = BufferTwo[i][j] * dampening;
      // Displays the buffer.
      pixels[index] = color( BufferTwo[i][j] );
    }
  }
  // Switch Buffers
  float[][] temp = BufferOne;
  BufferOne = BufferTwo;
  BufferTwo = temp;
  
  updatePixels();
}

void mouseDragged() {
  BufferTwo[mouseX][mouseY] = 255;
}
