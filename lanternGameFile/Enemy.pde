//The Enemy Class
//Creates and Enemy AI object to interact with
//Functions include two constructors, movement, and redraw
class Enemy {
    //Variables for the Enemy Object/Class
    private float x;
    private float y;
    private float speed;
    private int health;
    private int type;

    //The Basic Enemy Constructor - Creates an Enemy object with default speed
    //@param x is the x location of the Enemy Object
    //@param y is the y location of the Enemy Object
    Enemy(float x, float y) {
        this.x = x;
        this.y = y;
        //Loops through all of the walls
        for (int i = 0; i < walls.size (); i++) {
            //Checks to see if the enemy is stuck in a wall
            if (!walls.get(i).checkCollision(this.x, this.y, 5, 5)) {
                //If so then when change its location and try again
                this.x = randInt(0, 780, 20);
                this.y = randInt(0, 780, 20);
                i = 0;
            }
        }
        this.speed = 10;
        this.health = 1;
        this.type = 1;
        redrawEnemy();
    }

    //The Speed Enemy Constructor - Creates an Enemy object with custom speed
    //@param x is the x location of the Enemy Object
    //@param y is the y location of the Enemy Object
    //@param speed is how fast the Enemy Object moves
    Enemy(float x, float y, float speed) {
        this.x = x;
        this.y = y;
        //Loops through all of the walls
        for (int i = 0; i < walls.size (); i++) {
            //Checks to see if the enemy is stuck in a wall
            if (!walls.get(i).checkCollision(this.x, this.y, 5, 5)) {
                //If so then when change its location and try again
                this.x = randInt(0, 780, 20);
                this.y = randInt(0, 780, 20);
                i = 0;
            }
        }
        this.speed = speed;
        this.health = 1;
        this.type = 1;
        redrawEnemy();
    }
    
    //The Health Enemy Constructor - Creates an Enemy object with a set health
    //@param x is the x location of the Enemy Object
    //@param y is the y location of the Enemy Object
    //@param speed is how fast the Enemy Object moves
    //@param health is how many bullets it takes to kill the Enemy
    Enemy(float x, float y, float speed, int health) {
        this.x = x;
        this.y = y;
        //Loops through all of the walls
        for (int i = 0; i < walls.size (); i++) {
            //Checks to see if the enemy is stuck in a wall
            if (!walls.get(i).checkCollision(this.x, this.y, 20, 20)) {
                //If so then when change its location and try again
                this.x = randInt(0, 780, 20);
                this.y = randInt(0, 780, 20);
                i = 0;
            }
        }
        this.speed = speed;
        if (health > 10) {
            this.health = 10;
        } else {
            this.health = health;
        }
        this.type = 1;
        redrawEnemy();
    }
    
    //The Health Enemy Constructor - Creates an Enemy object with a set health
    //@param x is the x location of the Enemy Object
    //@param y is the y location of the Enemy Object
    //@param speed is how fast the Enemy Object moves
    //@param health is how many bullets it takes to kill the Enemy
    //@param type determines what type of enemy it is (Normal, Shooting, etc.)
    Enemy(float x, float y, float speed, int health, int type) {
        this.x = x;
        this.y = y;
        //Loops through all of the walls
        for (int i = 0; i < walls.size (); i++) {
            //Checks to see if the enemy is stuck in a wall
            if (!walls.get(i).checkCollision(this.x, this.y, 20, 20)) {
                //If so then when change its location and try again
                this.x = randInt(0, 780, 20);
                this.y = randInt(0, 780, 20);
                i = 0;
            }
        }
        this.speed = speed;
        if (health > 10) {
            this.health = 10;
        } else {
            this.health = health;
        }
        this.type = type;
        redrawEnemy();
    }

