import java.util.Random;

//Creating variables and objects to be used in game
int i, x, y, isGameOver, level;
Coin coin001;
Enemy enemy001;
Player player001;
Bullet bullet001;
ArrayList<WallRect> walls;
ArrayList<Bullet> bullets;
ArrayList<Enemy> enemies;
ArrayList<Coin> coins;

void setup() {
    //Setting up the settings
    size(200, 200);
    frameRate(8);
    noCursor();
    level = 1;
    //Drawing the Player
    player001 = new Player(0,0,10,10,0);
    generateNewLevel(level);
    isGameOver = 0;
    x = player001.getX();
    y = player001.getY();
    bullets = new ArrayList<Bullet>();
    bullets.add(new Bullet(x+4.5,y+4.5,1));
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
                if (checkAllCollisions(x, y, 1, 0) != 1) {
                    player001.moveY(-10);
                    player001.changeDirection(1);
                }
            } else if (key == 'a') {
                if (checkAllCollisions(x, y, 2, 0) != 2) {
                    player001.moveX(-10);
                    player001.changeDirection(2);
                }
            } else if (key == 's') {
                if (checkAllCollisions(x, y, 3, 0) != 3) {
                    player001.moveY(10);
                    player001.changeDirection(3);
                }
            } else if (key == 'd') {
                if (checkAllCollisions(x, y, 4, 0) != 4) {
                    player001.moveX(10);
                    player001.changeDirection(4);
                }
                //Jump key presses
            } else if (key == 'i') {
                if (checkAllCollisions(x, y, 5, 0) != 5) {
                    player001.moveY(-20);
                    player001.changeDirection(1);
                }
            } else if (key == 'j') {
                if (checkAllCollisions(x, y, 6, 0) != 6) {
                    player001.moveX(-20);
                    player001.changeDirection(2);
                }
            } else if (key == 'k') {
                if (checkAllCollisions(x, y, 7, 0) != 7) {
                    player001.moveY(20);
                    player001.changeDirection(3);
                }
            } else if (key == 'l') {
                if (checkAllCollisions(x, y, 8, 0) != 8) {
                    player001.moveX(20);
                    player001.changeDirection(4);
                }
            } else if (key == ' ') {
                bullets.add(new Bullet(x+4.5,y+4.5,player001.getDirection()));
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
        } 
        //Refreshing the board
        fill(#0000FF);
        refreshBoard();
        //Redrawing the player
        player001.redrawPlayer();
        //This allows the Enemy to move only once every 4 frames (twice a second)
        if (i == 4) {
            for (int i = 0; i < enemies.size(); i++) {
                enemies.get(i).moveTowardsPlayer(x, y);   
            }
            i = 0;
        } else {
            for (int i = 0; i < enemies.size(); i++) {
                enemies.get(i).redrawEnemy();   
            }
        }
        i++;
        
    } else if (isGameOver == 1) {
        //The game has been won
        //This is a delay timer
        //It pauses for 3 seconds
        int m = millis();
        while(millis() < m+3000);
        //Generating a new level
        level++;
        println(level);
        generateNewLevel(level);
        //Reset the value
        isGameOver = 0;   
    }
    //Checks to make sure the game isn't already over
    if (isGameOver != 2) {
        //Checking on the coins
        for (int i = 0; i < coins.size(); i++) {
            //Checks if the coins have been picked up
            if (!coins.get(i).found && coins.get(i).pickedUp(x, y, 10, 10)) {
                player001.addCoins(1);
            }
        }
        //Checks if the game is over and stores its value
        isGameOver = checkGameOver(player001);   
    }
    for (int i = 0; i < bullets.size(); i++) {
        if (bullets.get(i).getActive()) {
            bullets.get(i).shootBullet();
        }
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
    //Redrawing the horizontal lines
    for (int i = 10; i != 200; i+=10) {
        line(i, 0, i, 200);
    }
    //Redrawing the vertical lines
    for (int i = 10; i != 200; i+=10) {
        line(0, i, 200, i);
    }
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
int checkAllCollisions(int x, int y, int direction, int noCollision) {
    int collision = noCollision;
    //Updates the movement values to see whether the step you want to take is ok
    switch(direction) {
        //Normal stepping
    case 1: 
        y -= 9; 
        break;
    case 2: 
        x -= 9;
        break;
    case 3: 
        y += 9;
        break;
    case 4: 
        x += 9;
        break;
        //Jumping
    case 5: 
        y -= 20;
        break;
    case 6: 
        x -= 20;
        break;
    case 7: 
        y += 20;
        break;
    case 8: 
        x += 20;
        break;
    }
    //Loops through the walls to get the collision
    for (int i = 0; i < walls.size (); i++) {
        if (!walls.get(i).checkCollision(x, y, 10, 10)) {
            collision = direction;
        }
    }
    //Checks collision with the boundaries
    if (x < 0) {
        collision = direction;
    } else if (y < 0) {
        collision = direction;
    } else if (x > 190) {
        collision = direction;
    } else if (y > 190) {
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
        if (player001.getX() == enemies.get(i).getX()) {
            if (player001.getY() == enemies.get(i).getY()) { 
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
    for (int i = 10; i != 200; i+=10) {
        line(i, 0, i, 200);
    }
    for (int i = 10; i != 200; i+=10) {
        line(0, i, 200, i);
    }
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
        enemies.add(new Enemy(randInt(30, 190, 10), randInt(30, 190, 10)));
    }
    //Resetting the player back to the start
    player001.setX(0);
    player001.setY(0);
    player001.redrawPlayer();
    i = 0;
}
