var selectedColor = App.selectedColor;
var unselectedColor = App.unselectedColor;
var cellWidth = App.width;
var cellHeight = App.height;
var startTouchX = 0;
var startTouchY = 0;
var isSelectingCells = true;
var coords = [];

// Connecting to websocket
var dispatcher = new WebSocketRails('localhost:3000/websocket');
var channel = dispatcher.subscribe('schedule');

channel.bind('update', function(data) {
  var newUpdate = $.parseJSON(data);
  //console.log('Cols: '+newUpdate.cols+', Rows: '+newUpdate.rows+', Data:'+newUpdate.data);
  //console.log(newUpdate);
  //console.log(newUpdate.event_id);
  //console.log(event_id);
  if (newUpdate.event_id == event_id) {
    var maxInterestVal = 0;
    var max = 0;
    for (var c=0; c<cols; c++)
    {
    	for (var r=0; r<=rows; r++)
      {
  	  //if (newUpdate.data[r][c] > maxInterestVal)
  	  if (newUpdate.data[c][r] > maxInterestVal)
        {
  		//max = newUpdate.data[r][c];
  		maxInterestVal = newUpdate.data[c][r];
        }
      }
    }

    var minNumberOfBlocks = 3;
    var percentageOfPpl = 0.40;
    var bestTimes = []
    var blockCounter = 0;

    // Update the UI to reflect the interest level
    for (var c=0; c<cols; c++) // For every column (there is 5 columns)
    {
      blockCounter = 0; // Reset the counter to 0
      for (var r=0; r<=rows; r++) // For every row (there is 5 rows)
      {
        $("#interestCell"+r+""+c).css("border-width", "2px"); // reset the style
        $("#interestCell"+r+""+c).css("border-color", "white"); // reset the style
  	    //$("#interestCell"+r+""+c).css("opacity", newUpdate.data[r][c]/maxInterestVal); // change the opacity
  	    $("#interestCell"+r+""+c).css("opacity", newUpdate.data[c][r]/maxInterestVal); // change the opacity

        // Storing the interested values for bestTimes
  	  //if (newUpdate.data[r][c]/maxInterestVal > percentageOfPpl)
  	  if (newUpdate.data[c][r]/maxInterestVal > percentageOfPpl)
	  {
		  blockCounter = blockCounter + 1;
			if (r == rows ) // Last row
			{
			 if (blockCounter >= minNumberOfBlocks)
			 {
				 bestTimes.push([c,r-blockCounter+1, r]); // Add to the bestTimes
			   }
			 }
		   } else {
			if (blockCounter >= minNumberOfBlocks)
			{
			  bestTimes.push([c,r-blockCounter, r-1]); // Add to the bestTimes
			}
			blockCounter = 0;
		  }
        }
      }
	  console.log('@'+bestTimes);


    // Color the interested cells using bestTimes
    for (var i=0; i<bestTimes.length; i++) // For every bestTime
    {
      for (var j=0; j<=bestTimes[i][2]; j++) // For each cell in the bestTime
      {
        c = bestTimes[i][0];
        r = bestTimes[i][1]+j;
        $("#interestCell"+r+""+c).css("border-width", "5px");
        $("#interestCell"+r+""+c).css("border-color", "red");
      }
    }
    //console.log("finished")
    }
});


function touchStart( e ) {
  var elemId = e.currentTarget.id;
  // var box = document.getElementById(elemId);
  //
  coords = [];
  //var saveVar = "("+$("#"+elemId).attr("data_row")+","+$("#"+elemId).attr("data_col")+")";
  var saveVar = [
  eventDates[Number($("#"+elemId).attr("data_col"))],
  Number($("#"+elemId).attr("data_row"))+s_offset
  ];

  coords.push(saveVar);



  if ($("#"+elemId ).attr("data_isSelected") == 1)
  {
    isSelectingCells = false;
    $("#"+elemId).attr("data_isSelected",0);
    $("#"+elemId).css("background-color", unselectedColor);
  }
  else
  {
    isSelectingCells = true;
    $("#"+elemId).attr("data_isSelected",1);
    $("#"+elemId).css("background-color", selectedColor);
  }

  //console.log("Start Touch - screenX:"+ e.targetTouches[0].pageX + ", screenY:"+e.targetTouches[0].pageY);

  startTouchX = e.targetTouches[0].pageX;
  startTouchY = e.targetTouches[0].pageY;

  e.preventDefault();
  return false;
}

function touchMove( e ) {
  var elemId = e.currentTarget.id;
  var box = document.getElementById(elemId);
  var cur_col = parseInt(box.getAttribute("data_col"));
  var cur_row = parseInt(box.getAttribute("data_row"));
  var cellCols = Math.floor((e.targetTouches[0].pageX - startTouchX + cellWidth/2)/cellWidth);
  var cellRows = Math.floor((e.targetTouches[0].pageY - startTouchY+ cellHeight/2)/cellHeight);

  //console.log("Move Touch - screenX:"+ e.targetTouches[0].pageX + ", screenY:"+e.targetTouches[0].pageY);
  //console.log("Move Touch - cellCols:"+ cellCols +", cellRows:"+cellRows);

  var colSign = 1;
  var rowSign = 1;

  if (cellCols < 0)
  {
    colSign = -1;
  }

  if (cellRows < 0)
  {
    rowSign = -1;
  }

  // Change the UI
  for (var x=0; x<=Math.abs(cellCols); x++)
  {
    for (var y=0; y<=Math.abs(cellRows); y++)
    {
      row = cur_row+rowSign*y;
      col = cur_col+colSign*x;
      var selectedBox = document.getElementById("cell"+row+""+col);
      if (selectedBox !== null && $(selectedBox ).attr("data_isSelected") != isSelectingCells)
      {
        //var saveVar = "("+row+","+col+")";
        var saveVar = [
        eventDates[col],
        row + s_offset
        ];
        if ($.inArray(saveVar, coords) === -1)
        {
          coords.push(saveVar);
        }

        if (isSelectingCells)
        {
          selectedBox.style.background = selectedColor;
          $(selectedBox ).attr("data_isSelected",1);
        }
        else
        {
          selectedBox.style.background = unselectedColor;
          $(selectedBox).attr("data_isSelected",0);
        }
      }
    }
  }
}

function touchEnd( e ) {
  var resultData = {
  token: getUrlVars()["token"],
  coordinates: coords,
  isSelecting: isSelectingCells,
  event: {
	  dates_id: eventDates,
	  s_time: s_time,
	  e_time: e_time
  }
};

  // Do ajax post
  //$.post('/newTime', resultData, function(data) {
  //console.log(resultData);

  //$.post('http://0.0.0.0:3000/newTime', resultData, function(data) {

  //$.post('http://0.0.0.0:3000/newTime', {name:"date", val:3}, function(data) {
      //console.log("Success log:");
      //console.log(data);
      //}, "json");


$.ajax({
  type: 'POST',
  contentType: "application/json",
  url: '/newTime',
  data: JSON.stringify(resultData),
  dataType: "json",

  success: function(data) {
    console.log("Success log:");
    console.log(data);
    $('.saved').css('visibility', 'visible');
    setTimeout(function() {
      $('.saved').css('visibility', 'hidden');
    }, 3000);
  }
});


e.preventDefault();
return false;
}

function getUrlVars() {
  var vars = {};
  var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
    vars[key] = value;
  });
  return vars;
}

