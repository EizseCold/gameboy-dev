#include <gb/gb.h>
#include <stdio.h>

INT16 playerlocation[2]; 
INT16 TimePerClock = 750;
uint8_t lastState = J_DOWN;




unsigned char SnakeSegmentSprite[] =
{
  0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,
  0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
};

typedef struct snakeSeg {
    INT16 location[2];
    struct Snake *nextSnakeSeg;
} Snake;

typedef struct snakeHead {
    INT16 location[2];
    struct Snake *nextSnakeSeg;
} SnakeHead;

uint8_t move() 
{
    uint8_t input = joypad();

   // if((input > J_RIGHT ) && (input < (J_LEFT | J_RIGHT | J_UP | J_DOWN))) input = lastState;

    if(input == J_LEFT){
        playerlocation[0] = playerlocation[0] - 10;
        move_sprite(0,playerlocation[0],playerlocation[1]);
        return J_LEFT;
    }
    if(input == J_RIGHT){
        playerlocation[0] = playerlocation[0] + 10;
        move_sprite(0,playerlocation[0],playerlocation[1]);
        return J_RIGHT;
    }
    if(input == J_UP){
        playerlocation[1] = playerlocation[1] - 10;
        move_sprite(0,playerlocation[0],playerlocation[1]);
        return J_UP;
    }
    if(input == J_DOWN){
        playerlocation[1] = playerlocation[1] + 10;
        move_sprite(0,playerlocation[0],playerlocation[1]);
        return J_DOWN;
    }
    return J_DOWN;
}

void updateSnake() 
{

}
void checkState()
{

}




void main(){
    set_sprite_data(0, 8, SnakeSegmentSprite);

    set_sprite_tile(0,0);

    playerlocation[0] = 10;

    move_sprite(0,playerlocation[0],playerlocation[1]);

    DISPLAY_ON;						// Turn on the display
    SHOW_SPRITES;

    while(1){
        delay((TimePerClock-1));
        lastState = move();
        updateSnake();
        checkState();
    }
}