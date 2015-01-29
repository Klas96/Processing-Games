var h = 0;
var k = 0;
var x = 0;
var bredd = 0;
var move = 0;

var GameOver = function(recX,recY,recBredd,recLangd){
    rect(recX-move,recY,recBredd,recLangd);
    if(recX-move<mouseX+50+bredd<recX-move+recBredd && recY < 275-h+50+bredd <recLangd){
        println("GAME OVER");
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
    keyPressed = function() {
        h = h+20;
        bredd += 5;
        k++;
        
    };
    if (h<0){h = 0;}
    
    //gravety
    h = h -1;
    bredd -= 0.3;
    if (bredd<0){
        bredd = 0;
    }
    //Blobb
    fill(252, 0, 252);
    ellipse(mouseX, 275-h,50+bredd,50+bredd);
    fill(0,0,0);
    ellipse(mouseX+10,284-h,20,13);
    ellipse(mouseX-10,284-h,20,10);
    ellipse(mouseX+13,271-h,10,10);
    fill(173, 0, 0);
    ellipse(mouseX+-11,271-h,10,10);
    noStroke();
    //rect(mouseX-34,249-h,69,7);
    //rect(mouseX-24,206-h,49,42);
    //stage
    stroke(0, 0, 0);
    fill(255, 0, 0);
    //rect(434 - move,246,40,53);
    GameOver(434,246,40,53);
    if (434 - move === mouseX){println("dffGAME_OVER");
        
    }
    if (246 === 275-h && 434 - move === mouseX){println("GAME_OVER");
        
    }
    rect(556 - move,108,67,84);
    move++;
    
};
