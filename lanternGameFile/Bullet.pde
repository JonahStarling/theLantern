//The Bullet Class
//Creates a Bullet Object that the Player can shoot at Enemies
//Functions include Constructors, Mutators, Accessors, and Others
class Bullet {
    //Variables for the Bullet Object/Class
    float x;
    float y;
    int direction;
    boolean active;
    int type;
    
    //The Bullet Constructor - Creates a Bullet Object
    //@param x is the x location of the top left corner of the Bullet
    //@param y is the y location of the top left corner of the Bullet
    //@param direction is which way the player is currently facing
    Bullet(float x, float y, int direction) {
        this.x = x;
        this.y = y;
        this.direction = direction;
        this.active = true;
        this.type = 1;
        redrawBullet();
    }  
    
    //The Bullet Constructor - Creates a Bullet Object
    //@param x is the x location of the top left corner of the Bullet
    //@param y is the y location of the top left corner of the Bullet
    //@param direction is which way the player is currently facing
    Bullet(float x, float y, int direction, int type) {
        this.x = x;
        this.y = y;
        this.direction = direction;
        this.active = true;
        this.type = type;
        redrawBullet();
    } 
    
    //The moveY Function - Moves the Y coordinate of the Bulelt
    //@param distToMove is how far the bullet will move
    void moveY(float distToMove) {
        this.y += distToMove;    
    }
    
    //The getY Function - Gives the Y coordinate of the Bullet
    //@returns the Y location of the Bullet
    float getY() {
        return this.y;
    }
    
    //The moveX Function - Moves the X coordinate of the Bullet
    //@param distToMove is how far the bullet will move
    void moveX(float distToMove) {
        this.x += distToMove;    
    }
    
    //The getX Function - Gives the X coordinate of the Bullet
    //@returns the X location of the Bullet
    float getX() {
        return this.x;
    }
    
    //The redrawBullet Function - Redraws the Bullet Object
    void redrawBullet() {
        fill(#00FF00);
        rect(this.x, this.y, 3, 3);   
    }
    
    //The shootBullet Function - Moves the Bullet
    void shootBullet() {
        if (this.direction == 1) {
            moveY(-(4.0/this.type));
        } else if (this.direction == 2) {
            moveX(-(4.0/this.type));
        } else if (this.direction == 3) {
            moveY(4.0/this.type);
        } else {
            moveX(4.0/this.type);
        }
        redrawBullet();
    }
    
    //The checkActive Function - Sees if the Bullet is still on the map
    void checkActive() {
        if (this.x > 200 || this.x < 0 || this.y > 200 || this.y < 0) {
            this.active = false;
        }   
    }
    
    //The getActive Function - Says whether or not the bullet is active
    //@returns if the bullet is active
    boolean getActive() {
        return this.active;   
    }
    
    //The setActive Function - Changes the active to whatever the parameter is
    //@param active is whether or not the bullet should still be active
    void setActive(boolean active) {
        this.active = active;   
    }
    
    //The getType Function - Says what type the bullet is
    //@returns type of the bullet (1 normal human, 2 normal enemy, ect.)
    int getType() {
        return this.type;   
    }
    
    //The setType Function - Changes what type the bullet is
    //@param type of the bullet (1 normal human, 2 normal enemy, ect.)
    void setType(int type) {
        this.type = type;   
    }
}
//--- END OF Bullet CLASS ---//