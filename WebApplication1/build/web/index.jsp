<%-- 
    Document   : index
    Created on : Apr 4, 2010, 6:46:57 PM
    Author     : Dan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<HTML>
<HEAD>
<SCRIPT TYPE="text/javascript">
        var xA=new Array();
        var yA=new Array();
        var sA=new Array();
        var aA=new Array();
        var timerArray;
        var galleryarray=new Array("images/google.png","images/facebook.png","images/myspace.png","images/youtube.png","images/newegg.png","images/btjunkie.png","images/craigslist.png","images/imageshack.png","images/imageshack.png","images/imageshack.png");
        var gallery_width = 600;
        var gallery_height = 200;
	var image_width = 209;
	var image_height = 132;
	var myImagesTotal = galleryarray.length;
	var x_spacing = parseInt((gallery_width - image_width)/2);
	var y_spacing = parseInt((gallery_height - image_height)/2);
	var x_movement = parseInt(image_width*0.4);
	var y_movement = parseInt(image_height*0.2);
        function init(){
            var ni = document.getElementById('container');
            var i=0;
            for (i=0;i<galleryarray.length;i++)
            {
		var newdiv = document.createElement('div');
		newdiv.setAttribute('id',i);
		newdiv.style.position = "absolute";
		newdiv.style.left = i*10 + 'px';
                newdiv.style.top = '10px';
                newdiv.style.width = image_width + 'px';
                newdiv.style.height = image_height + 'px';
                newdiv.style.opacity = 1;
		newdiv.innerHTML = '<IMG ID=\"i'+ i +'\" onClick=\"changeIndex('+ i +');\" SRC=\"' + galleryarray[i] + '\">';
		ni.appendChild(newdiv);
                document.getElementById("i" + i).style.width = image_width + 'px';
                document.getElementById("i" + i).style.height = image_height + 'px';
            }
            updateIndex();
            window.setInterval("animate();",50);
        }
        document.onkeydown = checkKey;
	function checkKey(){
    		var keyc = window.event.keyCode;
   		if(keyc == 37){pIndex -= 1;}
                if(keyc == 39){pIndex += 1;}
                if(pIndex < 0){pIndex = myImagesTotal - 1;}
                if(pIndex > myImagesTotal - 1){pIndex=0;}
                updateIndex();
                window.setinterval("animate();",50);
	}
        function changeIndex(p){
	pIndex = p;
	updateIndex();
        }
        var pIndex = 4;
        function moveEm(i,x,y,scl,a){
            xA[i] = x;
            yA[i] = y;
            sA[i] = scl;
            aA[i] = a;
        }
        function animate(){
            var i=0;
            var x,y,scl,a,scldW,scldH,imgH,imgW,divL,divT,difL,difT,difH,difW;
                for (i=0;i<galleryarray.length;i++)
                {
                    x = xA[i];
                    y = yA[i];
                    scl = sA[i];
                    a = aA[i];
                    scldW = parseInt(image_width*scl);
                    scldH = parseInt(image_height*scl);
                    tmpDiv = document.getElementById(i);
                    tmpImg = document.getElementById("i" + i);
                    imgH = parseInt(tmpImg.style.height);
                    imgW = parseInt(tmpImg.style.width);
                    difW = parseInt(Math.abs(imgW - scldW)*.3);
                    difH = parseInt(Math.abs(imgH - scldH)*.3);
                    divL = parseInt(tmpDiv.style.left);
                    divT = parseInt(tmpDiv.style.top);
                    difL = parseInt(Math.abs(divL - x)*.3);
                    difT = parseInt(Math.abs(divT - y)*.3);
                    if(imgW != scldW || imgH != scldH || divL != x || divT != y){
                        if(imgW < scldW){tmpImg.style.width = scldW + difW + 'px';}else if(imgW > scldW){tmpImg.style.width = imgW - difW + 'px';}
                        if(imgH < scldH){tmpImg.style.height = scldH + difH + 'px';}else if(imgH > scldH){tmpImg.style.height = imgH - difH + 'px';}
                        if(divL < x){tmpDiv.style.left = divL + difL + 'px';} else if(divL > x){tmpDiv.style.left = divL - difL + 'px';}
                        if(divT < y){tmpDiv.style.top = divT + difT + 'px';} else if(divT > y){tmpDiv.style.top = divT - difT + 'px';}
                        if(parseFloat(tmpDiv.style.opacity) < a){tmpDiv.style.opacity = parseFloat(tmpDiv.style.opacity) + 0.1;} else if (parseFloat(tmpDiv.style.opacity) > a){tmpDiv.style.opacity = parseFloat(tmpDiv.style.opacity) - 0.1;}
                    }
                    tmpDiv.style.width = imgW + 'px';
                    tmpDiv.style.height = imgH + 'px';
                }
        }
        function updateIndex(){
	//set center object
	document.getElementById(pIndex).style.zIndex = myImagesTotal;
	moveEm(pIndex,x_spacing,y_spacing,1,1);
        
	var tIndex = pIndex - 1;
	var dist = 0; //dist from center
	dist = 1;
	while(dist < parseInt(myImagesTotal/2)+1){
		if(tIndex < 0){
			tIndex = myImagesTotal - 1;
		}
		document.getElementById(tIndex).style.zIndex = myImagesTotal - dist;
		moveEm(tIndex,x_spacing-(x_movement*dist*.5),y_spacing + y_movement*dist*0.25,(7 - dist)/10,1 - dist/10);
		tIndex-=1;
		dist+=1;
	}
	//set temp index to one more than center and cycle through rest + animate
	tIndex = pIndex + 1;
	dist = 1;
	while(dist < parseInt(myImagesTotal/2)){
		if(tIndex > myImagesTotal - 1){
			tIndex = 0;
		}
		document.getElementById(tIndex).style.zIndex = myImagesTotal - dist;
		moveEm(tIndex,x_spacing+(x_movement*dist*.8)+(image_width*.4*(7 - dist)/10),y_spacing + y_movement*dist*0.25,(7 - dist)/10,1 - dist/10);
		tIndex+=1;
		dist+=1;
	}
        if(myImagesTotal%2 == 0){
            var half = myImagesTotal/2;
            if(pIndex >= half){tIndex = pIndex-half;}
            else{tIndex = pIndex+half;}
            moveEm(tIndex,x_spacing + image_width*((7 - half)/10),y_spacing+ image_height*((7 - half)/10),(7 - half)/10,1 - half/10);
        }
}
</SCRIPT>
</HEAD>
<BODY onLoad="init();">
<DIV ID="container" STYLE="background-color:#000000; height:200px; width:600px; position:relative;"></DIV>
<FORM action="">
<INPUT type="button" value="Update" name="button1" onClick="updateIndex();">
</FORM>
</BODY>
</HTML>