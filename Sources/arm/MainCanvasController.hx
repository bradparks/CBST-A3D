package arm;

import armory.trait.internal.CanvasScript;
import armory.system.Event;

import arm.WorldController;

class MainCanvasController extends iron.Trait {

	static var maincanvas:CanvasScript;
	static var menuCanvas: CanvasScript;

	var world = WorldController;
	var bld = BuildingController;
	var selectedBtn = 0;

	var menuState = 0;
	var selectBldState = 0;

	public function new() {
		super();

		notifyOnInit(init);
		notifyOnUpdate(updateCanvas);
	}

	function init() {
		maincanvas = new CanvasScript("MainCanvas", "Big_shoulders_text.ttf");
		menuCanvas = new CanvasScript("SettingCanvas", "Big_shoulders_text.ttf");

		menuCanvas.setCanvasVisibility(false);
		maincanvas.setCanvasVisibility(true);
		maincanvas.getElement("menu_empty").visible = false;

		Event.add("menu_btn", function(){
			if (menuState == 0){
				maincanvas.getElement("menu_empty").visible = true;
				menuState = 1;
				selectBldState = 0;
			}else if (menuState == 1){
				maincanvas.getElement("menu_empty").visible = false;
				menuState = 0;
				selectedBtn = 0;
			}
		});

		Event.add("housebtn", function(){ selectedBtn = 3; selectBldState == 0 ||selectBldState == 4||selectBldState == 5 ? selectBldState = 3 : selectBldState = 0;});
		Event.add("factorybtn", function(){ selectedBtn = 4; selectBldState == 0 ||selectBldState == 3||selectBldState == 5 ? selectBldState = 4 : selectBldState = 0;});
		Event.add("communitybtn", function(){ selectedBtn = 5; selectBldState == 0 ||selectBldState == 3||selectBldState == 4 ? selectBldState = 5 : selectBldState = 0;});
		Event.add("setting_btn", function(){ 
			selectedBtn = 1;
			menuCanvas.setCanvasVisibility(true);
			maincanvas.setCanvasVisibility(false);
		});
		Event.add("cancelbtn", function(){ 
			selectedBtn = 1;
			menuCanvas.setCanvasVisibility(false);
			maincanvas.setCanvasVisibility(true);
		});

		Event.add("selectbldbtn1", function(){
			switch (selectedBtn){
				case 3: bld.spawnBuilding(1);
				case 4: bld.spawnBuilding(5);
				case 5: bld.spawnBuilding(2);
			}
		});
		Event.add("selectbldbtn2", function(){
			switch (selectedBtn){
				case 4: bld.spawnBuilding(6);
				case 5: bld.spawnBuilding(3);
			}
		});
		Event.add("selectbldbtn3", function(){
			switch (selectedBtn){
				case 4: bld.spawnBuilding(7);
				case 5: bld.spawnBuilding(4);
			}
		});
		Event.add("selectbldbtn4", function(){
			switch (selectedBtn){
				case 4: bld.spawnBuilding(8);
			}
		});
	}

	function updateCanvas() {
		updatePB();
		updateAmount();

		if(selectedBtn == 3 || selectedBtn == 4 || selectedBtn == 5){
			maincanvas.getElement("select_bld_text").text = getTypeFromInt(selectedBtn);
			maincanvas.getElement("select_bld").visible = true;
		}
		if (selectBldState == 0 || menuState == 0){
			maincanvas.getElement("select_bld").visible = false;
		}
		switch (selectedBtn){
			case 3:
				maincanvas.getElement("select_bld_btn_1").text =  "House";
				maincanvas.getElement("select_bld_btn_1").visible = true;
				maincanvas.getElement("select_bld_btn_2").visible = false;
				maincanvas.getElement("select_bld_btn_3").visible = false;
				maincanvas.getElement("select_bld_btn_4").visible = false;
			case 4:
				maincanvas.getElement("select_bld_btn_1").text =  "Sawmill";
				maincanvas.getElement("select_bld_btn_1").visible = true;
				maincanvas.getElement("select_bld_btn_2").text =  "Quarry";
				maincanvas.getElement("select_bld_btn_2").visible = true;
				maincanvas.getElement("select_bld_btn_3").text =  "Steelworks";
				maincanvas.getElement("select_bld_btn_3").visible = true;
				maincanvas.getElement("select_bld_btn_4").text =  "Powerplant";
				maincanvas.getElement("select_bld_btn_4").visible = true;
			case 5:
				maincanvas.getElement("select_bld_btn_1").text =  "Park";
				maincanvas.getElement("select_bld_btn_1").visible = true;
				maincanvas.getElement("select_bld_btn_2").text =  "Garden";
				maincanvas.getElement("select_bld_btn_2").visible = true;
				maincanvas.getElement("select_bld_btn_3").text =  "Sport.C.";
				maincanvas.getElement("select_bld_btn_3").visible = true;
				maincanvas.getElement("select_bld_btn_4").visible = false;
		}
	}

	function updatePB() {
		// maincanvas.getElement("happinesspb").progress_total = world.happiness[1];
		// maincanvas.getElement("happinesspb").progress_at = world.happiness[0];
		maincanvas.getElement("moneypb").progress_total = world.money[1];
		maincanvas.getElement("moneypb").progress_at = world.money[0];
		maincanvas.getElement("woodpb").progress_total = world.woods[1];
		maincanvas.getElement("woodpb").progress_at = world.woods[0];
		maincanvas.getElement("stonepb").progress_total = world.stones[1];
		maincanvas.getElement("stonepb").progress_at = world.stones[0];
		maincanvas.getElement("steelpb").progress_total = world.steels[1];
		maincanvas.getElement("steelpb").progress_at = world.steels[0];
		maincanvas.getElement("electricitypb").progress_total = world.electricity[1];
		maincanvas.getElement("electricitypb").progress_at = world.electricity[0];
	}

	function updateAmount() {
		maincanvas.getElement("money-amt").text = world.money[0] + "/" + world.money[1];
		maincanvas.getElement("wood-amt").text = world.woods[0] + "/" + world.woods[1];
		maincanvas.getElement("stone-amt").text = world.stones[0] + "/" + world.stones[1];
		maincanvas.getElement("steel-amt").text = world.steels[0] + "/" + world.steels[1];
		maincanvas.getElement("electricity-amt").text = world.electricity[0] + "/" + world.electricity[1];
		// maincanvas.getElement("happiness-amt").text = world.happiness[0] + "/" + world.happiness[1];
	}

	static function getTypeFromInt(int: Int):String {
		var type = "";
		switch (int){
			case 3: type = "House";
			case 4: type = "Factory";
			case 5: type = "Community";
		}
		return type;
	}
}
