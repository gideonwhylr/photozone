Tagger = function(target_id, selection_id, x_offset_id, y_offset_id, width_id, height_id, photo_id, tag_form) {	
	var tagger = this;
	tagger.isMouseDown = false;
	var wrapper = document.getElementById(target_id);
	var image = wrapper.childNodes[1];
	var feedback = wrapper.childNodes[3];

	//Set instance variables to find feedback form
	tagger.x_offset_id = x_offset_id;
	tagger.y_offset_id = y_offset_id;
	tagger.width_id = width_id;
	tagger.height_id = height_id;
	tagger.photo_id = photo_id;
	tagger.tag_form = tag_form;

	//Set attributes of tagger class
	tagger.wrapper = wrapper;
	tagger.image = image;
	tagger.image.style.position = "relative";
	tagger.feedback = feedback;

	//set feedback div css
	tagger.feedback.style.width = 0;
	tagger.feedback.style.height = 0;
	tagger.feedback.style.position = "absolute";
	tagger.feedback.style.border = "1px solid black";
	tagger.feedback.style.backgroundColor = "transparent";

	//add event listeners
	tagger.image.addEventListener("mousedown", function(event) {
		tagger.mouseDown(event)
	});
	tagger.image.addEventListener("mousemove", function(event) {
		tagger.mouseMove(event)
	});
	tagger.image.addEventListener("mouseup", function(event) {
		tagger.mouseUp(event)
	});
}

Tagger.prototype.mouseDown = function(event) {
	event.preventDefault();
	var tagger = this;
	this.oldMoveHandler = document.body.onmousemove;
	document.body.onmousemove = function(event){
		tagger.mouseMove(event);
	}
	this.oldUpHandler = document.body.onmouseup;
	document.body.onmouseup = function(event) {
		tagger.mouseUp(event);
	}

	tagger.clickX = event.pageX;
	tagger.clickY = event.pageY;

	tagger.feedback.style.left = tagger.clickX + "px";
	tagger.feedback.style.top = tagger.clickY + "px";
	tagger.feedback.style.width = 0;
	tagger.feedback.style.height = 0;
	//console.log("X: " + tagger.clickX + ", Y: " + tagger.clickY);
	tagger.isMouseDown = true;
}

Tagger.prototype.mouseMove = function(event) {
	var tagger = this;
	//console.log("Is mouse down? " + obj.isMouseDown);
	if (!tagger.isMouseDown) {
		return;
	}

	//This logic is buggy, but work with it for now. FIX LATER!
	if (event.target == tagger.image || event.target == tagger.feedback) {
		//Handeling for each of the quadrents for the selection feedback
		if(event.pageX > tagger.clickX) {
			if(event.pageY < tagger.clickY) {
				//top right quadrent
				tagger.feedback.style.width = (event.pageX - tagger.clickX) + "px";
				tagger.feedback.style.top = (event.pageY) + "px";
				tagger.feedback.style.height = (tagger.clickY - event.pageY) + "px";
			} else {
				//bottom right quadrent
				tagger.feedback.style.width = (event.pageX - tagger.clickX) + "px";
				tagger.feedback.style.height = (event.pageY - tagger.clickY) + "px";
			}
		} else {
			if (event.pageY < tagger.clickY) {
				//Top left quadrent
				tagger.feedback.style.top = (event.pageY) + "px";
				tagger.feedback.style.height = (tagger.clickY - event.pageY) + "px";
				tagger.feedback.style.left = (event.pageX) + "px";
				tagger.feedback.style.width = (tagger.clickX - event.pageX) + "px";
			} else {
				//Bottom left quadrent
				tagger.feedback.style.height = (event.pageY - tagger.clickY) + "px";
				tagger.feedback.style.left = (event.pageX) + "px";
				tagger.feedback.style.width = (tagger.clickX - event.pageX) + "px";
			}
		}

	}
}


Tagger.prototype.mouseUp = function(event) {
	var tagger = this;
	tagger.isMouseDown = false;
	var tag_form = document.forms[tagger.tag_form];
	tag_form.elements[tagger.x_offset_id].value = tagger.feedback.style.left.replace(/\D/g,'');
	tag_form.elements[tagger.y_offset_id].value = tagger.feedback.style.top.replace(/\D/g,'');
	tag_form.elements[tagger.width_id].value = tagger.feedback.style.width.replace(/\D/g,'');
	tag_form.elements[tagger.height_id].value = tagger.feedback.style.height.replace(/\D/g,'');

	document.body.onmousemove = this.oldMoveHandler;
	document.body.onmouseup = this.oldUpHandler;
}