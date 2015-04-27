//The WallRect Class
//This class creates wall objects
//Functions include two constructors, colliders, and redraw
class WallRect {
    //Variables for the WallRect Object/Class
    public int x;
    public int y;
    public int sizeX;
    public int sizeY;

    //The Normal Wall Constructr - Uses the rect function to draw the wall
    //@param x is the x coordinate of the top left corner
    //@param y is the y coordinate of the top left corner
    //@param sizeX is the length of the wall on the X axis
    //@param sizeY is the length of the wall on the Y axis
    public WallRect(int x, int y, int sizeX, int sizeY) {
        this.x = x;
        this.y = y;
        this.sizeX = sizeX;
        this.sizeY = sizeY;
        fill(#000000);
        rect(x, y, sizeX, sizeY);
    } 

    //The Image Wall Constructor - Uses the imgage function to draw the wall
    //@param x is the x coordinate of the top left corner
    //@param y is the y coordinate of the top left corner
    //@param sizeX is the length of the wall on the X axis
    //@param sizeY is the length of the wall on the Y axis
    //@param imgName is the name of the image to be used for the wall
    public WallRect(int x, int y, int sizeX, int sizeY, String imgName) {
        this.x = x;
        this.y = y;
        this.sizeX = sizeX;
        this.sizeY = sizeY;
        //Since we are using an image, it is best that sizeX and sizeY do one of the following:
        // - Match the original dimensions of the image
        // - Proportional to the original dimensions
        //This prevents distortion of the image
        image(loadImage(imgName), x, y, sizeX, sizeY);
    }

    //The checkCollision Function - Checks if the player has made a collision with the wall
    //@param playerX is the x coordinate of the top left corner of the player
    //@param playerY is the y coordinate of the top left corner of the player
    //@param playerWidthX is the length of the player on the x coordinate
    //@param playerWidthY is the length of the player on the y coordinate
    //@return boolean that is true when not colliding with a wall
    boolean checkCollision(int playerX, int playerY, int playerWidthX, int playerWidthY) {
        //Uses a nested if for readability
        //Could be combined to a single if
        //This if statement checks the X
        if (playerX > (this.x-playerWidthX) && playerX < (this.x + this.sizeX)) {
            //This if statement checks the Y
            if (playerY > (this.y-playerWidthY) && playerY < (this.y + this.sizeY)) {
                //Returns the direction that the player is facing
                return false;
            }
        } 
        return true;
    }

    //The redrawWall Function - Redraws the Wall
    void redrawWall() {
        rect(this.x, this.y, this.sizeX, this.sizeY);
    }
}
//--- END OF WallRect CLASS ---//
