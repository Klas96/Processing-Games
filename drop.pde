          var xPositions = [45, 80, 100, 110,120,130,140,150,160,170,];
          var yPositions = [10, 10, 10, 10,10,10,10,10,10,10];
          var BlobbX = 200;
          var grass = getImage("GrassBlock.png");
          var points = 0;
          var ladda = -75;
          var laddahastihet = 1;
          var increaseCharge = 0;
          var skyColor = 0;
          var xCloud = 0;

          void setup() {
            size(900, 800);
          }

          var cloud = function(xCloudx) {
            noStroke();
            fill(255, 255, 255);
            ellipse(xCloudx + 10, 100,115,55);
            ellipse(xCloudx + 17, 96,62,27);
            ellipse(xCloudx + 9,80,50,35);
            ellipse(xCloudx + 300,80,43,30);
            ellipse(xCloudx + 317,67,70,50);
            ellipse(xCloudx + 347,77,80,30);
            xCloud++;
            if (xCloudx > 500){xCloudx = -400; }
            stroke(0, 0, 0);
          };
          
          // Add Dropp
          mouseClicked = function() {
            if(ladda>=0){
              ladda = -75;
              xPositions.push(mouseX);
              yPositions.push(10);
            }
          };


          draw = function() {
              background(0, 162, 255);

              //clouds
              for (var i = 0; i<laddahastihet; i++) {
                cloud(i*214);
              }
              
          //laddare
          fill(0, 0, 0);
          rect(350,50,25,75);
          fill(255, 0, 0);
          rect(350,50-ladda,25,75+ladda);
          fill(0, 0, 0);
          
          // Points Text
          text(points, 51, 59, 236, 275);
          
          // Blobb
          noFill();
          rect(BlobbX-25,250,50,50);
          fill(252, 0, 252);
          ellipse(BlobbX, 275, 50, 50);
          fill(0,0,0);
          ellipse(BlobbX+10,284,20,13);
          ellipse(BlobbX-10,284,20,10);
          ellipse(BlobbX+13,271,10,10);
          fill(173, 0, 0);
          ellipse(BlobbX-11,271,10,10);

          if (BlobbX<25) {
              //Blobb
              noFill();
              rect(400+BlobbX-25,250,50,50);
              fill(252, 0, 252);
              ellipse(400+BlobbX, 275, 50, 50);
              fill(0,0,0);
              ellipse(400+BlobbX+10,284,20,13);
              ellipse(400+BlobbX-10,284,20,10);
              ellipse(400+BlobbX+13,271,10,10);
              fill(173, 0, 0);
              ellipse(400+BlobbX-11,271,10,10);
          }
              
          if (BlobbX>375) {
              //Blobb
              noFill();
              rect(-400+BlobbX-25,250,50,50);
              fill(252, 0, 252);
              ellipse(-400+BlobbX, 275, 50, 50);
              fill(0,0,0);
              ellipse(-400+BlobbX+10,284,20,13);
              ellipse(-400+BlobbX-10,284,20,10);
              ellipse(-400+BlobbX+13,271,10,10);
              fill(173, 0, 0);
              ellipse(-400+BlobbX-11,271,10,10); 
          }
              
          if(BlobbX<=-25) {
              BlobbX = 375;
          }

          if(BlobbX>425){
              BlobbX = 25;
          }
              
          // Droppar som faller
          for (var i = 0; i < xPositions.length; i++) {
              fill(0, 79, 163);
              ellipse(xPositions[i], yPositions[i], 10, 10);
              yPositions[i] += 5;
              if(yPositions[i]>250 && yPositions[i]<300 && xPositions[i]<BlobbX+25 && xPositions[i]>BlobbX-25){
                  println("GAME OVER");
                  textSize(50);
                  text("points" + points, 131,130,128,125);
                  draw = 1;
              }
          }

          for (var flytta = 0; 20>flytta; flytta++){
            image(grass,92*flytta,228,93,244);
          }

          //styra
          if (keyIsPressed && keyCode === LEFT) {
              BlobbX-=2;
          }

          if(keyIsPressed && keyCode === RIGHT){
              BlobbX+=2;
          }
          
          points++;
          increaseCharge++;
          
          if (increaseCharge>1000) {
              increaseCharge = 0;
              laddahastihet++;
              println("level up");
          }

          if (ladda<0) {
            ladda += laddahastihet;
          }
        };