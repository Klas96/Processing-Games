var y =0;
var k=1;
var x=0;
var move = 0;
var bollstandard = 200;
var hopphöjd = -62;
var grass = getImage("cute/GrassBlock");
var xCloud = 0;

var rektangel = function(xposition,yposition,rektbredd,rektlangd,rotera){
    fill(17, 219, 24);
  rect(xposition+move,yposition,rektbredd,rektlangd);
  if(((200+x)>xposition+move) && ((xposition+rektbredd+move)>(200+x))&&((yposition)<(bollstandard-y+35/2))&&k<0){
      bollstandard = yposition-rektlangd-35/2;
      k=1;
      y=hopphöjd;
      println(yposition);
      println(bollstandard-y+35/2);
   
  }
  //clouds
    noStroke();
        fill(255, 255, 255);
        ellipse(xCloud + 10, 100,115,55);
        ellipse(xCloud + 17, 96,62,27);
        ellipse(xCloud + 9,80,50,35);
        ellipse(xCloud + 300,80,43,30);
        ellipse(xCloud + 317,67,70,50);
        ellipse(xCloud + 347,77,80,30);
        xCloud++;
        if (xCloud > 500){xCloud = -400; }
};

draw = function() {
    move-=1;
    image(grass,0,200,50,50);
    background(33, 122, 255);
    //rect(0,200+62+35/2,415,159);
    rektangel(376,237,100,60,0);
    
    fill(255, 0, 0);
    stroke(0,0,0);
     ellipse(200+x, bollstandard-y, 35, 35);
     y = y+k;
     for(var flytta = 0; 20>flytta; flytta++)
    {image(grass,92*flytta,207,93,244);
    
    }
     if(y>0){
         k-=1;
         
     }
     if(y<hopphöjd){
         k=k+2;
        
     }
    if (keyIsPressed && keyCode === LEFT) {
       x=x-3;
    }
     if (keyIsPressed && keyCode === RIGHT) {
       x=x+3;    }
};
