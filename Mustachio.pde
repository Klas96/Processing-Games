var h = 0;
var k = 0;
var x = 0;
var Level = 1;
var bredd = 0;
var move = 0;
var hastighet = 01;
var stageLength = 3400;
var points = (move + stageLength * (Level-1));


void setup() {

  size(450, 400);

}


var GameOver = function(recX,recY,recBredd,recLangd){
    rect(recX-move,recY,recBredd,recLangd);
    if(recX-move<mouseX+25-bredd/2+bredd && mouseX-25-bredd/2<recX-move+recBredd && recY < 275-25-h-bredd/2 + 50+bredd && 275-25-h-bredd/2<recY+recLangd){
        
        println("GAME OVER");
        fill(0,0,0);
        textSize(50);
        text("GAME OVER",50,50);
        text("Points "+(move+stageLength * (Level-1)),50,100);
        fill(255,0,0);
        GameOver = 1;
    }
};

draw= function() {
    background(14, 116, 204);
    //clouds
    noStroke();
        fill(255, 255, 255);
        ellipse(x + 10, 100,115,55);
        ellipse(x + 17, 96,62,27);
        ellipse(x + 9,80,50,35);
        ellipse(x + 300,80,43,30);
        ellipse(x + 317,67,70,50);
        ellipse(x + 347,77,80,30);
        x++;
        if (x > 500){x = -400; }
    stroke(0, 0, 0);
    fill(37, 224, 0);
    rect(-15,300,505,445);
    
    //Jump
    if(keyPressed){
        h = h+20;
        bredd += 3;
        k++;
    }
    
    if (h<0){
       h = 0;
    }
    
    if(275-bredd/2-h<0){
	h = 275-bredd/2;
    }
    
    //gravety
    h = h -1;
    bredd -= 0.3;
    if (bredd<0){
        bredd = 0;
    }
    //Blobb
    noFill();
    rect(mouseX-25-bredd/2,275-25-h-bredd/2,50+bredd,50+bredd);
    fill(252, 0, 252);
    ellipse(mouseX, 275-h,50+bredd,50+bredd);
    fill(0,0,0);
    ellipse(mouseX+10,284-h,20,13);
    ellipse(mouseX-10,284-h,20,10);
    ellipse(mouseX+13,271-h,10,10);
    fill(173, 0, 0);
    ellipse(mouseX+-11,271-h,10,10);
    noStroke();
    //stage
    stroke(0, 0, 0);
    fill(255, 0, 0);
    GameOver(434,246,40,53);
    GameOver(599,141,40,53);
    GameOver(770,210,40,54);
    GameOver(890,101,40,53);
    GameOver(1074,178,75,124);
    GameOver(1296,108,61,92);
    GameOver(1413,146,61,92);
    GameOver(1691,100,49,118);
    GameOver(1891,146,49,118);
    GameOver(2091,186,49,118);
    GameOver(2291,146,49,118);
    GameOver(2491,46,49,118);
    GameOver(2691,146,100,118);
    GameOver(2890,26,49,70);
    GameOver(3050,116,49,118);
    GameOver(3250,146,49,118);
    move = move + hastighet;
    if(move > stageLength){
        hastighet++;
        Level++;
        move = 0;
        println("Level " + Level);
    }
    fill(0,0,0);
    textSize(24);
    text("Points "+ (move+stageLength * (Level-1)),20,20);
    
};