import java.util.Random;

//Creating variables and objects to be used in game
int i, isGameOver, level, badDirection;
float x, y;
Coin coin001;
Enemy enemy001;
Player player001;
Lantern lantern;
Bullet bullet001;
ArrayList<WallRect> walls;
ArrayList<Bullet> bullets;
ArrayList<Enemy> enemies;
ArrayList<Coin> coins;

void setup() {
    //Setting up the settings
    size(200, 200);
    frameRate(60);
    noCursor();
    level = 1;
    //Drawing the Player
    player001 = new Player(0,0,5,5,0);
    lantern = new Lantern(player001.getX(), player001.getY(), 20, 20);
    generateNewLevel(level);
    isGameOver = 0;
    x = player001.getX();

    bullets = new ArrayList<Bullet>();
    badDirection = 0;
}


//The draw Function - This loop is like the main
//Built in with processing
//It is run however many times frames per second is set to
void draw() {
    //Checks the status of the game
    if (isGameOver == 0) {
        //Gets location of player
        x = player001.getX();
        y = player001.getY();
        //Looks to see if a key is pressed then sees what key
        if (keyPressed) {
            //Normal key presses
            if (key == 'w') {
                if (badDirection != 1) {
                    player001.moveY(-1);
                    player001.changeDirection(1);
                }
            } else if (key == 'a') {
                if (badDirection != 2) {
                    player001.moveX(-1);
                    player001.changeDirection(2);
                }
            } else if (key == 's') {
                if (badDirection != 3) {
                    player001.moveY(1);
                    player001.changeDirection(3);
                }
            } else if (key == 'd') {
                if (badDirection != 4) {
                    player001.moveX(1);
                    player001.changeDirection(4);
                }
            } else if (key == ' ') {
                if (i == 10) {
                    bullets.add(new Bullet(x+2,y+2,player001.getDirection()));
                }
            } else if (key == 'q') {
                player001.rotatePlayerLeft();
            } else if (key == 'e') {
                player001.rotatePlayerRight();
            } else if (key == 'r') {
                //Pressing r will reset the game
                //Resetting the game causes you to lose all of your coins
                //It also will set you back a level
                if (level != 1) {
                    level--;
                }
                player001.subtractCoins(player001.getNumOfCoins());
                generateNewLevel(level);
            }
            //Checking if there is a collision and taking note of the current direction
            x = player001.getX();
            y = player001.getY();
            badDirection = checkAllCollisions(x, y, player001.getDirection(), 0);
        } 
        //Refreshing the board
        fill(#0000FF);
        refreshBoard();
        //Redrawing the player
        player001.redrawPlayer();
        lantern.setX(player001.getX()+2.5);
        lantern.setY(player001.getY()+2.5);
        //This allows the Enemy to move only once every 4 frames (twice a second)
        for (int i = 0; i < enemies.size(); i++) {
            enemies.get(i).moveTowardsPlayer(x, y);   
        }
        for (int i = 0; i < enemies.size(); i++) {
            enemies.get(i).redrawEnemy();   
        }
        lantern.redrawLantern();
    } else if (isGameOver == 1) {
        //The game has been won
        //This is a delay timer
        //It pauses for 3 seconds
        int m = millis();
        while(millis() < m+3000);
        //Generating a new level
        level++;
        generateNewLevel(level);
        //Reset the value
        isGameOver = 0;   
    }
    //Checks to make sure the game isn't already over
    if (isGameOver != 2) {
        //Checking on the coins
        for (int i = 0; i < coins.size(); i++) {
            //Checks if the coins have been picked up
            if (!coins.get(i).found && coins.get(i).pickedUp(x, y, 5, 5)) {
                player001.addCoins(1);
            }
        }
        //Checks if the game is over and stores its value
        isGameOver = checkGameOver(player001);   
    }
    //We check if the game is over so bullets only appear in game
    if (isGameOver == 0) {
        //Loops through the Bullets and moves them
        for (int i = 0; i < bullets.size(); i++) {
            for (int j = 0; j < walls.size(); j++) {
                if (!walls.get(j).checkCollision(bullets.get(i).getX(), bullets.get(i).getY(), 1, 1)) {
                    bullets.get(i).setActive(false);   
                    
                }
            }
            for (int j = 0; j < enemies.size(); j++) {
                if (!enemies.get(j).checkHit(bullets.get(i).getX(), bullets.get(i).getY(), 1, 1)) {
                    bullets.get(i).setActive(false);   
                    if (!enemies.get(j).checkAlive()) {
                        enemies.remove(j);   
                    }
                }
            }
            if (bullets.get(i).getActive()) {
                bullets.get(i).shootBullet();
            } else {
                bullets.remove(i);   
            }
        }
    }
    if (i < 11) {
        i++;
    } else {
        i = 0;   
    }
}



//The randInt Function - Gets a random int between max and min
//@param min is the smallest number that can be picked
//@param max is the largest number that can be picked
//@return randomNum is an integer between min and max
int randInt(int min, int max) {
    Random rand = new Random();
    int randomNum = rand.nextInt((max - min) + 1) + min;
    return randomNum;
}



//The randInt Function - Gets a random int between max and min on an interval
//Example: The parameters 11,49,10 could give you 10,20,30,40
//The bottom and top number are rounded down and inclusive of both ends
//It rounds down to the nearest number divisible by the interval
//@param min is the bottom number (may be rounded down)
//@param max is the top number (may be rounded down)
//@param interval is the number to skip by
//@return randomNum generated by the algorithm
int randInt(int min, int max, int interval) {
    Random rand = new Random();
    int randomNum = (rand.nextInt((max/interval - min/interval) + 1) + min/interval) * interval;
    return randomNum;
}



//The refreshBoard Function - Redraws the map
void refreshBoard() {
    //Redrawing the background
    fill(#888888);
    rect(0, 0, 200, 200);
    fill(#000000);
    //Redrawing the walls
    for (int i = 0; i < walls.size (); i++) {
        walls.get(i).redrawWall();
    }
    //Redrawing the coins
    for (int i = 0; i < coins.size(); i++) {
        coins.get(i).redrawCoin();   
    }
    fill(#0000FF);
}



//The checkAllCollisions Function - Checks collision with all walls and bounds
//@param x is the current x location of the player
//@param y is the current y location of the player
//@param direction is the way the player is trying to walk
//@param noCollision is the value to return if no collisions are detected
//@return collision is the direction of the collision or the noCollision default
int checkAllCollisions(float x, float y, int direction, int noCollision) {
    int collision = noCollision;
    //Updates the movement values to see whether the step you want to take is ok
    switch(direction) {
        //Normal stepping
    case 1: 
        y -= 1; 
        break;
    case 2: 
        x -= 1;
        break;
    case 3: 
        y += 1;
        break;
    case 4: 
        x += 1;
        break;
    }
    //Loops through the walls to get the collision
    for (int i = 0; i < walls.size (); i++) {
        if (!walls.get(i).checkCollision(x, y, player001.getSizeX(), player001.getSizeY())) {
            collision = direction;
        }
    }
    //Checks collision with the boundaries
    if (x < 0) {
        collision = direction;
    } else if (y < 0) {
        collision = direction;
    } else if (x > 195) {
        collision = direction;
    } else if (y > 195) {
        collision = direction;
    }
    return collision;
}

//The checkGameOver Function - Checks if the user has the coin or has died
//@param player001 is the player object that the user controls
//@return isGameOver is a 0 if no, 1 if win, 2 if loss
int checkGameOver(Player player001) {
    //This is the value we will return
    int isGameOver = 0;
    //Checks to see if the user has the coin
    boolean allCoinsFound = true;
    for (int i = 0; i < coins.size(); i++) {
        if (!coins.get(i).getFound()) {
            allCoinsFound = false;   
        }
    }
    if (allCoinsFound) {
        //Level beaten
        isGameOver = 1;   
        //Draw the Game Won Screen
        fill(#00FF00);
        rect(0,0,200,200);
        fill(#000000);
        textSize(16);
        textAlign(CENTER);
        text("YOU WIN - LEVEL UP", 100, 100);
    }
    //Loops through enemies
    for (int i = 0; i < enemies.size(); i++) {
        //Checks if the player has lost
        if (x > (enemies.get(i).getX()-player001.getSizeX()) && x < (enemies.get(i).getX() + 5)) {
            if (y > (enemies.get(i).getY()-player001.getSizeY()) && y < (enemies.get(i).getY() + 5)) { 
               //Game Loss
               isGameOver = 2;
               //Draw the Game Over Screen
               fill(#FF0000);
               rect(0,0,200,200);
               fill(#000000);
               textSize(16);
               textAlign(CENTER);
               text("GAME OVER - YOU LOSE", 100, 100);
               String scoreString = "SCORE: " + player001.getNumOfCoins();
               text(scoreString, 100, 120);
            }
        }
    }
    return isGameOver;
}

//The generateNewLevel function - Creates a new random level
//@param level is the current level the player is on
void generateNewLevel(int level) {
    //Drawing the background
    fill(#888888);
    rect(0, 0, 200, 200);
    //Creates grid lines for debugging and testing
    fill(#000000);
    //ArrayList of WallRect objects
    walls = new ArrayList<WallRect>();
    //Build the horizontal walls
    for (int i = 0; i != 5; i++) {
        walls.add(new WallRect(randInt(0, 190, 10), randInt(0, 190, 10), randInt(10, 190, 10), 10));
    }
    //Build the vertical walls
    for (int i = 0; i != 5; i++) {
        walls.add(new WallRect(randInt(0, 190, 10), randInt(0, 190, 10), 10, randInt(10, 190, 10)));
    }
    //ArrayList of Coin Objects
    coins = new ArrayList<Coin>();
    //Creating the coins to populate the ArrayList
    for (int i = 0; i != level; i++) {
        coins.add(new Coin(randInt(0, 190, 10), randInt(0, 190, 10)));
    }
    //ArrayList of Enemy Objects
    enemies = new ArrayList<Enemy>();
    //Creating the enemies to populate the ArrayList
    for (int i = 0; i != level; i++) {
        enemies.add(new Enemy(randInt(30, 190, 10), randInt(30, 190, 10),level,level));
    }
    //Resetting the player back to the start
    player001.setX(0);
    player001.setY(0);
    player001.redrawPlayer();
    i = 0;
}