    //The redrawEnemy Function - Redraws the Enemy
    void redrawEnemy() {
        if (this.type == 1) {
            fill(#FF0000);
        } else if (this.type == 2) {
            fill(#FF00FF);
        } else {
            fill(#FFFFFF);
        }
        rect(this.x, this.y, 20, 20);
    }

    //The moveTowardsPlayer Function - Decides where the enemy AI should move next
    //@param playerX is the x location of the player
    //@param playerY is the y location of the player
    void moveTowardsPlayer(float playerX, float playerY) {
        //Finds the difference between the player's location and its own
        float diffX = playerX - this.x;
        float diffY = playerY - this.y;
        //Finds out which difference is bigger
        if (abs(diffX) > abs(diffY)) {
            //If the diffX is positive then the player is to the right
            if (diffX > 0) {
                //Before we move we check the collisions
                if (checkAllCollisions(this.x, this.y, 4, 0) != 4) {
                    this.x += (speed/20);
                }
                //If the diffX is negative then the player is to the left
            } else {
                //Before we move we check the collisions
                if (checkAllCollisions(this.x, this.y, 2, 0) != 2) {
                    this.x -= (speed/20);
                }
            }
        } else {
            //If the diffY is positive then the player is below
            if (diffY > 0) {
                //Before we move we check the collisions
                if (checkAllCollisions(this.x, this.y, 3, 0) != 3) {
                    this.y += (speed/20);
                }
                //If the diffY is negative then the player is above
            } else {
                //Before we move we check the collsions
                if (checkAllCollisions(this.x, this.y, 1, 0) != 1) {
                    this.y -= (speed/20);
                }
            }
        }
        //Then we redraw the Enemy AI
        redrawEnemy();
    }
    
    //The checkHit Function - Checks if the enemy was hit by a bullet
    //@param playerX is the x coordinate of the top left corner of the player
    //@param playerY is the y coordinate of the top left corner of the player
    //@param playerWidthX is the length of the player on the x coordinate
    //@param playerWidthY is the length of the player on the y coordinate
    //@return boolean that is true when not colliding with a wall
    boolean checkHit(float playerX, float playerY, int playerWidthX, int playerWidthY) {
        //Uses a nested if for readability
        //Could be combined to a single if
        //This if statement checks the X
        if (playerX >= (this.x-playerWidthX) && playerX <= (this.x + 20)) {
            //This if statement checks the Y
            if (playerY >= (this.y-playerWidthY) && playerY <= (this.y + 20)) {
                //Returns the direction that the player is facing
                if (this.health != 0) {
                    this.health--;
                }
                return false;
            }
        } 
        return true;
    }
    
    //The checkAlive Function - Sees if the player is alive
    //@returns true if the enemy's health is not equal to zero
    boolean checkAlive() {
        if (this.health == 0) {
            return false;
        } else {
            return true;   
        }
    }
    
    //The getX Function - Gives the X coordinate of the Enemy
    //@returns the X location of the Enemy
    float getX() {
        return this.x;
    }
    
    //The moveX Function - Moves the X coordinate of the Enemy
    //@param distToMove is how far the enemy will move
    void moveX(float distToMove) {
        this.x += distToMove;    
    }

    //The getY Function - Gives the Y coordinate of the Enemy
    //@returns the Y location of the Enemy
    float getY() {
        return this.y;
    }
    
    //The moveY Function - Moves the Y coordinate of the Enemy
    //@param distToMove is how far the enemy will move
    void moveY(float distToMove) {
        this.y += distToMove;    
    }
    
    //The getHealth Function - Returns to the user the Enemy health
    //@returns the current health of the Enemy Object
    int getHealth() {
        return this.health;   
    }
    
    //The setHealth Function - Sets the health of an Enemy Object
    //@param health is the new health of the Enemy Object
    void setHealth(int health) {
         this.health = health;   
    }
    
    //The getSpeed Function - Returns to the user the Enemy speed
    //@returns the current speed of the Enemy Object
    float getSpeed() {
        return this.speed;   
    }
    
    //The setSpeed Function - Sets the speed of an Enemy Object
    //@param speed is the new speed of the Enemy Object
    void setSpeed(float speed) {
         this.speed = speed;   
    }
    
    //The getType Function - Returns to the user the Enemy type
    //@returns the current type of the Enemy Object
    int getType() {
        return this.type;   
    }
    
    //The setType Function - Sets the type of an Enemy Object
    //@param type is the new type of the Enemy Object
    void setType(int type) {
         this.type = type;   
    }
}
//--- END OF Enemy CLASS ---//